FROM php:8.2-fpm

# Copy composer.lock and composer.json
COPY composer.json /var/www/

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    acl \
    locales \
    zip \
    vim \
    wget \
    git \
    curl \
    nodejs \
    npm

RUN apt-get install -y libicu-dev \
    && docker-php-ext-configure intl

RUN npm install -g yarn

# Install extensions
RUN docker-php-ext-install pdo_mysql exif pcntl intl

RUN apt-get install -y libc6-amd64-cross

RUN ln -s /usr/x86_64-linux-gnu/lib64/ /lib64

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get install -y gconf-service libasound2 libatk1.0-0 libcairo2 libcups2 libfontconfig1 libgdk-pixbuf2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libxss1 fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

RUN apt-get -y --no-install-recommends install libxrandr2 libatk1.0-0 libatk-bridge2.0-0 libx11-xcb1 libxcb-dri3-0 libxcomposite1 libxcursor1 libxdamage1 libcups2 libdrm2 libgbm1 libgtk-3-0
RUN apt-get install chromium -y
# Add user
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy existing application directory contents
COPY . /var/www

# Copy existing application directory permissions
COPY --chown=www:www . /var/www

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]