FROM gradle:4.10-jdk7-alpine
LABEL maintainer="devops@inspur.com"
USER root
# Add tools: curl telnet git bash.
RUN set -ex;\
    apk add --no-cache curl busybox-extras git bash;
