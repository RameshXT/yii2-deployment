FROM php:7.4-fpm-alpine

# 1) system deps + PHP extensions
RUN apk update && apk add --no-cache \
      nginx \
      bash \
      git \
      libpng-dev \
      libjpeg-turbo-dev \
      libfreetype6-dev \
      zip \
      libxml2-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql xml opcache \
    && apk del gcc libpng-dev libjpeg-turbo-dev libfreetype6-dev libxml2-dev

# 2) install Composer
RUN curl -sS https://getcomposer.org/installer \
      | php -- --install-dir=/usr/local/bin --filename=composer

# 3) copy only your Yii2 app
WORKDIR /var/www/html
COPY ./yii2-app/ /var/www/html/

# 4) install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# 5) configure Nginx
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# 6) fix permissions
RUN chown -R www-data:www-data /var/www/html

# 7) expose and start
EXPOSE 80
CMD service php7-fpm start && nginx -g 'daemon off;'
