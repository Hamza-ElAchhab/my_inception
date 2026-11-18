# Developer Documentation

## Prerequisites

- Linux virtual machine.
- Docker Engine and Docker Compose plugin.
- GNU Make.
- Permission to access the Docker daemon.

## Project Layout

```text
my_inception/
├── Makefile
├── README.md
├── DEV_DOC.md
├── USER_DOC.md
└── srcs/
    ├── .env
    ├── docker-compose.yml
    └── requirements/
        ├── mariadb/
        │   ├── Dockerfile
        │   └── tools/script.sh
        ├── wordpress/
        │   ├── Dockerfile
        │   └── tools/script.sh
        └── nginx/
            ├── Dockerfile
            ├── conf/my_config.conf
            └── tools/script.sh
```

Each service has its own Dockerfile and startup script. NGINX also has a configuration file.

## Setup from Scratch

```bash
git clone <repository-url> inception
cd inception
```

Add the following entry to `/etc/hosts`:

```text
127.0.0.1 hel-achh.42.fr
```

Configure `srcs/.env`, then run:

```bash
make
```

## Build and Launch

```bash
make              # Build and start
make build        # Build images
make up           # Start containers
make down         # Stop and remove containers
make down_v       # Remove containers and volumes
make remove_imgs  # Remove project images
make clean        # Clean containers, volumes and images
```

Equivalent Compose command:

```bash
docker compose -f srcs/docker-compose.yml up -d
```

## Useful Commands

```bash
docker ps
docker logs mariadb_cntr
docker logs wordpress_cntr
docker logs nginx_cntr
docker exec -it mariadb_cntr mariadb -uroot -p
docker exec -it wordpress_cntr bash
docker exec nginx_cntr nginx -t
docker volume ls
docker network ls
```

## Persistent Storage

| Data | Volume | Host path |
|---|---|---|
| Database | `mariadb_vol` | `/home/hel-achh/data/mariadb` |
| WordPress files | `wordpress_vol` | `/home/hel-achh/data/wordpress` |

These are named volumes using the local driver with bind-backed host directories. Data persists after containers are removed. Removing the Docker volumes does not automatically delete the files in these host directories.

## How Startup Works

1. **MariaDB:** The startup script initializes the database, creates the application database and user, grants privileges, and starts the MariaDB daemon.
2. **WordPress:** The startup script configures the database connection, installs WordPress, creates the configured users, updates the site URL, and starts PHP-FPM on port 9000.
3. **NGINX:** The startup script generates a self-signed TLS certificate when needed and starts NGINX in the foreground.

## Implementation Checklist

- Custom Dockerfiles based on Debian Bookworm.
- Separate containers for NGINX, WordPress and MariaDB.
- No ready-made service images.
- NGINX is the only published entry point, on port 443.
- Dedicated Docker bridge network.
- Named volumes for persistent data.
- `restart: on-failure` restart policy.
- No host networking or Docker links.
- WordPress has an administrator and a second user.
