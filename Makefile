VAR_FILE ?= net-lab.params
DOCKER_FILE = docker-compose.yml

#Load params file with all variables
include $(VAR_FILE)
export

all: 
	@echo "Usage: make (start|stop|master-cli)"

build: build-master build-proxy


build-master: Dockerfile.master
	@echo "Building salt master docker image, version $(TAG_MASTER)"
	docker build -f Dockerfile.master -t $(TAG_MASTER) .

build-proxy: Dockerfile.proxy
	@echo "Building salt proxy docker image, version $(TAG_PROXY)"
	docker build -f Dockerfile.proxy -t $(TAG_PROXY) .

testenv:
	env

start:
	@echo "Using docker compose file: $(DOCKER_FILE)"
	docker-compose -f $(DOCKER_FILE) up -d

stop:
	@echo "Using docker compose file: $(DOCKER_FILE)"
	docker-compose -f $(DOCKER_FILE) down

master-cli:
	docker exec -ti $(MASTER) bash
