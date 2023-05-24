TAG ?= $(shell git describe --tags --always --dirty)
REGISTRY ?= kubeflownotebookswg

docker-build-jupyter-cpu:
	$(MAKE) docker-build-cpu -C ../jupyter TAG=${TAG} 

docker-build-jupyter-cuda:
	$(MAKE) docker-build-cuda -C ../jupyter TAG=${TAG}

docker-build-cpu: docker-build-jupyter-cpu
	docker build -t ${REGISTRY}/jupyter-tensorflow:${TAG} --build-arg BASE_IMG=${REGISTRY}/jupyter:${TAG} -f cpu.Dockerfile . 

docker-build-cuda: docker-build-jupyter-cuda
	docker build -t ${REGISTRY}/jupyter-tensorflow-cuda:${TAG} --build-arg BASE_IMG=${REGISTRY}/jupyter-cuda:${TAG} -f cuda.Dockerfile . 

docker-push-cpu: 
	docker push ${REGISTRY}/jupyter-tensorflow:${TAG}

docker-push-cuda:
	docker push ${REGISTRY}/jupyter-tensorflow-cuda:${TAG}
