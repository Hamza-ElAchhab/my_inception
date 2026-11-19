# User Documentation

## What the Stack Provides

- **Website:** WordPress at `https://hel-achh.42.fr`
- **Administration panel:** `https://hel-achh.42.fr/wp-admin`
- **Database:** MariaDB, used internally by WordPress.
- **Web server:** NGINX provides HTTPS using a self-signed TLS certificate.

## Start and Stop

Run these commands from the project root:

```bash
make          # Build and start the infrastructure
make build    # Build images
make up       # Start containers
make down     # Stop and remove containers
make down_v   # Remove containers and named volumes
make clean    # Remove containers, volumes and images
make re       # Remove containers, volumes and images, and start again

```

## Access

1. Open `https://hel-achh.42.fr`.
2. Accept the browser warning because the TLS certificate is self-signed.
3. Open `/wp-admin` to access the WordPress administration panel.
4. Log in using the administrator credentials configured in `srcs/.env`.

## Configuration

The environment file is:

```text
srcs/.env
```

It contains the domain, database settings and WordPress account configuration.

Keep this file private and do not commit credentials to a public repository.

## Persistent Data

| Data | Host directory |
|---|---|
| MariaDB database | `/home/hel-achh/data/mariadb` |
| WordPress files | `/home/hel-achh/data/wordpress` |

Data is stored in named volumes configurated by bind_m backed by these host directories.

Removing containers or Docker volumes does not automatically delete the files stored in these directories.

## Check That Everything Works

Check running containers:

```bash
docker ps
```

Check service logs:

```bash
docker logs mariadb_cntr
docker logs wordpress_cntr
docker logs nginx_cntr
```

Check Docker volumes and network:

```bash
docker volume ls
docker network ls
```

Test HTTPS:

```bash
curl -k https://hel-achh.42.fr/
```
