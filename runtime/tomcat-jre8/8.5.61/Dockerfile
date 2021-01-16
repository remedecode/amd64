FROM registry-jinan-lab.inspurcloud.cn/service/devops/runtime/openjdk:1.8.0_275 AS base

FROM base AS installer
WORKDIR /
COPY setjavaopts.sh /usr/bin/devops/
RUN set -ex;\
    chmod a+x /usr/bin/devops/setjavaopts.sh;\
    wget https://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-8/v8.5.61/bin/apache-tomcat-8.5.61.tar.gz;\
    tar -xzvf apache-tomcat-8.5.61.tar.gz;


FROM base
LABEL maintainer="devops@inspur.com"
ENV TZ=GMT
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime;\
	  echo '$TZ' > /etc/timezone;
ENV RESERVED_MEGABYTES=256
COPY --from=installer /usr/bin/devops/setjavaopts.sh /usr/bin/devops/setjavaopts.sh
COPY --from=installer /apache-tomcat-8.5.61 /usr/local/tomcat
ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH=$PATH:$CATALINA_HOME/bin