# Use PHP 8.2 image
FROM php:8.2-cli

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    git \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg

# Set the working directory
WORKDIR /var/www/html

# Copy the project files to the container
COPY . /var/www/html

# Add safe directory to Git configuration to resolve ownership issue
RUN git config --global --add safe.directory /var/www/html

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP dependencies via Composer
RUN composer -n validate --strict ; \
    composer -n install --no-scripts --ignore-platform-reqs --no-dev


# Expose port 9090
EXPOSE 9090

# Set the default command to serve the application
CMD ["php", "yii", "serve", "0.0.0.0", "--port=9090"]
