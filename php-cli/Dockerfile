FROM php:7.3.23-cli
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
    && docker-php-ext-install -j$(nproc) pcntl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd


RUN apt-get install -y libgearman-dev \
    && pecl install gearman \
    && docker-php-ext-enable gearman


RUN pecl install xdebug


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


RUN apt-get install -y \
        libevent-dev \
        libssl-dev \
    && pecl install event \
    && docker-php-ext-enable event


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

# Install Composer
RUN curl https://mirrors.aliyun.com/composer/composer.phar -o /usr/bin/composer && \
    chmod +x /usr/bin/composer && \
    composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

#RUN php -r "copy('https://getcomposer.org/installer', '/composer-setup.php');" && \
#    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
#    php -r "unlink('composer-setup.php');"

COPY entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/entrypoint.sh /
ENTRYPOINT ["entrypoint.sh"]

CMD ["php"]
