# docker build --network host -t registry.icp.com:5000/multiarch/build/golang:1.14.9 .
FROM golang:1.15.6-buster
LABEL maintainer="devops@inspur.com"
ADD http://git.inspur.com/common/common-dockerfiles/mirrors/raw/master/debian-buster-tsinghua-http/sources.list /etc/apt/sources.list
RUN set -ex;\
    apt-get update;\
    apt-get install -y --no-install-recommends \
        curl telnet iputils-ping vim-tiny iproute2 dos2unix file \
        ca-certificates tzdata openssl procps \
        git;\
    apt-get clean;\
    rm -rf /var/lib/apt/lists/*;
COPY --from=registry-jinan-lab.inspurcloud.cn/multiarch/tini-static:0.18.0 /tini/tini-static-amd64 /usr/local/bin/tini
# COPY --from=registry.icp.com:5000/multiarch/qemu-user-static:4.2.50 /qemu/qemu-aarch64-static /usr/bin/qemu-aarch64-static
# COPY --from=registry.icp.com:5000/multiarch/qemu-user-static:4.2.50 /qemu/qemu-mips64el-static /usr/bin/qemu-mips64el-static
ENTRYPOINT ["/usr/local/bin/tini", "--"]
CMD ["bash"]