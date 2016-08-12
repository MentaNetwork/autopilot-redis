.DEFAULT_GOAL := build
.PHONY := build dist

build:
	docker-compose -p menta -f docker-compose.yml build

dist: build
	docker tag menta_haproxy mentanetwork/autopilot-redis:latest
	docker push mentanetwork/autopilot-redis:latest
