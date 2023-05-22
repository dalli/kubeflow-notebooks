TAG ?= $(shell git describe --tags --always --dirty)
REGISTRY ?= kubeflownotebookswg

docker-build-base-cpu:
	$(MAKE) docker-build-cpu -C ../base TAG=${TAG}

docker-build-base-cuda:
	$(MAKE) docker-build-cuda -C ../base TAG=${TAG}

docker-build-cpu: docker-build-base-cpu
	docker build -t ${REGISTRY}/jupyter:${TAG} --build-arg BASE_IMG=${REGISTRY}/base:${TAG} -f Dockerfile . 

docker-build-cuda: docker-build-base-cuda
	docker build -t ${REGISTRY}/jupyter-cuda:${TAG} --build-arg BASE_IMG=${REGISTRY}/base-cuda:${TAG} -f Dockerfile . 

docker-push-cpu:
	docker push ${REGISTRY}/jupyter:${TAG}

docker-push-cuda:
	docker push ${REGISTRY}/jupyter-cuda:${TAG}
