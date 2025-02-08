FROM        debian:bullseye

RUN         apt-get update && apt-get install -y mariadb-client mariadb-server && \
            apt-get clean && rm -rf /var/lib/apt/lists/*

RUN         mkdir -p /run/mysqld

COPY        /conf/my.cnf /etc/mysql/my.cnf

# COPY        /conf/setup.sql /docker-entrypoint-initdb.d/setup.sql

COPY        /tools/mariadb_init.sh /usr/local/bin/

RUN         chmod +x /usr/local/bin/mariadb_init.sh

EXPOSE      3306

ENTRYPOINT  ["/usr/local/bin/mariadb_init.sh"]