TAG ?= $(shell git describe --tags --always --dirty)
REGISTRY ?= kubeflownotebookswg

docker-build-cpu:
	docker build -t ${REGISTRY}/base:${TAG} -f cpu.Dockerfile .

docker-build-cuda:
	docker build -t ${REGISTRY}/base-cuda:${TAG} -f cuda.Dockerfile .

docker-push-cpu:
	docker push ${REGISTRY}/base:${TAG}

docker-push-cuda:
	docker push ${REGISTRY}/base-cuda:${TAG}
