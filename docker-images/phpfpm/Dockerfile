################################################################################
# Base image
################################################################################

FROM ubuntu:16.04

################################################################################
# Build instructions
################################################################################
ENV sequence=0

# Remove default nginx configs.
RUN rm -f /etc/nginx/conf.d/*

# Install packages
RUN apt-get update && apt-get install -my \
  build-essential \
  curl \
  cron \
  git \
  imagemagick \
  less \
  libssl-dev \
  make \
  nano \
  net-tools \
  openssl \
  wget \
  zip \
  php7.0 \
  php7.0-bcmath \
  php7.0-cli \
  php7.0-curl \
  php7.0-dom \
  php7.0-fpm \
  php7.0-gd \
  # php-imagick \
  php7.0-intl \
  # php7.0-memcached \
  php7.0-mbstring \
  php7.0-mcrypt \
  php7.0-mysql \
  php7.0-simplexml \
  php7.0-soap \
  php7.0-sqlite \
  php7.0-xsl \
  php7.0-zip


################################################################################
# Composer setup
################################################################################
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

################################################################################
# Node setup
################################################################################
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
RUN export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
    nvm install node && \
    nvm use node

# some required directories
RUN mkdir /run/php

################################################################################
# Set up the normal user
################################################################################
RUN useradd -G www-data -m -d /home/webuser -s /bin/bash webuser
RUN mkdir /var/www && chown -R webuser:webuser /var/www

################################################################################
# Finalize the container configuration
################################################################################
# USER webuser
WORKDIR /var/www
COPY entrypoint.sh /root/entrypoint.sh
# ENTRYPOINT ['/root/entrypoint.sh']
CMD ["/usr/sbin/php-fpm7.0", "--nodaemonize"]
# CMD ["tail", "-f", "/dev/null"]
