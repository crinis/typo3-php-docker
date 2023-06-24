# PHP Images for use with TYPO3

PHP Docker images configured for TYPO3. They are meant as base images for my [TYPO3 Images](https://github.com/crinis/typo3-docker), but can also be used for e.g. local development with composer.

## Scheduler

To run the TYPO3 scheduler via cronjob you have to add a crontab file. You can create a child image and add a crontab file as a volume or configmap.

```
FROM crinis/typo3-php:latest
RUN echo "*/5 * * * * /usr/local/bin/php /var/www/html/typo3/sysext/core/bin/typo3 scheduler:run" > /var/spool/cron/crontabs/www-data && \
    chmod 600 /var/spool/cron/crontabs/www-data
```

## Rootless use

The images under the `rootless/`directory can be used without root privileges with any user. They accept connection on port 8080 and include [Supercronic](https://github.com/aptible/supercronic) instead of supervisord and cron.
You should run two containers of this image at once if you want to run the TYPO3 scheduler as a cronjob as shown in the podman-compose.yaml.

### Scheduler

You can extend the image like this to add a cronjob or add a crontab file as a volume or configmap.

```
FROM crinis/typo3-php:8.1-apache-rootless
RUN chmod +x /docker/docker-typo3-entrypoint.sh /docker/wait-for-it.sh && \ 
    echo "*/5 * * * * php /var/www/html/public/typo3/sysext/core/bin/typo3 scheduler:run" > /docker/config/crontab
```

## Authors

* [Crinis](https://github.com/crinis)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details. The image contains software that use different licenses.
