#registry.icp.com:5000/service/devops/build/node:10.21.0
FROM  node:12.18-alpine
LABEL maintainer="devops@inspur.com"
# Add tools: curl telnet git bash.
RUN set -ex;\
    apk add --no-cache curl busybox-extras git bash;
