FROM node:10-alpine
LABEL maintainer="devops@inspur.com"
# Add tools: curl telnet git bash.
RUN set -ex;\
    apk add --no-cache curl busybox-extras git bash;
ENV GITBOOK_VERSION=3.2.3
# Install: gitbook-cli gitbook.
RUN set -ex;\
    npm install -g gitbook-cli;\
    gitbook fetch ${GITBOOK_VERSION};\
    npm cache clean -f;\
    rm -rf /tmp/*;
CMD ["/bin/sh"]
