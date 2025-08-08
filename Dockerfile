# Use official PHP image with required extensions
FROM php:8.2-cli

# Install system dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    libicu-dev \
    libonig-dev \
    libzip-dev \
    zip \
    libpq-dev \
    && docker-php-ext-install intl pdo pdo_mysql opcache zip

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Allow Composer plugins and root usage (important for Render)
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV SYMFONY_ALLOW_APP_DEV=true
ENV APP_ENV=prod

# Install dependencies
RUN composer install --no-dev --optimize-autoloader

# Expose port (optional, for local testing)
EXPOSE 8000

# Start Symfony app using PHP’s built-in server
CMD ["php", "-S", "0.0.0.0:8000", "-t", "public"]
