############################################################
# Dockerfile to build CentOS,Nginx installed  Container
# Based on CentOS
############################################################

# Set the base image to Ubuntu
FROM centos:centos6

# File Author / Maintainer
MAINTAINER Dhanu Gupta <dhanu.gupta@gmail.com>

# Add the ngix and PHP dependent repository
ADD nginx.repo /etc/yum.repos.d/nginx.repo

# Installing nginx
RUN yum -y install nginx

RUN yum -y install wget java-1.7.0-openjdk java-1.7.0-openjdk-devel

RUN yum clean all

# Installing PHP
#RUN yum -y --enablerepo=remi,remi-php56 install nginx php-fpm php-common php-xml curl php-curl php-pear php-devel php-dev php-pecl-xdebug
#RUN pecl install xdebug

RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm \
    http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && \
    yum --enablerepo=remi,remi-php56 install -y php-fpm php-common \
    php-pecl-amqp php-cli php-pear php-pdo php-pgsql php-pecl-xdebug  \
    php-opcache php-pecl-amqp php-soap php-pecl-memcached php-gd \
    php-mbstring php-mcrypt php-xml && \
    yum clean all



# Install Composer
RUN cd /tmp && curl -sS https://getcomposer.org/installer | php && \
    mv /tmp/composer.phar /usr/local/bin/composer

# Install PHPUnit
RUN cd /tmp && curl https://phar.phpunit.de/phpunit.phar > phpunit.phar && \
    chmod +x phpunit.phar && \
    mv /tmp/phpunit.phar /usr/local/bin/phpunit

# Installing supervisor
RUN yum install -y python-setuptools
RUN easy_install pip
RUN pip install supervisor


RUN sed -i -e "s/;date.timezone =.*/date.timezone = EST/g" /etc/php.ini

# Adding the configuration file of the nginx
ADD nginx.conf /etc/nginx/nginx.conf
ADD default.conf /etc/nginx/conf.d/default.conf

# Adding the configuration file of the Supervisor
ADD supervisord.conf /etc/

ADD index.php /var/www/index.php

ADD index.php /var/www/index.php

ADD /src /var/www/src
ADD /test /var/www/test

RUN chmod -R 0775 /var/www/test

RUN chmod +x /var/www/test/test.sh

# Set the port to 80
EXPOSE 80

ENTRYPOINT ["/var/www/test/test.sh"]

# Executing supervisord
CMD ["supervisord", "-n"]