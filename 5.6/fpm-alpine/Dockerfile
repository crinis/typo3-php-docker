FROM php:5.6-fpm-alpine3.8

RUN apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS \
        freetype-dev \
        libtool \
        libjpeg-turbo-dev \
        libpng-dev \
        libxml2-dev \
    && \
    export CFLAGS="$PHP_CFLAGS" CPPFLAGS="$PHP_CPPFLAGS" LDFLAGS="$PHP_LDFLAGS" && \
    pecl install apcu-4.0.11 && \
    docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr \
        --with-png-dir=/usr \
        --with-jpeg-dir=/usr \
    && \
    docker-php-ext-install gd mysqli opcache zip soap && \
    docker-php-ext-enable apcu && \
    apk del .phpize-deps

RUN apk add --no-cache \
        imagemagick \
        ghostscript \
        bash \
        nano \
        tzdata \
        curl \
        wget \
        unzip \
        supervisor \
    && \
    sed -i '/\(default_bits\|default_md\)/s/^# *//' /etc/ssl/openssl.cnf

# Add recommended opcache settings from https://secure.php.net/manual/en/opcache.installation.php
COPY opcache-recommended.ini /usr/local/etc/php/conf.d/opcache-recommended.ini
COPY typo3-php.ini /usr/local/etc/php/conf.d/typo3.ini
COPY supervisord.conf /etc/supervisor/supervisord.conf

VOLUME /var/www/html

ENTRYPOINT ["docker-php-entrypoint"]
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
