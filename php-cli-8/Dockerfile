FROM php:8.2-cli
MAINTAINER Changfeng Ji <jichf@qq.com>

RUN curl -sSLf \
        -o /usr/local/bin/install-php-extensions \
        https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions && \
    chmod +x /usr/local/bin/install-php-extensions

RUN install-php-extensions amqp
RUN install-php-extensions ast
RUN install-php-extensions bcmath
RUN install-php-extensions intl
RUN install-php-extensions gd
RUN install-php-extensions imagick
RUN install-php-extensions event
RUN install-php-extensions memcache
RUN install-php-extensions memcached
RUN install-php-extensions msgpack
RUN install-php-extensions mysqli
RUN install-php-extensions mcrypt
RUN install-php-extensions pcntl
RUN install-php-extensions pdo_mysql
RUN install-php-extensions pdo_pgsql
RUN install-php-extensions pgsql
RUN install-php-extensions redis
RUN install-php-extensions soap
RUN install-php-extensions sockets
RUN install-php-extensions swoole
RUN install-php-extensions SeasLog
RUN install-php-extensions sysvmsg
RUN install-php-extensions sysvsem
RUN install-php-extensions sysvshm
RUN install-php-extensions uuid
RUN install-php-extensions xdebug
RUN install-php-extensions xhprof
RUN install-php-extensions zlib
RUN install-php-extensions zip
RUN install-php-extensions zookeeper
RUN install-php-extensions mongodb
RUN install-php-extensions @composer

RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

RUN apt-get update \
&& apt-get install -y git wget tree cups-client smbclient \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh && \
    ln -s /usr/local/bin/entrypoint.sh /
ENTRYPOINT ["entrypoint.sh"]

CMD ["php"]
