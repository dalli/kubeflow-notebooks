TAG ?= $(shell git describe --tags --always --dirty)
REGISTRY ?= kubeflownotebookswg

.PHONY: docker-build
docker-build: build-jupyter-pytorch-full build-jupyter-tensorflow-full build-jupyter-scipy build-codeserver-python build-rstudio-tidyverse build-jupyter-boost
		@echo "\nAll notebook-server images have been successfully built...\n"

.PHONY: build-jupyter-pytorch-full
build-jupyter-pytorch-full: build-jupyter-pytorch-full-cpu build-jupyter-pytorch-full-cuda

.PHONY: build-jupyter-pytorch-full-cpu
build-jupyter-pytorch-full-cpu:
	@echo "\nBuilding jupyter-pytorch-full-cpu image...\n"
	$(MAKE) docker-build-cpu -C jupyter-pytorch-full TAG=${TAG}

.PHONY: build-jupyter-pytorch-full-cuda
build-jupyter-pytorch-full-cuda:
	@echo "\nBuilding jupyter-pytorch-full-cuda image...\n"
	$(MAKE) docker-build-cuda -C jupyter-pytorch-full TAG=${TAG}

.PHONY: build-jupyter-tensorflow-full
build-jupyter-tensorflow-full: build-jupyter-tensorflow-full-cpu build-jupyter-tensorflow-full-cuda

.PHONY: jupyter-tensorflow-full-cpu
build-jupyter-tensorflow-full-cpu:
	@echo "\nBuilding jupyter-tensorflow-full-cpu image...\n"
	$(MAKE) docker-build-cpu -C jupyter-tensorflow-full TAG=${TAG}

.PHONY: build-jupyter-tensorflow-full-cuda
build-jupyter-tensorflow-full-cuda:
	@echo "\nBuilding jupyter-tensorflow-full-cuda image...\n"
	$(MAKE) docker-build-cuda -C jupyter-tensorflow-full TAG=${TAG}

.PHONY: build-jupyter-boost
build-jupyter-boost: build-jupyter-xgboost-cuda build-jupyter-lightgbm-cuda

.PHONY: build-jupyter-xgboost-cuda
build-jupyter-xgboost-cuda:
	@echo "\nBuilding jupyter-xgboost-cuda image...\n"
	$(MAKE) docker-build-cuda -C jupyter-xgboost TAG=${TAG}

.PHONY: build-jupyter-lightgbm-cuda
build-jupyter-lightgbm-cuda:
	@echo "\nBuilding jupyter-lightgbm-cuda image...\n"
	$(MAKE) docker-build-cuda -C jupyter-lightgbm TAG=${TAG}

.PHONY: build-jupyter-scipy
build-jupyter-scipy:
	@echo "\nBuilding jupyter-scipy image...\n"
	$(MAKE) docker-build -C jupyter-scipy TAG=${TAG}

.PHONY: build-codeserver-python
build-codeserver-python:
	@echo "\nBuilding codeserver-python image...\n"
	$(MAKE) docker-build-cpu -C codeserver-python TAG=${TAG}
	$(MAKE) docker-build-cuda -C codeserver-python TAG=${TAG}

.PHONY: build-rstudio-tidyverse
build-rstudio-tidyverse:
	@echo "\nBuilding rstudio-tidyverse image...\n"
	$(MAKE) docker-build-cpu -C rstudio-tidyverse TAG=${TAG}

.PHONY: docker-push
docker-push:
	@echo "\nPushing base image...\n"
	$(MAKE) docker-push-cpu -C base
	$(MAKE) docker-push-cuda -C base

	@echo "\nPushing codeserver image...\n"
	$(MAKE) docker-push-cpu -C codeserver
	$(MAKE) docker-push-cuda -C codeserver

	@echo "\nPushing codeserver-python image...\n"
	$(MAKE) docker-push-cpu -C codeserver-python 
	$(MAKE) docker-push-cuda -C codeserver-python 

	@echo "\nPushing rstudio image...\n"
	$(MAKE) docker-push -C rstudio

	@echo "\nPushing rstudio-tidyverse image...\n"
	$(MAKE) docker-push -C rstudio-tidyverse

	@echo "\nPushing jupyter image...\n"
	$(MAKE) docker-push-cpu -C jupyter
	$(MAKE) docker-push-cuda -C jupyter

	@echo "\nPushing jupyter-xgboost-cuda image...\n"
	$(MAKE) docker-push-cuda -C jupyter-xgboost

	@echo "\nPushing jupyter-lightgbm-cuda image...\n"
	$(MAKE) docker-push-cuda -C jupyter-lightgbm

	@echo "\nPushing jupyter-scipy image...\n"
	$(MAKE) docker-push -C jupyter-scipy

	@echo "\nPushing jupyter-pytorch image...\n"
	$(MAKE) docker-push-cpu -C jupyter-pytorch

	@echo "\nPushing jupyter-pytorch-cuda image...\n"
	$(MAKE) docker-push-cuda -C jupyter-pytorch

	@echo "\nPushing jupyter-pytorch-full image...\n"
	$(MAKE) docker-push-cpu -C jupyter-pytorch-full

	@echo "\nPushing jupyter-pytorch-cuda-full image...\n"
	$(MAKE) docker-push-cuda -C jupyter-pytorch-full

	@echo "\nPushing jupyter-tensorflow image...\n"
	$(MAKE) docker-push-cpu -C jupyter-tensorflow

	@echo "\nPushing jupyter-tensorflow-cuda image...\n"
	$(MAKE) docker-push-cuda -C jupyter-tensorflow

	@echo "\nPushing jupyter-tensorflow-full image...\n"
	$(MAKE) docker-push-cpu -C jupyter-tensorflow-full

	@echo "\nPushing jupyter-tensorflow-cuda-full image...\n"
	$(MAKE) docker-push-cuda -C jupyter-tensorflow-full

	@echo "\nAll notebook-server images have been successfully pushed...\n"
