TAG ?= $(shell git describe --tags --always --dirty)

docker-build-base:
	make docker-build -C ../base TAG=${TAG}

docker-build: docker-build-base
	docker build -t skcha/codeserver:${TAG} --build-arg BASE_IMG=skcha/base:${TAG} -f Dockerfile . 

docker-push:
	docker push skcha/codeserver:${TAG}