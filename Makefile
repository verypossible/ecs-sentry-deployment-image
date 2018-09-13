NAME ?= verypossible/ecs-sentry-deployment-image
TAG ?= $(shell git rev-parse --short HEAD)

all : Dockerfile
	docker build $(ARGS) -t $(NAME):$(TAG) .


push :
	docker push $(NAME):$(TAG)
.PHONY: push


shell :
	docker run --rm -it $(NAME):latest bash
.PHONY: shell
