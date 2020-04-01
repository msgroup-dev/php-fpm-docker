FROM php:7.3.11-fpm-alpine3.10

RUN apk update \
    && apk add --no-cache rabbitmq-c-dev libpng-dev php7-pear php7-dev gcc musl-dev make icu-dev libzip-dev

RUN docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install bcmath pdo_mysql sockets gd exif intl zip\
    && pecl install amqp \
    && docker-php-ext-enable amqp

RUN apk del php7-pear php7-dev gcc musl-dev make

RUN chown -R www-data:www-data /var/www

WORKDIR /var/www/site