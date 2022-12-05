TAG ?= $(shell git describe --tags --always --dirty)

docker-build-jupyter-tensorflow:
	make docker-build-cpu -C ../jupyter-tensorflow TAG=${TAG}

docker-build-jupyter-tensorflow-cuda:
	make docker-build-cuda -C ../jupyter-tensorflow TAG=${TAG}

docker-build-cpu: docker-build-jupyter-tensorflow
	docker build -t skcha/jupyter-tensorflow-full:${TAG} --build-arg BASE_IMG=skcha/jupyter-tensorflow:${TAG} -f cpu.Dockerfile . 

docker-build-cuda: docker-build-jupyter-tensorflow-cuda
	docker build -t skcha/jupyter-tensorflow-cuda-full:${TAG} --build-arg BASE_IMG=skcha/jupyter-tensorflow-cuda:${TAG} -f cuda.Dockerfile . 

docker-push-cpu:
	docker push skcha/jupyter-tensorflow-full:${TAG}

docker-push-cuda:
	docker push skcha/jupyter-tensorflow-cuda-full:${TAG}