# PHP Images for use with TYPO3

PHP Docker images configured for TYPO3. They are meant as base images for my [TYPO3 Images](https://github.com/crinis/typo3-docker), but can also be used for e.g. local development with composer.

## PHP 8.4 and higher

Images from PHP 8.4 accept connections on port 8080 and include [Supercronic](https://github.com/aptible/supercronic) to allow rootless usage.

You should run two containers of this image at once if you want to run the TYPO3 scheduler as a cronjob as shown in the [podman-compose.yaml](podman-compose.yaml).

## Tags

You can see all our tags [here](https://hub.docker.com/repository/docker/crinis/typo3-php/tags). PHP images will only be updated as long as the used PHP-Version are supported. You can find currently supported PHP-Versions [here](https://www.php.net/supported-versions.php).

## Scheduler

To run the TYPO3 scheduler via cronjob you have to add a crontab file. You can create a child image and add a crontab file as a volume or Kubernetes ConfigMap.

```
FROM crinis/typo3-php:latest
RUN echo "*/5 * * * * /usr/local/bin/php /var/www/html/typo3/sysext/core/bin/typo3 scheduler:run" > /var/spool/cron/crontabs/www-data && \
    chmod 600 /var/spool/cron/crontabs/www-data
```

### Using supercronic

You can extend the image like this to add a cronjob or add a crontab file as a volume or Kubernetes ConfigMap.

```
FROM crinis/typo3-php:8.4-apache
RUN echo "*/5 * * * * php /var/www/html/public/typo3/sysext/core/bin/typo3 scheduler:run" > /custom/crontab
```

## Authors

* [Crinis](https://github.com/crinis)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details. The image contains software that use different licenses.
