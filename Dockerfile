# servidor web en el puerto 80
#test2
#test
FROM php:5.6.30-apache


RUN apt-get update -y && apt-get install -y \
&& libfreetype6-dev \
&& libjpeg62-turbo-dev \
&& libmcrypy-dev \
&& libpng12-dev 

RUN docker-php-ext-install -j$(nproc) iconv mcrypt && \
	docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-install pdo_mysql

RUN pecl install redis-3.1.1 \
    && docker-php-ext-enable redis

RUN a2enmod rewrite

COPY php.ini /usr/local/etc/php


EXPOSE 80

# Composer:
RUN apt-get install -y wget zip unzip
COPY composer-install.sh /tmp
RUN /tmp/composer-install.sh


