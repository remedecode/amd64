FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-bionic
LABEL maintainer="devops@inspur.com"
ADD http://git.inspur.com/common/common-dockerfiles/mirrors/raw/master/ubuntu-bionic-tsinghua-http/sources.list /etc/apt/sources.list
RUN set -ex;\
    apt-get update;\
    apt list --upgradable;\
    apt upgrade -y;\
    apt autoremove -y;\
    apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

