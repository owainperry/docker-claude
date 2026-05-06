IMAGE  := operry/claude
TAG    := $(or $(GITHUB_RUN_NUMBER),local)
GIT_DIR := /Users/operry/git
CLAUDE_DIR := /Users/operry/claude

.PHONY: build run clean

build:
	docker build . -t $(IMAGE):$(TAG)

run:
	docker machine start 2>/dev/null; \
	docker container run --rm -it \
		-v $(CLAUDE_DIR):/claude \
		-v $(GIT_DIR):/home/user/git \
		--workdir /home/user \
		--user 1000:1000 \
		$(IMAGE):$(TAG)

clean:
	docker rmi $(IMAGE):$(TAG)
