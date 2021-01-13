FROM registry.icp.com:5000/multiarch/os/debian:9.12.0
LABEL maintainer="devops@inspur.com"
ADD http://git.inspur.com/common/common-dockerfiles/mirrors/raw/master/debian-stretch-tsinghua-http/sources.list /etc/apt/sources.list
RUN set -ex;\
    apt-get update;\
    apt-get install -y --no-install-recommends \
    curl telnet iputils-ping vim-tiny iproute2 dos2unix file \
    ca-certificates tzdata openssl procps;\
    apt-get clean;\
    rm -rf /var/lib/apt/lists/*;
COPY --from=registry.icp.com:5000/multiarch/tini-static:0.18.0 /tini/tini-static-amd64 /usr/local/bin/tini
ENTRYPOINT ["/usr/local/bin/tini", "--"]
CMD ["bash"]