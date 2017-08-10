FROM php:7.0-fpm

# Install env
ADD sources.list    /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
        git \
        libgd-dev \
        libgearman-dev \
        libmemcached-dev \
        libmcrypt-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
        libssl-dev \
        libpq-dev \
        libz-dev \
        && rm -r /var/lib/apt/lists/*

#RUN pecl install memcache && echo "extension=memcache.so" > /usr/local/etc/php/conf.d/memcache.ini
RUN pecl install redis && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini

RUN docker-php-ext-configure gd  --with-jpeg-dir=/usr/include --with-freetype-dir=/usr/include \
        && docker-php-ext-install zip \
        && docker-php-ext-install gd \
        && docker-php-ext-install mbstring \
        && docker-php-ext-install mcrypt \
        && docker-php-ext-install pdo_mysql

COPY ./swoole-1.9.14 /home/swoole
RUN cd /home/swoole && phpize && ./configure && make && make install && echo "extension=swoole.so" > /usr/local/etc/php//conf.d/swoole.ini

# PHP config
ADD php.ini    /usr/local/etc/php/php.ini
ADD php-fpm.conf    /usr/local/etc/php-fpm.conf

# Composer
ADD composer.phar /usr/local/bin/composer
RUN chmod 755 /usr/local/bin/composer

WORKDIR /opt

# Write Permission
RUN usermod -u 1000 www-data

EXPOSE 9000
VOLUME ["/opt"]
