FROM php:7.4-fpm-alpine

# Install dependencies and PHP extensions
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

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set the working directory
WORKDIR /var/www/html

# Copy the application files into the container
COPY . /var/www/html

# Install PHP dependencies with Composer
RUN composer install --no-dev --optimize-autoloader

# Copy Nginx configuration
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Set proper permissions for the application files
RUN chown -R www-data:www-data /var/www/html/runtime
RUN chmod -R 755 /var/www/html/runtime
RUN chown -R www-data:www-data /var/www/html/web
RUN chmod -R 755 /var/www/html/web
RUN chown -R www-data:www-data /var/www/html

# Expose the port Nginx will run on
EXPOSE 8080

# Start PHP-FPM and Nginx
CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]
