# docker build --network host -t registry.icp.com:5000/multiarch/runtime/openjdk:1.8.242 -f Dockerfile ../../../../context-java/
FROM registry.icp.com:5000/multiarch/os/alpine:3.11.3-with-git AS base
LABEL maintainer="devops@inspur.com"
RUN set -ex;\
    apk add --no-cache \
        openjdk8 \
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