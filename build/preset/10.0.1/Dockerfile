FROM registry-jinan-lab.inspurcloud.cn/service/devops/build/kaniko:1.2.0 AS crane

FROM registry-jinan-lab.inspurcloud.cn/multiarch/os/debian:9.12.0
LABEL maintainer="devops@inspur.com"
ADD http://git.inspur.com/common/common-dockerfiles/mirrors/raw/master/debian-stretch-tsinghua-http/sources.list /etc/apt/sources.list
ENV PRESET_VERSION=10.0.1
RUN set -ex;\
    apt-get update;\
    apt-get install -y --no-install-recommends \
        sshpass openssh-client libxml-xpath-perl git vim;\
    apt-get clean;\
    rm -rf /var/lib/apt/lists/*;
COPY --from=crane /kaniko/crane /bin/
