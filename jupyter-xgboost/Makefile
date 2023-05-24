TAG ?= $(shell git describe --tags --always --dirty)
REGISTRY ?= kubeflownotebookswg

docker-build-jupyter:
	$(MAKE) docker-build-cuda -C ../jupyter TAG=${TAG}

docker-build-cuda: docker-build-jupyter
	docker build -t ${REGISTRY}/jupyter-xgboost-cuda:${TAG} --build-arg BASE_IMG=${REGISTRY}/jupyter-cuda:${TAG} -f cuda.Dockerfile . 

docker-push-cuda:
	docker push ${REGISTRY}/jupyter-xgboost-cuda:${TAG}
