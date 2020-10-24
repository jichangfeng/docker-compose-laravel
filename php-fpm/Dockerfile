FROM php:7.3.23-fpm
MAINTAINER Changfeng Ji <jichf@qq.com>

COPY sources.list   /etc/apt/sources.list
COPY buster.list   /etc/apt/sources.list.d/
COPY bravo_0.4.0.tar.gz   /opt/bravo_0.4.0.tar.gz

# Install modules
RUN apt-get update && apt-get install -y \
        wget \
        git \
        libxml2-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libpq-dev \
        libmcrypt-dev \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && docker-php-ext-install -j$(nproc) pdo_pgsql \
    && docker-php-ext-install -j$(nproc) bcmath \
    && docker-php-ext-install -j$(nproc) intl \
    && docker-php-ext-install -j$(nproc) soap \
    && docker-php-ext-install -j$(nproc) sockets \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd


RUN pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && echo "xdebug.remote_enable=On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini


# bravo
RUN mkdir -p /opt/bravo \
    && tar -zxf /opt/bravo_0.4.0.tar.gz -C /opt/bravo \
    && cd /opt/bravo/ext \
    && phpize \
    && ./configure --silent --enable-bravo --with-php-config=php-config \
    && make \
    && make install \
    && cd /opt \
    && rm -rf /opt/bravo \
    && docker-php-ext-enable bravo


# deprecated
RUN pecl install mcrypt-1.0.2 \
    && docker-php-ext-enable mcrypt


RUN pecl install redis \
    && docker-php-ext-enable redis


RUN apt-get install -y \
        libzip-dev \
        zip \
  && docker-php-ext-configure zip --with-libzip \
  && docker-php-ext-install zip


# Install tools
RUN apt-get update && \
    apt-get install -y pngquant --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* 

CMD ["php-fpm"]
