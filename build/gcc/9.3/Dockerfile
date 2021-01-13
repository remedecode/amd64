FROM gcc:9.3

#RUN apt-get purge -y cmake

#WORKDIR /tmp/cmake
#RUN wget https://cmake.org/files/v3.14/cmake-3.14.3.tar.gz && \
#    tar -xzvf cmake-3.14.3.tar.gz > /dev/null

#WORKDIR cmake-3.14.3
#RUN ./bootstrap > /dev/null && \
#    make -j$(nproc --all) > /dev/null && \
#    make install > /dev/null

#WORKDIR /
#RUN rm -rf /tmp/cmake && \
#    apt-get update && \
#    apt-get install -y flex bison vim
WORKDIR /tmp/cgi
ADD http://git.inspur.com/common/common-dockerfiles/file/raw/master/gcc/cgicc-3.2.19.tar.gz \
    http://git.inspur.com/common/common-dockerfiles/file/raw/master/gcc/fcgi-2.4.0.tar.gz \
    http://git.inspur.com/common/common-dockerfiles/file/raw/master/gcc/config.guess \
    ./
RUN tar -xzvf cgicc-3.2.19.tar.gz && \
    tar -xzvf fcgi-2.4.0.tar.gz && \
    rm cgicc-3.2.19.tar.gz && \
    rm fcgi-2.4.0.tar.gz && \
    cd cgicc-3.2.19 && \
    ./configure && \
    make && \
    make install && \
    cd ../ && \
    cp config.guess fcgi-2.4.0 && \
    cd fcgi-2.4.0 && \
    ./configure && \
    make && \
    make install