FROM        debian:bullseye

RUN         apt-get update && apt-get install -y php7.4-fpm php7.4-mysqli \
            php7.4-curl php7.4-gd php7.4-opcache php7.4-mbstring bash tar curl sed iputils-ping && \
            apt-get clean && rm -rf /var/lib/apt/lists/*

RUN         mkdir -p /run/php

COPY        ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf 

COPY        ./conf/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf

COPY        ./tools/wordpress_install.sh /usr/local/bin/

RUN         chmod +x /usr/local/bin/wordpress_install.sh

WORKDIR     /var/www/html

EXPOSE      9000

ENTRYPOINT  ["/usr/local/bin/wordpress_install.sh"]