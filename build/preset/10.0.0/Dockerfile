FROM registry.icp.com:5000/multiarch/build/golang:1.13.8-stretch AS builder
ADD http://git.inspur.com/common/common-dockerfiles/mirrors/raw/master/debian-stretch-tsinghua-http/sources.list /etc/apt/sources.list
RUN set -ex;\
    apt-get update;\
    apt-get install -y --no-install-recommends patch;\
    apt-get clean;\
    rm -rf /var/lib/apt/lists/*;
# copy patch files
WORKDIR /
#COPY 0001-fix-crane-for-http-harbor.patch 0001-fix-crane-for-https-harbor.patch /
ADD http://git.inspur.com/common/common-dockerfiles/patch/raw/master/go-containerregistry/0001-fix-crane-for-http-harbor.patch /
ADD http://git.inspur.com/common/common-dockerfiles/patch/raw/master/go-containerregistry/0001-fix-crane-for-https-harbor.patch /
# clone build project
WORKDIR $GOPATH/src/github.com/google/
RUN set -ex;\
    git clone https://github.com/google/go-containerregistry.git go-containerregistry;
# patch and build cranehttp
WORKDIR $GOPATH/src/github.com/google/go-containerregistry/
RUN set -ex;\
    git reset --hard 34fb8ff33bed0fab41a607d21da5860b924ff694;\
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

FROM registry.icp.com:5000/multiarch/os/debian:9.12.0
LABEL maintainer="devops@inspur.com"
ADD http://git.inspur.com/common/common-dockerfiles/mirrors/raw/master/debian-stretch-tsinghua-http/sources.list /etc/apt/sources.list
ENV PRESET_VERSION=10.0.0
RUN set -ex;\
    apt-get update;\
    apt-get install -y --no-install-recommends \
        sshpass openssh-client libxml-xpath-perl git;\
    apt-get clean;\
    rm -rf /var/lib/apt/lists/*;
COPY --from=builder /cranehttp /cranehttps /usr/local/bin/
COPY --from=builder /cranehttp /cranehttps /bin/
