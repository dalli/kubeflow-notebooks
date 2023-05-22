TAG ?= $(shell git describe --tags --always --dirty)
REGISTRY ?= kubeflownotebookswg

docker-build-base:
	$(MAKE) docker-build -C ../base TAG=${TAG}

docker-build: docker-build-base
	docker build -t ${REGISTRY}/codeserver:${TAG} --build-arg BASE_IMG=${REGISTRY}/base:${TAG} -f Dockerfile . 
	docker build -t ${REGISTRY}/codeserver-cuda:${TAG} --build-arg BASE_IMG=${REGISTRY}/base-cuda:${TAG} -f Dockerfile . 

docker-push:
	docker push ${REGISTRY}/codeserver:${TAG}
	docker push ${REGISTRY}/codeserver-cuda:${TAG}
