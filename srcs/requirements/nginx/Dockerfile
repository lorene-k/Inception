FROM        debian:bullseye

RUN         apt-get update && apt-get install -y nginx openssl \
            curl procps net-tools iputils-ping && \
            apt-get clean && rm -rf /var/lib/apt/lists/*

RUN         mkdir -p /etc/nginx/ssl && \
            openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
               -out /etc/nginx/ssl/lkhalifa.crt \
               -keyout /etc/nginx/ssl/lkhalifa.key \
               -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=lkhalifa/CN=lkhalifa.42.fr/"

RUN         mkdir -p /run/nginx

COPY        ./conf/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE      443

CMD         ["nginx", "-g", "daemon off;"]