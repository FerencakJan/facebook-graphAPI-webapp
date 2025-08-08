# Use official PHP image with CLI tools
FROM php:8.2-cli

# Set working directory inside the container
WORKDIR /app

# Install Composer from official Composer image
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy the entire Symfony project into the container
COPY . .

# Install required PHP extensions for Symfony and Doctrine
RUN apt-get update && apt-get install -y \
    unzip \
    zip \
    libzip-dev \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql zip

# Install PHP dependencies using Composer
RUN composer install --no-dev --optimize-autoloader

# Start the Symfony app with PHP's built-in web server
CMD php -S 0.0.0.0:8000 -t public
