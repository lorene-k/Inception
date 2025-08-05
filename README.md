# Inception
This project is part of the 42 cursus and aims to virtualize a small Docker-based infrastructure by creating custom Dockerfiles and using Docker Compose to orchestrate multiple services.

## Services
- **Nginx** — Web server with SSL
- **MariaDB** — Database server
- **WordPress** — CMS linked to the database

Each service is containerized in its own Docker container and built from scratch using Dockerfiles (no pre-built images).

## Features
- Nginx configured with SSL (self-signed certificate)
- WordPress site connected to MariaDB
- Persistent data volumes for WordPress and MariaDB
- Docker Compose orchestration
