FROM centos

LABEL MAINTAINER="xiaofei.wang@bwoil.com"

# download and tar sqlrelay
RUN yum -y install wget openssl krb5-libs pcre libcurl readline perl php php-pdo python ruby ruby-libs tcl java-1.7.0-openjdk mariadb-libs postgresql-libs sqlite unixODBC libaio

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
# RUN chgrp -R sqlrelay /var
# RUN chown -R sqlrelay /var

ENTRYPOINT ["/opt/bin/sqlr-entrypoint.sh"]

