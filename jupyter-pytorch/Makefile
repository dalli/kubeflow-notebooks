TAG ?= $(shell git describe --tags --always --dirty)

docker-build-jupyter:
	make docker-build -C ../jupyter TAG=${TAG}

docker-build-cpu: docker-build-jupyter
	docker build -t skcha/jupyter-pytorch:${TAG} --build-arg BASE_IMG=skcha/jupyter:${TAG} -f cpu.Dockerfile . 

docker-build-cuda: docker-build-jupyter
	docker build -t skcha/jupyter-pytorch-cuda:${TAG} --build-arg BASE_IMG=skcha/jupyter:${TAG} -f cuda.Dockerfile . 

docker-push-cpu:
	docker push skcha/jupyter-pytorch:${TAG}

docker-push-cuda:
	docker push skcha/jupyter-pytorch-cuda:${TAG}