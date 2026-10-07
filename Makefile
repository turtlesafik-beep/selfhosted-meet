.PHONY: help up down restart logs ps build deploy clean

help:
	@echo "selfhosted-meet"
	@echo ""
	@echo "  make up       - build + start"
	@echo "  make down     - stop + remove"
	@echo "  make restart  - restart"
	@echo "  make logs     - follow logs"
	@echo "  make ps       - container status"
	@echo "  make build    - build image only"
	@echo "  make deploy   - git pull + rebuild + restart"
	@echo "  make clean    - stop + remove images"

up:
	docker compose up -d --build

down:
	docker compose down

restart:
	docker compose restart

logs:
	docker compose logs -f

ps:
	docker compose ps

build:
	docker compose build

deploy:
	git pull
	docker compose up -d --build

clean:
	docker compose down --rmi local