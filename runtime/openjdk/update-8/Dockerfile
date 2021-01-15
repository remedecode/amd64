FROM registry.cn-hangzhou.aliyuncs.com/wangshibin/openjdk:update-ziyuan As openjdk-reousrce
WORKDIR /
RUN tar -xzvf OpenJDK8U-jdk_x64_linux_8u275b01.tar.gz

FROM alpine:3.12.3 As base
WORKDIR /
RUN apk add --no-cache bash fontconfig ttf-dejavu;\
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub;\
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-2.32-r0.apk;\
    apk add --no-cache glibc-2.32-r0.apk;\
    rm -rf glibc-2.32-r0.apk;\
    rm -rf /var/cache/apk/*;

FROM base
COPY --from=openjdk-reousrce /openjdk-8u275-b01 /opt/

