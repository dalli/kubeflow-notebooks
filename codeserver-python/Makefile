TAG ?= $(shell git describe --tags --always --dirty)
REGISTRY ?= kubeflownotebookswg

docker-build-codeserver-cpu:
	$(MAKE) docker-build-cpu -C ../codeserver TAG=${TAG}

docker-build-codeserver-cuda:
	$(MAKE) docker-build-cuda -C ../codeserver TAG=${TAG}

docker-build-cpu: docker-build-codeserver-cpu
	docker build -t ${REGISTRY}/codeserver-python:${TAG} --build-arg BASE_IMG=${REGISTRY}/codeserver:${TAG} -f Dockerfile . 

docker-build-cuda: docker-build-codeserver-cuda
	docker build -t ${REGISTRY}/codeserver-python-cuda:${TAG} --build-arg BASE_IMG=${REGISTRY}/codeserver-cuda:${TAG} -f Dockerfile . 

docker-push-cpu:
	docker push ${REGISTRY}/codeserver-python:${TAG}

docker-push-cuda:
	docker push ${REGISTRY}/codeserver-python-cuda:${TAG}
