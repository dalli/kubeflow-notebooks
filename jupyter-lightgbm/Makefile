TAG ?= $(shell git describe --tags --always --dirty)
REGISTRY ?= kubeflownotebookswg

docker-build-jupyter:
	$(MAKE) docker-build -C ../jupyter TAG=${TAG}

docker-build-cuda: docker-build-jupyter
	docker build -t ${REGISTRY}/jupyter-lightgbm-cuda:${TAG} --build-arg BASE_IMG=${REGISTRY}/jupyter:${TAG} -f cuda.Dockerfile . 

docker-push-cuda:
	docker push ${REGISTRY}/jupyter-lightgbm-cuda:${TAG}
