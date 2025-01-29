FROM        debian:bullseye

RUN         apt-get update && apt-get install -y php7.4-fpm php7.4-mysqli \
            php7.4-curl php7.4-gd php7.4-opcache php7.4-mbstring bash tar curl sed && \
            apt-get clean && rm -rf /var/lib/apt/lists/*

RUN         mkdir -p /run/php

COPY        ./tools/wordpress_install.sh /usr/local/etc/
            
COPY        ./conf/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN         bash /usr/local/etc/wordpress_install.sh

EXPOSE      9000

ENTRYPOINT  ["php-fpm7.4", "-F"]