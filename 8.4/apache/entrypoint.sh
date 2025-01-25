#!/bin/bash
#
# Performs various tasks during startup of the container.

set -euo pipefail

if [ "$(id -u)" -eq 0 ]; then
    # If SET_DOCROOT_OWNER is set to true, then change the UID and GID of the document root 
    # and its contents to www-data.
    if [ "${SET_OWNER}" == "true" ]; then
        chown -R "www-data:www-data" /var/www/html
    fi

    # Set port 80 as the default port for Apache if container is run as root.
    sed -i 's/Listen 8080/Listen 80/g' /etc/apache2/ports.conf && \
    sed -i 's/8080/80/g' /etc/apache2/sites-enabled/000-default.conf
fi

exec /usr/local/bin/docker-php-entrypoint "$@"
