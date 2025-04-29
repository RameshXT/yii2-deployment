FROM php:8.2-cli

RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    git \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg

WORKDIR /var/www/html

COPY . /var/www/html

RUN git config --global --add safe.directory /var/www/html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer -n validate --strict ; \
    composer -n install --no-scripts --ignore-platform-reqs --no-dev

EXPOSE 9090

CMD ["php", "yii", "serve", "0.0.0.0", "--port=9090"]
