FROM php:8.4-apache-bookworm

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
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
    mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        imagemagick \
        ghostscript \
        nano \
        libyaml-0-2 \
        cron \
        unzip \
        wget \
        unzip \
        libzip4 \
    && \
    rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite expires headers

RUN sed -i 's/\/var\/www\/html/\/var\/www\/html\/public/g' /etc/apache2/sites-enabled/000-default.conf && \
    sed -i 's/Listen 80/Listen 8080/g' /etc/apache2/ports.conf && \
    sed -i 's/80/8080/g' /etc/apache2/sites-enabled/000-default.conf

ARG SUPERCRONIC_SHA1SUM=71b0d58cc53f6bd72cf2f293e09e294b79c666d8
ARG SUPERCRONIC_VERSION=0.2.33
ARG SUPERCRONIC_ARCHITECTURE=amd64
ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v${SUPERCRONIC_VERSION}/supercronic-linux-${SUPERCRONIC_ARCHITECTURE} \
    SUPERCRONIC=supercronic-linux-${SUPERCRONIC_ARCHITECTURE} \
    SUPERCRONIC_SHA1SUM=${SUPERCRONIC_SHA1SUM}

RUN curl -fsSLO "$SUPERCRONIC_URL" && \
    echo "${SUPERCRONIC_SHA1SUM}  ${SUPERCRONIC}" | sha1sum -c - && \
    chmod +x "$SUPERCRONIC" && \
    mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" && \
    ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic

COPY php/ /usr/local/etc/php/conf.d/

VOLUME /var/www/html
