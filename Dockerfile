FROM php:7.3.9-fpm-buster

RUN apt-get update && apt-get install -y \
        supervisor \
        librabbitmq-dev \
        libzip-dev \
        zip \
        libpng-dev \
        ssh \
    && pecl install amqp \
	&& docker-php-ext-configure zip --with-libzip \
	&& docker-php-ext-install zip \
	 bcmath \
	 sockets \
	 pdo_mysql \
	 exif \
	 gd \
	&& docker-php-ext-enable amqp

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN chown -R www-data:www-data /var/www

WORKDIR /var/www/site