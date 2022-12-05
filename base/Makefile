TAG ?= $(shell git describe --tags --always --dirty)

docker-build:
	docker build -t skcha/base:${TAG} -f Dockerfile .

docker-push:
	docker push skcha/base:${TAG}