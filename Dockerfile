FROM php:8.2-cli

RUN apt-get update && apt-get install -y --no-install-recommends \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    git \
    unzip \
    curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer --version

WORKDIR /var/www/html

COPY composer.json composer.lock /var/www/html/

RUN composer install --no-dev --no-scripts --ignore-platform-reqs --no-autoloader \
    && composer clear-cache

COPY . /var/www/html

RUN git config --global --add safe.directory /var/www/html

EXPOSE 9090

CMD ["php", "yii", "serve", "0.0.0.0", "--port=9090"]
