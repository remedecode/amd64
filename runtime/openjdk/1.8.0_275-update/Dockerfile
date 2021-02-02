#docker build -t registry-jinan-lab.inspurcloud.cn/service/devops/runtime/openjdk:1.8.0_275 .
FROM registry.cn-hangzhou.aliyuncs.com/wangshibin/openjdk:update-ziyuan As openjdk-reousrce
WORKDIR /
COPY setjavaopts.sh /usr/bin/devops/
RUN set -ex;\
    chmod a+x /usr/bin/devops/setjavaopts.sh;\
    tar -xzvf OpenJDK8U-jdk_x64_linux_8u275b01.tar.gz;

FROM alpine:3.12.3 As base
WORKDIR /
RUN apk add --no-cache bash curl busybox-extras openssl git fontconfig ttf-dejavu;\
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub;\
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-2.32-r0.apk;\
    apk add --no-cache glibc-2.32-r0.apk dos2unix file ca-certificates tzdata procps libltdl libgcc libstdc++;\
    rm -rf glibc-2.32-r0.apk;\
    rm -rf /var/cache/apk/*;

FROM base
ENV TZ=GMT
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime;\
    echo '$TZ' > /etc/timezone;
ENV RESERVED_MEGABYTES=256
COPY --from=openjdk-reousrce /openjdk-8u275-b01 /opt/openjdk-8u275-b01
COPY --from=openjdk-reousrce /usr/bin/devops/setjavaopts.sh /usr/bin/devops/setjavaopts.sh
ENV JAVA_HOME=/opt/openjdk-8u275-b01
ENV PATH=$PATH:$JAVA_HOME/bin
LABEL maintainer="devops@inspur.com"