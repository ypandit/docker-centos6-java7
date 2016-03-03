FROM centos:centos6.7
MAINTAINER Yogesh Pandit

RUN yum clean all; yum install -y wget sudo which tar vim expect openssh-server openssh-clients openssl-devel openssl mysql mysql-connector-java mysql-libs mysql-server openldap-clients openldap-servers zip

# Nginx
RUN wget nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm; rpm -Uh nginx-release-centos-6-0.el6.ngx.noarch.rpm; rm nginx-release-centos-6-0.el6.ngx.noarch.rpm; yum install -y nginx

# EPEL latest
RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm; rpm -Uh epel-release-latest-6.noarch.rpm; rm epel-release-latest-6.noarch.rpm; yum clean all

# Install Java
ENV JAVA_HOME /usr/java/latest
RUN cd /tmp; wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.rpm; rpm -Uh /tmp/jdk-7u80-linux-x64.rpm; rm /tmp/jdk-7u80-linux-x64.rpm

RUN update-alternatives --install "/usr/bin/java" "java" "${JAVA_HOME}/bin/java" 1 && \
    update-alternatives --install "/usr/bin/javaws" "javaws" "${JAVA_HOME}/bin/javaws" 1 && \
    update-alternatives --install "/usr/bin/javac" "javac" "${JAVA_HOME}/bin/javac" 1 && \
    update-alternatives --set java "${JAVA_HOME}/bin/java" && \
    update-alternatives --set javaws "${JAVA_HOME}/bin/javaws" && \
    update-alternatives --set javac "${JAVA_HOME}/bin/javac"

# Set Java PATH
ENV PATH $JAVA_HOME/bin:$PATH

CMD ["/bin/bash"]
