FROM centos

MAINTAINER cbping "452775680@qq.com"

# Compile environment installation
RUN yum -y install gcc-c++ make readline-devel openssl-devel krb5-devel pcre-devel libcurl-devel perl-devel php-devel php-pdo \
python-devel ruby-devel ruby-libs ruby tcl-devel java-1.7.0-openjdk-devel \
mariadb-devel postgresql-devel sqlite-devel unixODBC-devel

# download sqlrelay
RUN yum -y install wget && \
    cd /opt/ && \
	wget http://downloads.sourceforge.net/sqlrelay/sqlrelay-1.1.0.tar.gz &&  \
	wget http://downloads.sourceforge.net/rudiments/rudiments-1.0.5.tar.gz

# tar
RUN cd /opt/  &&\
    tar -xvf  rudiments-1.0.5.tar.gz &&\
    tar -xvf  sqlrelay-1.1.0.tar.gz

# build and install sqlrelay
RUN cd /opt/rudiments-1.0.5 &&\
    ./configure --prefix=/opt/firstworks &&\
     make && make install 

RUN cd /opt/sqlrelay-1.1.0 && \ 
   ./configure --prefix=/opt/firstworks  --with-rudiments-prefix=/opt/firstworks &&\
     make && make install

# Delete residual useless files
RUN rm -f /opt/rudiments-1.0.5.tar.gz && \
    rm -f /opt/sqlrelay-1.1.0.tar.gz  && \
    rm -rf /opt/rudiments-1.0.5       && \
    rm -rf /opt/sqlrelay-1.1.0

ENV PATH /opt/firstworks/bin:$PATH

#ENTRYPOINT ["sqlr-start","-config"]
CMD [""]


