*This project has been created as part of the 42 curriculum by hel-achh.*

# Inception

## Description

Inception is a system administration project that builds a small web infrastructure using **Docker Compose** inside a virtual machine. Each service runs in its own container, built from a custom Dockerfile based on **Debian Bookworm**.

| Service | Role | Port |
|---|---|---|
| `nginx` | Web server, reverse proxy and TLS | `443` |
| `wordpress` | WordPress with PHP-FPM | Internal `9000` |
| `mariadb` | Database server | Internal `3306` |

NGINX is the only public entry point. WordPress and MariaDB communicate through a dedicated Docker bridge network.

Persistent data is stored on the host:
- MariaDB: `/home/hel-achh/data/mariadb`
- WordPress: `/home/hel-achh/data/wordpress`

## Instructions

### Installation

```bash
git clone <your-repository-url> inception
cd inception
```

Configure the environment variables in `srcs/.env`.

Add the following entry to `/etc/hosts`:

```text
127.0.0.1 hel-achh.42.fr
```

Create the data directories and start the infrastructure:

```bash
mkdir -p /home/hel-achh/data/{mariadb,wordpress}
make
```

Open [https://hel-achh.42.fr](https://hel-achh.42.fr) and accept the browser warning for the self-signed certificate.

For more information, see `USER_DOC.md` for usage and `DEV_DOC.md` for development.

**Available Makefile targets:** `all`, `build`, `up`, `down`, `down_v`, `remove_imgs`, `clean`.

## Project Description

### Design Choices

- Each service has its own custom Dockerfile.
- Containers run their respective service processes in the foreground.
- NGINX handles HTTPS using TLSv1.2 and forwards PHP requests to WordPress through FastCGI.
- WordPress uses PHP-FPM and connects to MariaDB through the Docker network.
- `restart: on-failure` allows containers to restart after failures.
- Environment variables configure database and WordPress credentials.
- Persistent storage uses named volumes backed by host directories.

### Virtual Machines vs Docker

A virtual machine virtualizes hardware and runs a complete guest operating system. It provides strong isolation but requires more resources.

Docker containers share the host kernel and isolate applications using operating-system features. They are generally lighter and faster to start.

In this project, the virtual machine provides the environment, while Docker separates the application into independent services.

### Secrets vs Environment Variables

Environment variables provide a simple way to pass configuration to containers, but sensitive values may be exposed through container inspection or process environments.

Docker secrets provide a more controlled way to distribute sensitive information, typically by mounting them as files.

This project uses environment variables for configuration and credentials.

### Docker Network vs Host Network

A user-defined Docker bridge network provides container isolation and DNS resolution through service names, such as `mariadb` and `wordpress`.

Host networking shares the host's network namespace, reducing network isolation and exposing services directly through the host network.

This project uses a dedicated bridge network, with only NGINX publishing a port.

### Docker Volumes vs Bind Mounts

Docker volumes are managed by Docker and can be inspected using `docker volume ls`.

Bind mounts connect a specific host path directly to a container.

This project uses named volumes with the local driver and bind-backed storage, keeping persistent data under `/home/hel-achh/data`.

## Resources

### Documentation and References

- Docker: https://docs.docker.com/
- Docker Compose: https://docs.docker.com/compose/
- Dockerfile best practices: https://docs.docker.com/build/building/best-practices/
- NGINX: https://nginx.org/en/docs/
- WordPress: https://wordpress.org/documentation/
- WP-CLI: https://wp-cli.org/
- MariaDB: https://mariadb.com/kb/

### AI Usage

AI was used as a learning and assistance tool to understand Docker concepts, review configuration files, troubleshoot errors, and help prepare documentation. The project implementation was reviewed and tested by the author, who is responsible for understanding the code and configuration.
