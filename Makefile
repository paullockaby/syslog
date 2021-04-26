# stop on error, no built in rules, run silently
MAKEFLAGS="-S -s -r"

# get tag information
IMAGE_COMMIT := $(shell git log -1 | head -n 1 | cut -d" " -f2)
IMAGE_TAG := $(shell git tag --contains ${IMAGE_COMMIT})

# get image id based on tag or commit
IMAGE_VERSION := $(or $(IMAGE_TAG),$(IMAGE_COMMIT))
IMAGE_NAME := "ghcr.io/paullockaby/syslog-ng"
IMAGE_ID := "${IMAGE_NAME}:${IMAGE_VERSION}"

all: build

.PHONY: build
build:
	@echo "building image for ${IMAGE_ID}"
	docker build -t $(IMAGE_NAME):latest -t $(IMAGE_ID) .

.PHONY: push
push: build
	@echo "pushing $(IMAGE_ID)"
	docker push $(IMAGE_ID)

.PHONY: run
run: build
	@echo "running $(IMAGE_NAME):latest"
	docker run --rm -it -p 514:514/tcp -p 514:514/udp -v $PWD/logs:/logs -v $PWD/example:/etc/syslog-ng $(IMAGE_NAME):latest

.PHONY: clean
clean:
	@echo "removing built image ${IMAGE_ID}"
	docker image rm $(IMAGE_NAME):latest $(IMAGE_ID)
