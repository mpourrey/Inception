COMPOSE_FILE = srcs/docker-compose.yml

all: up

#recree les images et les containers
up:
	sudo docker compose -f $(COMPOSE_FILE) up -d

#builds images before starting containers
build:
	sudo docker compose -f $(COMPOSE_FILE) up --build -d 

#stops containers and removes images, containers, networks and volumes
down:
	sudo docker compose -f $(COMPOSE_FILE) down

prune:
	sudo docker system prune -af

logs:
	sudo docker logs wordpress
	sudo docker logs nginx
	sudo docker logs mariadb


clean: down

fclean: clean prune
	sudo rm -rf /home/mpourrey/data/wordpress_files/*
	sudo rm -rf /home/mpourrey/data/mariadb_database/*

re: down up

in:
	sudo docker exec -it $(filter-out $@,$(MAKECMDGOALS)) bash

.PHONY: volume stop clean prune re in
