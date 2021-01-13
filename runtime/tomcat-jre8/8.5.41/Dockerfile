# step 1
FROM tomcat:8.5-jre8-alpine AS base
# Add tools: curl telnet bash openssl git.
RUN set -ex;\
    apk add --no-cache curl busybox-extras bash openssl git;

# step 2
FROM base AS installer
# Add setjavaopts.sh file.
COPY setjavaopts.sh /usr/bin/devops/
# Add executable permissions to setjavaopts.sh files.
RUN set -ex;\
    chmod a+x /usr/bin/devops/setjavaopts.sh;

# step 3
FROM base
LABEL maintainer="devops@inspur.com"
ENV TZ=GMT
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime;\
	  echo '$TZ' > /etc/timezone;
ENV RESERVED_MEGABYTES=256
COPY --from=installer /usr/bin/devops/setjavaopts.sh /usr/bin/devops/setjavaopts.sh