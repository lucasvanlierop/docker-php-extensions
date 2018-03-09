SHELL=/bin/bash

# Ensure targets are deleted when an error occurred executing the recipe
.DELETE_ON_ERROR:

# Allows usage of automatic variables in prerequisites
.SECONDEXPANSION:

MAKEFLAGS += --warn-undefined-variables

TARGET=$@

TARGET_MARKER_START = @echo "starting: $(TARGET)"
TARGET_MARKER_END = @echo "ended $(TARGET)"

CI ?=

ifeq ($(CI),travis)
include make/travis.mk
endif

DOCKER_IMAGE_PREFIX := lucasvanlierop/php-extensions

%/.pulled: DOCKER_IMAGE = php:$(subst /,-,$*)
%/.pulled:
	$(TARGET_MARKER_START)
	docker pull $(DOCKER_IMAGE)
	touch $(TARGET)
	$(TARGET_MARKER_END)

%/.built: DOCKER_IMAGE = $(DOCKER_IMAGE_PREFIX):$(subst /,-,$*)
%/.built: DOCKER_PHP_BASE_IMAGE_PULLED = $(dir $(@D)).pulled
%/.built: \
	$$(DOCKER_PHP_BASE_IMAGE_PULLED) \
	$$(shell find $$(@D) -type f -not -name .built -not -name .published)
	$(TARGET_MARKER_START)
	-docker pull $(DOCKER_IMAGE)
	docker build --cache-from $(DOCKER_IMAGE) -t $(DOCKER_IMAGE) $(@D)
	touch $(TARGET)
	$(TARGET_MARKER_END)


%/.published: DOCKER_IMAGE = $(DOCKER_IMAGE_PREFIX):$(subst /,-,$*)
%/.published: %/.built
	$(TARGET_MARKER_START)
	docker push $(DOCKER_IMAGE)
	touch $(TARGET)
	$(TARGET_MARKER_END)


.DEFAULT_GOAL := publish
publish: \
	$(shell find . -name Dockerfile | sed 's/Dockerfile/.published/')
	$(TARGET_MARKER_START)
	$(TARGET_MARKER_END)

