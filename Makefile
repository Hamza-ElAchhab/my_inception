

all: build up
	@echo "Done."



build:
	docker compose -f srcs/docker-compose.yml build


up:
	mkdir -p /home/hel-achh/data/wordpress
	mkdir -p /home/hel-achh/data/mariadb
	docker compose -f srcs/docker-compose.yml up -d


down:
	docker compose -f srcs/docker-compose.yml down


down_v:
	docker compose -f srcs/docker-compose.yml down -v


remove_imgs:
	docker compose -f srcs/docker-compose.yml down --rmi all


clean: down_v remove_imgs
	@echo "Cleaned."


re: clean all


.PHONY: all build up down down_v remove_imgs clean
