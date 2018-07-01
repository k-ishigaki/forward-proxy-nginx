FROM ubuntu
MAINTAINER k-ishigaki <k-ishigaki@frontier.hokudai.ac.jp>

#ENV PATH=/root/.pyenv/bin:$PATH

# build and install nginx with https support
RUN apt-get update &&\
    cd /tmp &&\
    apt-get install -y git wget gcc libpcre3-dev zlib1g-dev build-essential apache2-utils &&\
    git clone https://github.com/chobits/ngx_http_proxy_connect_module.git &&\
    wget http://nginx.org/download/nginx-1.14.0.tar.gz &&\
    tar -xzvf nginx-1.14.0.tar.gz &&\
    cd nginx-1.14.0/ &&\
    patch -p1 < ../ngx_http_proxy_connect_module/patch/proxy_connect_1014.patch &&\
    ./configure --add-module=../ngx_http_proxy_connect_module &&\
    make && make install

EXPOSE 8888

COPY nginx.conf /usr/local/nginx/conf/

