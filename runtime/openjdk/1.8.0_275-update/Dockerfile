#docker build -t registry-jinan-lab.inspurcloud.cn/service/devops/runtime/openjdk:1.8.0_275 .
FROM alpine As reousrce
WORKDIR /
COPY setjavaopts.sh /usr/bin/devops/
RUN set -ex;\
    chmod a+x /usr/bin/devops/setjavaopts.sh;

FROM alpine As base
WORKDIR /
RUN apk add --no-cache \
    openjdk8 \
    bash curl busybox-extras openssl git \
    fontconfig ttf-dejavu dos2unix file ca-certificates \
    tzdata procps libltdl libgcc libc6-compat libstdc++;\
    rm -rf /var/cache/apk/*;

FROM base
LABEL maintainer="devops@inspur.com"
ENV TZ=GMT
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime;\
    echo '$TZ' > /etc/timezone;
ENV RESERVED_MEGABYTES=256
COPY --from=reousrce /usr/bin/devops/setjavaopts.sh /usr/bin/devops/setjavaopts.sh
