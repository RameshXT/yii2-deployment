FROM php:8.2-cli-alpine AS builder

RUN apk update && apk add --no-cache \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    git \
    unzip \
    curl \
    bash \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer --version

WORKDIR /var/www/html

COPY . /var/www/html

RUN composer install --no-dev --no-scripts --ignore-platform-reqs \
    && composer dump-autoload --optimize \
    && composer clear-cache

FROM php:8.2-cli-alpine AS production

RUN apk update && apk add --no-cache \
    libpng \
    libjpeg-turbo \
    freetype \
    bash

WORKDIR /var/www/html

COPY --from=builder /var/www/html /var/www/html

EXPOSE 9090

CMD ["php", "yii", "serve", "0.0.0.0", "--port=9090"]
