TAG ?= $(shell git describe --tags --always --dirty)

docker-build-codeserver:
	make docker-build -C ../codeserver TAG=${TAG}

docker-build: docker-build-codeserver
	docker build -t skcha/codeserver-python:${TAG} --build-arg BASE_IMG=skcha/codeserver:${TAG} -f Dockerfile . 

docker-push:
	docker push skcha/codeserver-python:${TAG}