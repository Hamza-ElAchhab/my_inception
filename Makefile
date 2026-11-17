
# PATH = -f srcs/docker-compose.yml


build:
	docker compose $(PATH) build


up:
	mkdir -p /home/hel-achh/data/wordpress
	mkdir -p /home/hel-achh/data/mariadb
	docker compose up -d


down:
	docker compose down -v


remove_cntrs:
	docker container mariadb_cntr wordpress_cntr nginx_cntr


remove_imgs:
	docker compose down --rmi all



# all / up Create the host data directories if needed, then build and start the stack.
# build       Build the images without starting (optional).
# down       Stop and remove the containers (keep volumes).

# Walk me through one page load from browser to database and back?

