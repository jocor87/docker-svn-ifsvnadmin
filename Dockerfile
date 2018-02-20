FROM ubuntu:16.04
MAINTAINER jcordero1987@gmail.com
ENV DEBIAN_FRONTEND noninteractive
WORKDIR /tmp
# Install apache2, php 5.6, subversion, IF.SVNAdmin
RUN apt update && \
    apt install --no-install-recommends -y software-properties-common && \
    LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php && \
    apt update && \
    apt install --no-install-recommends -y apache2 libapache2-mod-php5.6 php5.6-xml subversion-tools libapache2-mod-svn libapache2-svn curl unzip && \
    curl -L https://sourceforge.net/projects/ifsvnadmin/files/svnadmin-1.6.2.zip/download > svnadmin-1.6.2.zip && \
    unzip svnadmin-1.6.2.zip -d /var/www/html/ && rm -f svnadmin-1.6.2.zip && mv /var/www/html/iF.SVNAdmin-stable-1.6.2 /var/www/html/svnadmin && \
    apt remove -y python-software-properties software-properties-common curl unzip && \
    apt clean && apt autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /home/ubuntu/svndata && \
    mkdir /etc/apache2/conf && \
    touch /etc/apache2/conf/dav_svn.passwd && \
    touch /etc/apache2/conf/access_svn && \
    chown www-data /etc/apache2/conf/dav_svn.passwd && \
    chown www-data /etc/apache2/conf/access_svn && \
    a2dismod -f autoindex

# Manually set up the apache environment variables
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV SVN_LOCATION svnrepos

RUN echo '\n\
<location /${SVN_LOCATION}>\n\
    DAV svn\n\
    SVNParentPath /home/ubuntu/svndata/\n\
    AuthType Basic\n\
    AuthName "Repositorios Subversion"\n\
    AuthUserFile /etc/apache2/conf/dav_svn.passwd\n\
    Require valid-user\n\
    AuthzSVNAccessFile /etc/apache2/conf/access_svn\n\
 </location>\n'\
>> /etc/apache2/mods-enabled/dav_svn.conf

RUN chmod 777 /var/www/html/svnadmin/data

# Expose apache.
EXPOSE 80

CMD /usr/sbin/apache2ctl -D FOREGROUND
