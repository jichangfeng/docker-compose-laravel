FROM jichangfeng/php:5.6.40-fpm
MAINTAINER Changfeng Ji <jichf@qq.com>

RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

RUN apt-get update \
&& apt-get install -y --allow-unauthenticated git curl wget ca-certificates openssl tree \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

CMD ["php-fpm"]
