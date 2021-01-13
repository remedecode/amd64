# docker build --network host -t registry.icp.com:5000/multiarch/runtime/openjdk:1.8.242 -f Dockerfile ../../../../context-java/
FROM registry-jinan-lab.inspurcloud.cn/openimage/dockerhub/alpine:3.12.3 AS base
LABEL maintainer="devops@inspur.com"
RUN set -ex;\
    apk add --no-cache \
        openjdk11 \
        fontconfig ttf-dejavu;\
    rm -rf /var/cache/apk/*;\
    java -version;



FROM base AS installer
COPY setjavaopts.sh /usr/bin/devops/
RUN set -ex;\
    chmod a+x /usr/bin/devops/setjavaopts.sh;

FROM base
ENV TZ=GMT
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime;\
    echo '$TZ' > /etc/timezone;
ENV RESERVED_MEGABYTES=256
COPY --from=installer /usr/bin/devops/setjavaopts.sh /usr/bin/devops/setjavaopts.sh