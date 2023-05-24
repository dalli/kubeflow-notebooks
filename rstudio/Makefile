TAG ?= $(shell git describe --tags --always --dirty)
REGISTRY ?= kubeflownotebookswg

docker-build-base:
	$(MAKE) docker-build-cpu -C ../base TAG=${TAG}

docker-build-cpu: docker-build-base
	docker build -t ${REGISTRY}/rstudio:${TAG} --build-arg BASE_IMG=${REGISTRY}/base:${TAG} -f Dockerfile . 

docker-push:
	docker push ${REGISTRY}/rstudio:${TAG}
