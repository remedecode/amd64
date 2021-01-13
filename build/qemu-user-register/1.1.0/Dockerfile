FROM busybox
LABEL maintainer="devops@inspur.com"
ENV QEMU_REGISTER_VERSION="1.1.0"
ENV QEMU_BIN_DIR=/kaniko
COPY register.sh /register
COPY qemu-binfmt-conf.sh /qemu-binfmt-conf.sh
RUN chmod +x /register /qemu-binfmt-conf.sh
ENTRYPOINT ["/register"]
CMD ["--reset"]