VAR_FILE ?= net-lab.params
DOCKER_FILE = docker-compose.yml

#Load params file with all variables
include $(VAR_FILE)

all: 
	@echo "Usage: make (start|stop|master-cli)"

start:
	@echo "Using docker compose file: $(DOCKER_FILE)"
	docker-compose -f $(DOCKER_FILE) up 

stop:
	@echo "Using docker compose file: $(DOCKER_FILE)"
	docker-compose -f $(DOCKER_FILE) down

master-cli:
	docker exec -ti $(MASTER) bash
