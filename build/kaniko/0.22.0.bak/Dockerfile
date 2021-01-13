FROM registry.icp.com:5000/multiarch/build/golang:1.13.8-stretch AS builder
ADD http://git.inspur.com/common/common-dockerfiles/mirrors/raw/master/debian-stretch-tsinghua-http/sources.list /etc/apt/sources.list
RUN set -ex;\
    apt-get update;\
    apt-get install -y --no-install-recommends patch;\
    apt-get clean;\
    rm -rf /var/lib/apt/lists/*;
ADD http://git.inspur.com/common/common-dockerfiles/patch/raw/master/kaniko/0001-self-set-configFile-Architecture-for-v0.22.0-latest.patch /
# build Kaniko
WORKDIR $GOPATH/src/github.com/GoogleContainerTools
RUN set -ex;\
    git clone --depth 1 http://git.inspur.com/common/common-dockerfiles/kaniko.git kaniko;
WORKDIR $GOPATH/src/github.com/GoogleContainerTools/kaniko
RUN patch -p1 -i /0001-self-set-configFile-Architecture-for-v0.22.0-latest.patch
RUN set -ex;\
    \
    make && make out/warmer;\
    ./out/executor version;\
    \
    mkdir -p /kaniko/;\
    mv out/* /kaniko/;\
    cp files/ca-certificates.crt /ca-certificates.crt;\
    touch /config.json;\
    touch /nsswitch.conf;\
    echo "hosts: files dns" >> /nsswitch.conf;
# clone build project
WORKDIR $GOPATH/src/github.com/google/
RUN set -ex;\
    git clone https://github.com/google/go-containerregistry.git go-containerregistry;
WORKDIR $GOPATH/src/github.com/google/go-containerregistry/cmd/crane/
RUN set -ex;\
    echo "build cranehttp";\
    GO111MODULE=off CGO_ENABLED=0 go build -a -ldflags '-extldflags "-static"' -o crane main.go;\
    mv crane /;

# use busybox
FROM busybox:1.31.1 AS installer

# copy files and build image
FROM scratch
LABEL maintainer="devops@inspur.com"
ENV KANIKO_VERSION=v0.22.0
COPY --from=builder /kaniko/* /kaniko/
COPY --from=builder /crane  /crane /kaniko/
COPY --from=installer /bin/ /busybox/
# Declare /busybox as a volume to get it automatically whitelisted
VOLUME /busybox
COPY --from=builder /ca-certificates.crt /kaniko/ssl/certs/
COPY --from=builder /config.json /kaniko/.docker/config.json
COPY --from=builder /nsswitch.conf /etc/
ENV HOME /root
ENV USER /root
ENV PATH $PATH:/kaniko:/busybox
ENV SSL_CERT_DIR=/kaniko/ssl/certs
# Fetch credentials based on your docker config file, which is $HOME/.docker/config.json or $DOCKER_CONFIG.
ENV DOCKER_CONFIG /kaniko/.docker/
# qemu
COPY --from=registry.icp.com:5000/multiarch/qemu-user-static:4.2.50 /qemu/qemu-aarch64-static /usr/bin/qemu-aarch64-static
COPY --from=registry.icp.com:5000/multiarch/qemu-user-static:4.2.50 /qemu/qemu-mips64el-static /usr/bin/qemu-mips64el-static
CMD ["/busybox/sh"]