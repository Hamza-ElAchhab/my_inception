*This project has been created as part of the 42 curriculum by <login>.*

# Inception

## Description

Inception is a system-administration project: a small web infrastructure built with
**Docker Compose** inside a virtual machine. Every service runs in its own container,
built from **our own Dockerfiles** on top of `alpine:3.23` (the penultimate stable Alpine
release at the time of writing; no pulled ready-made images, no `latest` tag).

| Service | Role | Exposed |
|---|---|---|
| `nginx` | Reverse proxy, TLSv1.2/1.3 only, **only entry point** | `443` |
| `wordpress` | WordPress + php-fpm (no nginx) | internal `9000` |
| `mariadb` | Database (no nginx) | internal `3306` |
| `redis` *(bonus)* | WordPress object cache | internal |
| `ftp` *(bonus)* | vsftpd on the WordPress files volume | `21`, `21000-21010` |
| `static` *(bonus)* | Static showcase site (HTML/CSS/JS) | via nginx `/portfolio/` |
| `adminer` *(bonus)* | Database web UI (php-fpm) | via nginx `/adminer/` |

Persistent data: two **named volumes** (`mariadb_data`, `wordpress_data`) whose data lives
in `/home/<login>/data/{mariadb,wordpress}` on the host.

## Instructions

```bash
git clone <your-repo-url> inception && cd inception
make hosts          # maps <login>.42.fr to 127.0.0.1 (sudo)
make                # creates .env + secrets, builds images, starts everything
```

Then open `https://<login>.42.fr` (accept the self-signed certificate).
See `USER_DOC.md` (usage) and `DEV_DOC.md` (development).

Main targets: `make` · `make down` · `make stop` · `make start` · `make logs` ·
`make ps` · `make clean` · `make fclean` · `make re`.

## Project description

### Design choices
- One Dockerfile per service; each ends with an `ENTRYPOINT` whose last command is an
  `exec` of the real daemon (`mysqld`, `php-fpm84 -F`, `nginx -g 'daemon off;'`, `redis-server`,
  `vsftpd`), so the daemon is PID 1 and receives signals. No `tail -f`, `sleep infinity`,
  `while true` or `bash` as the main process.
- Waiting for MariaDB uses a **bounded** retry loop (max 60 tries) and a compose
  `healthcheck`, not an infinite loop.
- `restart: always` restarts containers after a crash.
- Passwords are **Docker secrets** (`secrets/*.txt`, generated randomly, git-ignored).
  `.env` only holds non-confidential values (domain, user names).
- TLS certificate is generated at container start (self-signed), nothing sensitive in git.
- Admin user is `<login>_boss`, never containing "admin".

### Virtual Machines vs Docker
A VM virtualizes hardware and runs a full guest OS (heavy, slow to boot, strong isolation).
A container shares the host kernel and isolates only processes, filesystem and network
(light, starts in seconds, reproducible from a Dockerfile). Here the VM is the host and
Docker splits the application into small single-purpose containers.

### Secrets vs Environment Variables
Environment variables are visible in `docker inspect`, process environments and logs,
and are easily leaked. Docker secrets are mounted as files in `/run/secrets/` (in memory,
only for services that declare them) and are never baked into images. We use env vars
for plain configuration and secrets for every password.

### Docker Network vs Host Network
A user-defined bridge network (`inception`) gives each container its own network
namespace, DNS by service name (`mariadb`, `wordpress`...) and isolation: only nginx
publishes a port. `network: host` removes that isolation, shares the host's interfaces
and ports, and is forbidden by the subject.

### Docker Volumes vs Bind Mounts
Named volumes are managed by Docker (portable, listed with `docker volume ls`,
independent of host paths). Bind mounts map an arbitrary host path directly. The subject
requires **named volumes**; we configure them with the `local` driver and
`driver_opts` so their data lands in `/home/<login>/data` while remaining named volumes.

## Resources

- Docker docs: https://docs.docker.com/ · Compose file reference: https://docs.docker.com/compose/compose-file/
- Dockerfile best practices: https://docs.docker.com/build/building/best-practices/
- NGINX: https://nginx.org/en/docs/ · WordPress / WP-CLI: https://wp-cli.org/
- MariaDB KB: https://mariadb.com/kb/ · Alpine packages: https://pkgs.alpinelinux.org/
- Article "PID 1 signal handling in Docker" (search term: *docker PID 1 zombie reaping*)

**Use of AI:** AI (Claude) was used to generate the initial scaffold of the Dockerfiles,
entrypoint scripts and documentation. Every file was then reviewed, tested and must be
understood by the authors before defense. *(Edit this paragraph to describe your real usage.)*
