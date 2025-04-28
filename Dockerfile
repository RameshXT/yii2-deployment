FROM php:7.4-fpm-alpine

RUN apk update && apk add --no-cache \
    nginx \
    bash \
    git \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    zip \
    libxml2-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql xml opcache \
    && apk del gcc libpng-dev libjpeg-turbo-dev freetype-dev libxml2-dev

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

COPY . /var/www/html

RUN composer install --no-dev --optimize-autoloader

COPY nginx/default.conf /etc/nginx/conf.d/default.conf

RUN chown -R www-data:www-data /var/www/html/runtime
RUN chmod -R 755 /var/www/html/runtime
RUN chown -R www-data:www-data /var/www/html/web
RUN chmod -R 755 /var/www/html/web

RUN chown -R www-data:www-data /var/www/html

EXPOSE 8000

CMD service php7-fpm start && nginx -g 'daemon off;'
