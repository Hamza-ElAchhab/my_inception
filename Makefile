

build:
	docker compose -f srcs/docker-compose.yml build


up:
	mkdir -p /home/hel-achh/data/wordpress
	mkdir -p /home/hel-achh/data/mariadb
	docker compose -f srcs/docker-compose.yml up -d


down:
	docker compose -f srcs/docker-compose.yml down -v


remove_cntrs:
	docker container rm mariadb_cntr wordpress_cntr nginx_cntr


remove_imgs:
	docker compose -f srcs/docker-compose.yml down --rmi all



# all / up Create the host data directories if needed, then build and start the stack.
# build       Build the images without starting (optional).
# down       Stop and remove the containers (keep volumes).

# Walk me through one page load from browser to database and back?

