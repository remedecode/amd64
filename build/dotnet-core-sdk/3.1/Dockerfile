FROM mcr.microsoft.com/dotnet/core/sdk:3.1-alpine
LABEL maintainer="devops@inspur.com"
# Add tools: curl telnet git bash.
RUN set -ex;\
    apk add --no-cache curl busybox-extras git bash;
