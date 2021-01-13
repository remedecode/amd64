FROM nginx:1.16-alpine
LABEL maintainer="devops@inspur.com"
# Add tools: curl and telnet.
RUN set -ex;\
    apk add --no-cache curl busybox-extras;
# Enable nginx gzip config.
COPY gzip.conf /etc/nginx/conf.d/
ENV TZ=GMT
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime;\
    echo '$TZ' > /etc/timezone;
