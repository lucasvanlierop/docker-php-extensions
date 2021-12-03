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

DOCKER_IMAGE_PREFIX := etriasnl/php-extensions

%/.built: VERSION = $(shell cat ./$(@D)/version)
%/.built: DOCKER_IMAGE = $(DOCKER_IMAGE_PREFIX):$(subst /,-,$*)
%/.built:
	$(TARGET_MARKER_START)
	@echo VERSION: ${VERSION}
	@echo $(DOCKER_IMAGE)
	docker build -t $(DOCKER_IMAGE)-$(VERSION) $(@D)
	$(TARGET_MARKER_END)

%/.published: VERSION = $(shell cat ./$(@D)/version)
%/.published: DOCKER_IMAGE = $(DOCKER_IMAGE_PREFIX):$(subst /,-,$*)
%/.published: %/.built
	$(TARGET_MARKER_START)
	docker push $(DOCKER_IMAGE)-$(VERSION)
	$(TARGET_MARKER_END)


.DEFAULT_GOAL := publish
ifdef target
    publish: ${target}/.published
else
   	publish: $(shell find . -name Dockerfile | sed 's/Dockerfile/.published/')
endif
	$(TARGET_MARKER_START)
	$(TARGET_MARKE	R_END)

