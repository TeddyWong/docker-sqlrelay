FROM centos

LABEL MAINTAINER="xiaofei.wang@bwoil.com"

# download and tar sqlrelay
RUN yum -y install wget openssl krb5-libs pcre libcurl readline mariadb-libs postgresql-libs libaio

RUN cd /opt/ && \
    wget https://jaist.dl.sourceforge.net/project/sqlrelay/sqlrelay/1.5.2/sqlrelay-binary-distribution-1.5.2.tar.gz && \
    cd /opt/  && \
    tar -xvf  sqlrelay-binary-distribution-1.5.2.tar.gz && \
    cd /opt/sqlrelay-binary-distribution-1.5.2/centos7x64  && \
    yum -y localinstall * && \
    rm -f /opt/sqlrelay-binary-distribution-1.5.2.tar.gz  && \
    rm -rf /opt/sqlrelay-binary-distribution-1.5.2

# ENV PATH /usr/local/firstworks/bin:$PATH
# RUN yum install -y iputils
COPY sqlr-entrypoint.sh /opt/bin/sqlr-entrypoint.sh
RUN chmod +x /opt/bin/sqlr-entrypoint.sh

# RUN groupadd -r sqlrelay && useradd -r -g sqlrelay sqlrelay
# RUN chgrp -R root /var
# RUN chown -R root /var
RUN mkdir /root/run && mkdir /root/run/sqlrelay && mkdir /root/log && mkdir /root/log/sqlrelay

ENTRYPOINT ["/opt/bin/sqlr-entrypoint.sh"]

