FROM registry.icp.com:5000/multiarch/build/golang:1.13.8-stretch AS builder
ADD http://git.inspur.com/common/common-dockerfiles/mirrors/raw/master/debian-stretch-tsinghua-http/sources.list /etc/apt/sources.list
RUN set -ex;\
    apt-get update;\
    apt-get install -y --no-install-recommends patch;\
    apt-get clean;\
    rm -rf /var/lib/apt/lists/*;
#COPY 0001-fix-crane-for-http-harbor.patch 0001-fix-crane-for-https-harbor.patch /
ADD http://git.inspur.com/common/common-dockerfiles/patch/raw/master/go-containerregistry/0001-fix-crane-for-http-harbor.patch /
ADD http://git.inspur.com/common/common-dockerfiles/patch/raw/master/go-containerregistry/0001-fix-crane-for-https-harbor.patch /
# build Kaniko
WORKDIR $GOPATH/src/github.com/GoogleContainerTools
RUN set -ex;\
    git clone --depth 1 http://git.inspur.com/common/common-dockerfiles/kaniko.git kaniko;
WORKDIR $GOPATH/src/github.com/GoogleContainerTools/kaniko
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
# patch and build cranehttp
WORKDIR $GOPATH/src/github.com/google/go-containerregistry/
RUN set -ex;\
    git checkout -q 34fb8ff33bed0fab41a607d21da5860b924ff694;\
    patch -p1 -i /0001-fix-crane-for-http-harbor.patch;
WORKDIR $GOPATH/src/github.com/google/go-containerregistry/cmd/crane/
RUN set -ex;\
    echo "build cranehttp";\
    GO111MODULE=off CGO_ENABLED=0 go build -a -ldflags '-extldflags "-static"' -o cranehttp main.go;\
    mv cranehttp /;
# patch and build cranehttps
WORKDIR $GOPATH/src/github.com/google/go-containerregistry/
RUN set -ex;\
    git checkout -- .;\
    patch -p1 -i /0001-fix-crane-for-https-harbor.patch;
WORKDIR $GOPATH/src/github.com/google/go-containerregistry/cmd/crane/
RUN set -ex;\
    echo "build cranehttps";\
    GO111MODULE=off CGO_ENABLED=0 go build -a -ldflags '-extldflags "-static"' -o cranehttps main.go;\
    mv cranehttps /;

# use busybox
FROM busybox:1.31.1 AS installer

# copy files and build image
FROM scratch
LABEL maintainer="devops@inspur.com"
ENV KANIKO_VERSION=1978f1e
COPY --from=builder /kaniko/* /kaniko/
COPY --from=builder /cranehttp  /cranehttps /kaniko/
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