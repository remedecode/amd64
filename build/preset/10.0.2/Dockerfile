FROM registry-jinan-lab.inspurcloud.cn/multiarch/os/debian:9.12.0
LABEL maintainer="devops@inspur.com"
ADD http://git.inspur.com/common/common-dockerfiles/mirrors/raw/master/debian-stretch-tsinghua-http/sources.list /etc/apt/sources.list
ENV PRESET_VERSION=10.0.2
RUN set -ex;\
    apt-get update;\
    apt-get install -y --no-install-recommends \
        curl telnet iputils-ping vim-tiny iproute2 \
        dos2unix file ca-certificates tzdata openssl \
        procps sshpass openssh-client libxml-xpath-perl git wget vim jq;\
    apt-get clean;\
    rm -rf /var/lib/apt/lists/*;

COPY --from=registry-jinan-lab.inspurcloud.cn/service/devops/build/kaniko:1.2.0 /kaniko/crane /bin/

COPY --from=registry-jinan-lab.inspurcloud.cn/openimage/godev:1.0.0 /godev /bin/

COPY --from=registry-jinan-lab.inspurcloud.cn/multiarch/tini-static:0.18.0 /tini/tini-static-amd64 /usr/local/bin/tini

COPY json_array_append set_chart /bin/

ENTRYPOINT ["/usr/local/bin/tini", "--"]




