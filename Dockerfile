# Dockerfile
FROM php:8.2-cli

# Set working directory
WORKDIR /app

# Install dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    unzip \
    zip \
    curl \
    git \
    libzip-dev \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql zip

# Install Composer manually
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Copy app source code
COPY . .

# Install Composer dependencies
RUN composer install --no-dev --optimize-autoloader 

# Start Symfony app using PHP's built-in server
CMD php -S 0.0.0.0:8000 -t public
