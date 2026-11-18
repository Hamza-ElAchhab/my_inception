# Developer documentation

## Prerequisites
- A Linux VM with `docker` and the `docker compose` plugin, `make`.
- Your user in the `docker` group (or run make with sudo).

## Layout
```
Makefile                      # entry point
srcs/
   .env                        # data, variables
   docker-compose.yml
   requirements/
      mariadb/  nginx/  wordpress/
   .gitignore

```
Each service folder has `Dockerfile`, (config files).

## Set up from scratch
```bash
git clone <repo> inception && cd inception
do this 127.0.0.1  hel-achh.42.fr  in /etc/hosts
make all
```

## Build and launch
```bash
make            # = make up : docker compose up -d --build
make build      # build only
make logs       # follow logs
make down       # stop and remove containers
make re         # full rebuild from zero (destroys data)
```
Equivalent compose command:
`docker compose -p inception -f srcs/docker-compose.yml --env-file srcs/.env up -d --build`

## Useful commands
```bash
docker exec -it mariadb mariadb -uroot -p       # DB shell
docker exec -it wordpress sh                    # shell in a container
docker exec wordpress php84 /usr/local/bin/wp.phar --allow-root --path=/var/www/html user list
docker exec redis redis-cli ping                # PONG
docker exec redis redis-cli monitor             # watch cache traffic
docker volume ls && docker volume inspect wordpress_data
docker network inspect inception
```

## Where data lives
| Data | Volume | Host path |
|---|---|---|
| Database | `mariadb_data` | `/home/<login>/data/mariadb` |
| WordPress files | `wordpress_data` | `/home/<login>/data/wordpress` |

Volumes are Docker **named volumes** using the `local` driver with
`driver_opts: type=none, o=bind, device=/home/<login>/data/...`. Data survives
`make down`, container crashes and rebuilds. Only `make fclean` deletes it.

## How start-up works
1. `mariadb`: `init.sh` initialises the data dir once, creates the DB and user from secrets
   (`mysqld --bootstrap`), then `exec mysqld`.
2. `wordpress` waits for MariaDB (bounded retry), downloads nothing at runtime, copies
   sources into the volume, creates `wp-config.php`, installs the site, creates the
   administrator and an author, configures Redis, then `exec php-fpm84 -F`.
3. `nginx` generates a self-signed cert, renders its config with `$DOMAIN_NAME`, then
   `exec nginx -g 'daemon off;'`.

## Rules checklist (defense)
- No `latest` tag (images are `name:1.0`), base `alpine:3.23` — verify it is the
  penultimate stable Alpine on https://alpinelinux.org/releases/ and bump if needed.
- No passwords in Dockerfiles or git; secrets via `/run/secrets`.
- Only port 443 published for the mandatory part; no `network: host`, `links`.
- Admin user name has no "admin"; two users exist (`wp user list`).
