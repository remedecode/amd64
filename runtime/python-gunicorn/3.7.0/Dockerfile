# nginx-gunicorn-flask with python3

FROM arm64v8/python:3.7-stretch
LABEL author=""
LABEL purpose = ''
#apt-getԴ ʹ163Դ
#RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
#    echo "deb http://mirrors.163.com/debian/ jessie main non-free contrib" >/etc/apt/sources.list && \
#    echo "deb http://mirrors.163.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list && \
#    echo "deb-src http://mirrors.163.com/debian/ jessie main non-free contrib" >>/etc/apt/sources.list && \
#    echo "deb-src http://mirrors.163.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list

RUN apt update
RUN apt install -y nginx supervisor
RUN pip3 install gunicorn -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
RUN pip3 install setuptools -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com

ENV PYTHONIOENCODING=utf-8

# Build folder
RUN mkdir -p /app
WORKDIR /app

# Setup nginx
RUN rm /etc/nginx/sites-enabled/default
COPY nginx_django.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/nginx_django.conf /etc/nginx/sites-enabled/nginx_django.conf

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Setup supervisord
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf


# run sh. Start processes in docker-compose.yml
CMD ["/usr/bin/supervisord"]
