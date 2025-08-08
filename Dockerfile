FROM php:8.3-cli

# Install dependencies
RUN apt-get update && apt-get install -y \
    git unzip libzip-dev libicu-dev zlib1g-dev libonig-dev curl \
    && docker-php-ext-install intl pdo pdo_mysql zip opcache

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /app

# Copy all files
COPY . .

# Allow Composer to run as root
ENV COMPOSER_ALLOW_SUPERUSER=1

# Install PHP dependencies including scripts
RUN composer install --no-dev --optimize-autoloader

# Expose port (if using PHP dev server)
EXPOSE 8000

# Start Symfony with PHP's built-in web server
CMD ["php", "-S", "0.0.0.0:8000", "-t", "public"]
