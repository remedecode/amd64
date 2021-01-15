FROM alpine:3.12.3 As base
WORKDIR /
RUN wget https://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-8/v8.5.61/bin/apache-tomcat-8.5.61.tar.gz;\
    tar -xzvf apache-tomcat-8.5.61.tar.gz;

FROM registry.cn-hangzhou.aliyuncs.com/wangshibin/openjdk:1.8.275
COPY --from=base /apache-tomcat-8.5.61 /usr/local/tomcat
ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH=$PATH:$CATALINA_HOME/bin
LABEL maintainer="devops@inspur.com"
