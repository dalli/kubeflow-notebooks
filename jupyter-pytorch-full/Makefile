TAG ?= $(shell git describe --tags --always --dirty)

docker-build-jupyter-pytorch:
	make docker-build-cpu -C ../jupyter-pytorch TAG=${TAG} 

docker-build-jupyter-pytorch-cuda:
	make docker-build-cuda -C ../jupyter-pytorch TAG=${TAG} 

docker-build-cpu: docker-build-jupyter-pytorch
	docker build -t skcha/jupyter-pytorch-full:${TAG} --build-arg BASE_IMG=skcha/jupyter-pytorch:${TAG} -f cpu.Dockerfile . 

docker-build-cuda: docker-build-jupyter-pytorch-cuda
	docker build -t skcha/jupyter-pytorch-cuda-full:${TAG} --build-arg BASE_IMG=skcha/jupyter-pytorch-cuda:${TAG} -f cuda.Dockerfile . 

docker-push-cpu:
	docker push skcha/jupyter-pytorch-full:${TAG}

docker-push-cuda:
	docker push skcha/jupyter-pytorch-cuda-full:${TAG}