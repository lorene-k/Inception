FROM        debian:bullseye

RUN         apt -y update && apt install -y nginx && apt install openssl -y

# nginx SSL
RUN         mkdir /etc/nginx/ssl

RUN         openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
               -out /etc/nginx/ssl/lkhalifa.crt \
               -keyout /etc/nginx/ssl/lkhalifa.key \
               -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=lkhalifa/CN=lkhalifa/"

RUN         mkdir -p /run/nginx

# COPY        ./conf/nginx.conf /etc/nginx/conf.d

# EXPOSE      443

# CMD / ENTRYPOINT  ["nginx", "-g", "daemon off;"]
