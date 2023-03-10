FROM php:fpm-alpine

MAINTAINER haruvon https://github.com/haruvon5/Perlite

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && chmod +x /usr/local/bin/install-php-extensions \
    && install-php-extensions yaml \
    && apk add --no-cache nginx \
    && rm /etc/nginx/http.d/default.conf

WORKDIR /var/www/perlite/
COPY ./perlite/*.php ./
COPY ./perlite/*.svg ./
COPY ./perlite/*.ico ./
COPY ./perlite/.styles/ ./.styles/
COPY ./perlite/.js/ ./.js/
COPY ./entrypoint.sh /etc/entrypoint.sh
COPY ./web/config/ /etc/nginx/http.d/

VOLUME /var/www/perlite/

EXPOSE 9000
EXPOSE 80

ENTRYPOINT ["sh", "/etc/entrypoint.sh"]
