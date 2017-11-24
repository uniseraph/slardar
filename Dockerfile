FROM centos:7

RUN yum -y update &&  yum -y install epel-release && \
    yum -y install make perl  wget gcc gcc-c++ patch zlib-devel file && \
    yum clean all

ADD patches /src/patches
ADD util /src/util
ADD Makefile /src/
ADD nginx /src/nginx

EXPOSE 8080 1995

RUN cd /src && make configure && make && make install && rm -fr /src

CMD ["/usr/local/slardar/nginx/sbin/nginx", "-g", "daemon off;"]
