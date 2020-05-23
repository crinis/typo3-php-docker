FROM php:7.4-apache-buster

ENV SERVER_ADMIN_EMAIL="you@example.com"

RUN savedAptMark="$(apt-mark showmanual)" && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        libfreetype6-dev \
        libtool \
        libjpeg-dev \
        libpng-dev \
        libxml2-dev \
        libicu-dev \
        libyaml-dev \
        libzip-dev \
    && \
    rm -rf /var/lib/apt/lists/* && \
    export CFLAGS="$PHP_CFLAGS" CPPFLAGS="$PHP_CPPFLAGS" LDFLAGS="$PHP_LDFLAGS" && \
    pecl install apcu yaml && \
    docker-php-ext-configure gd \
        --enable-gd \
        --with-freetype=/usr \
        --with-jpeg=/usr \
    && \
    docker-php-ext-configure intl --enable-intl && \
    docker-php-ext-install gd mysqli opcache zip intl && \
    docker-php-ext-enable apcu yaml && \
    apt-mark auto '.*' > /dev/null && \
    apt-mark manual $savedAptMark && \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        imagemagick \
        ghostscript \
        nano \
        libyaml-0-2 \
        cron \
        wget \
        unzip \
        supervisor \
        libzip4 \
    && \
    rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite expires headers

# Add recommended opcache settings from https://secure.php.net/manual/en/opcache.installation.php
COPY opcache-recommended.ini /usr/local/etc/php/conf.d/opcache-recommended.ini
COPY typo3-php.ini /usr/local/etc/php/conf.d/typo3.ini
COPY typo3-apache2.conf /etc/apache2/conf-enabled/typo3.conf
COPY supervisord.conf /etc/supervisor/supervisord.conf

VOLUME /var/www/html

ENTRYPOINT ["docker-php-entrypoint"]
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
