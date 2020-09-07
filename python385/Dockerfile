FROM centos:centos7.6.1810

USER root

# 时区设置
ENV TZ "Asia/Shanghai"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 编译工具及相关依赖程序
RUN yum -y install gcc-c++ make autoconf
RUN yum -y install wget
RUN yum -y install libsndfile zlib-devel libffi-devel openssl-devel

# https://www.python.org/ftp/python/3.8.5/Python-3.8.5.tgz
RUN wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-infobird/fd2f4580-f0b2-11ea-8bd0-2998ac5bbf7e.tgz -O Python-3.8.5.tgz \
    && tar zxvf Python-3.8.5.tgz \
    && cd Python-3.8.5 \
    && ./configure --prefix /usr/local/python385 \
    && make && make install \
    && /usr/local/python385/bin/python3 -m pip install -i https://mirrors.aliyun.com/pypi/simple/ --upgrade pip \
    && /usr/local/python385/bin/pip3 install -i https://mirrors.aliyun.com/pypi/simple/ virtualenv \
    && ln -s /usr/local/python385/bin/python3 /bin/python3 \
    && ln -s /usr/local/python385/bin/pip3 /bin/pip3 \
    && ln -s /usr/local/python385/bin/virtualenv /bin/virtualenv3 

# app 项目目录
WORKDIR /usr/src/myapp

CMD [ "python3", "--version" ]