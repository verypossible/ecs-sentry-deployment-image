NAME ?= verypossible/ecs-sentry-deployment-image
TAG ?= latest

all : Dockerfile
	docker build -t $(NAME):$(TAG) .


push :
	docker push $(NAME):$(TAG)
.PHONY: push


shell :
	docker run --rm -it $(NAME):latest bash
.PHONY: shell
