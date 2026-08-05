# Default registry and image prefix
REGISTRY = quay.io/redhat-ai-services
IMAGE_PREFIX = modelcar-catalog
MODELCAR_IMAGES = ./modelcar-images

# # Environment variable for Hugging Face token (must be set)
# ifndef HF_TOKEN
# $(error HF_TOKEN is not set)
# endif

.PHONY: build download date-tag org-tag push build-and-push build-and-push-all

# Ensure each recipe runs in a single shell so variables persist across lines
.ONESHELL:

# Use strict shell flags: exit on error, treat unset variables as error, fail on pipe errors
SHELL := /bin/bash
.SHELLFLAGS := -euo pipefail -c

build:
	@if [ -z "$(folder)" ]; then
		echo "Usage: make build folder=<path-to-folder>"
		exit 1
	fi
	if [ -f "$(folder)/downloader.env" ]; then
		$(MAKE) download folder=$(folder)
	fi
	tag=$$(basename "$(folder)")
	image=$(REGISTRY)/$(IMAGE_PREFIX):$$tag
	echo "Building image with tag $$image"
	# Use `set --` to build argv safely without eval. We then execute the final argv via "$@".
	set -- podman build "$(folder)" -t "$$image" --platform linux/amd64
	if [ -n "$(HF_TOKEN)" ]; then
		set -- "$$@" --build-arg HF_TOKEN="$(HF_TOKEN)"
	fi
	"$$@"
	$(MAKE) date-tag folder=$(folder)
	$(MAKE) org-tag folder=$(folder)

download:
	@if [ -z "$(folder)" ]; then
		echo "Usage: make download folder=<path-to-folder>"
		exit 1
	fi
	mkdir -p $(folder)/models
	# Build the podman run argv incrementally with `set --` and then exec with "$@".
	set -- podman run --rm --platform linux/amd64 \
	  -v ./$(folder)/models:/models \
	  --env-file $(folder)/downloader.env
	if [ -n "$(HF_TOKEN)" ]; then
		set -- "$$@" -e HF_TOKEN="$(HF_TOKEN)"
	fi
	set -- "$$@" $(REGISTRY)/huggingface-downloader:latest
	"$$@"

date-tag:
	@if [ -z "$(folder)" ]; then
		echo "Usage: make date-tag folder=<path-to-folder>"
		exit 1
	fi
	tag=$$(basename "$(folder)")
	dateTag=$$(date -u +'%Y%m%dt%H%Mz')
	echo "Date tag: $$dateTag"
	echo "Tag: $$tag"
	podman tag $(REGISTRY)/$(IMAGE_PREFIX):$$tag $(REGISTRY)/$(IMAGE_PREFIX):$${tag}-$${dateTag}

org-tag:
	@if [ -z "$(folder)" ]; then
		echo "Usage: make org-tag folder=<path-to-folder>"
		exit 1
	fi
	tag=$$(basename "$(folder)")
	org=$$(basename "$$(dirname "$(folder)")")
	orgTag="$$org--$$tag"
	echo "Organization: $$org"
	echo "Tag: $$tag"
	echo "Org tag: $$orgTag"
	podman tag $(REGISTRY)/$(IMAGE_PREFIX):$$tag $(REGISTRY)/$(IMAGE_PREFIX):$$orgTag

push:
	@if [ -z "$(folder)" ]; then
		echo "Usage: make push folder=<path-to-folder>"
		exit 1
	fi
	baseTag=$$(basename "$(folder)")
	echo "Base tag: $$baseTag"
	echo "Looking for image: $(REGISTRY)/$(IMAGE_PREFIX):$$baseTag"
	imageID=$$(podman images --filter "reference=$(REGISTRY)/$(IMAGE_PREFIX):$$baseTag" --format "{{.ID}}" | head -1 | tr -d '\n')
	echo "Image ID: $$imageID"
	if [ -z "$$imageID" ]; then
		echo "Error: No image found with tag $(REGISTRY)/$(IMAGE_PREFIX):$$baseTag"
		exit 1
	fi
	tags=$$(podman images --filter "id=$$imageID" --format "{{.Repository}}:{{.Tag}}" | grep "^$(REGISTRY)/$(IMAGE_PREFIX):")
	echo "Tags: $$tags"
	if [ -z "$$tags" ]; then
		echo "Error: No tags found for image ID $$imageID"
		exit 1
	fi
	for tag in $$tags; do
		echo "Pushing image with tag $$tag"
		podman push $$tag
	done

build-and-push:
	@if [ -z "$(folder)" ]; then
		echo "Usage: make build-and-push folder=<folder-name>"
		exit 1
	fi
	$(MAKE) build folder=$(folder)
	$(MAKE) push folder=$(folder)

prune:
	@if [ -z "$(folder)" ]; then
		echo "Usage: make prune folder=<folder-name>"
		exit 1
	fi
	podman image prune --force
	tag=$$(basename "$(folder)")
	image=$(REGISTRY)/$(IMAGE_PREFIX):$${tag}
	podman image rm $$image

clean-all:
	rm -rf $(MODELCAR_IMAGES)/*/*/models

build-and-push-all:
	for orgdir in $(MODELCAR_IMAGES)/* ; do
		if [ -d "$$orgdir" ]; then
			for folder in $$orgdir/* ; do
				if [ -d "$$folder" ] && [ -f "$$folder/Containerfile" ]; then
					if [ -f "$$folder/.depreciated" ]; then
						echo "Skipping depreciated model: $$folder"
						continue
					fi
					$(MAKE) build-and-push folder="$$folder"
					$(MAKE) prune folder="$$folder"
				fi
			done
		fi
	done
