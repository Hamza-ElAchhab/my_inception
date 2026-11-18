# User documentation

## What the stack provides
- **Website** (WordPress) at `https://<login>.42.fr`
- **Administration panel** at `https://<login>.42.fr/wp-admin`
- **Adminer** (database UI) at `https://<login>.42.fr/adminer/` — server `mariadb`
- **Static portfolio site** at `https://<login>.42.fr/portfolio/`
- **FTP** server on port 21 giving access to the WordPress files
- **Redis** cache (invisible, speeds up WordPress)

## Start and stop
```bash
make hosts   # once: maps <login>.42.fr to 127.0.0.1
make         # build + start everything
make stop    # pause containers (data kept)
make start   # resume
make down    # remove containers (data kept in /home/<login>/data)
```

## Access
1. Open `https://<login>.42.fr` — the browser warns about the self-signed certificate;
   accept it (expected).
2. Log in at `/wp-admin` with the administrator account from `secrets/credentials.txt`.
3. Adminer: System `MySQL`, Server `mariadb`, user/password from `secrets/credentials.txt`,
   database `wordpress`.
4. FTP: `ftp <login>.42.fr` (or any FTP client), user `ftpuser`, password from the secrets.
   Passive ports 21000-21010 must be reachable.

## Credentials
All credentials are in `secrets/` (git-ignored):

| File | Content |
|---|---|
| `credentials.txt` | Readable summary of every account |
| `db_password.txt`, `db_root_password.txt` | MariaDB passwords |
| `wp_admin_password.txt`, `wp_user_password.txt` | WordPress accounts |
| `ftp_password.txt` | FTP password |

To change a password: edit its file, then `make fclean && make` (this recreates the data)
— or change it inside WordPress / MariaDB for a running site.
Non-secret settings (domain, user names) are in `srcs/.env`.

## Check that everything works
```bash
make ps                                   # all services "Up" (mariadb "healthy")
make logs                                 # live logs
curl -k -I https://<login>.42.fr          # HTTP/2 200 or 302
curl -k --tlsv1.1 --tls-max 1.1 https://<login>.42.fr   # must FAIL (TLS 1.2+ only)
curl -I http://<login>.42.fr:80           # must FAIL (only 443 open)
docker volume ls                          # mariadb_data, wordpress_data
```