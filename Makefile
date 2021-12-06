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
%/.built: DOCKER_TAG = $(shell echo ${DOCKER_IMAGE}-${VERSION} | tr '[:upper:]' '[:lower:]')
%/.built:
	$(TARGET_MARKER_START)
	@echo VERSION: ${VERSION}
	@echo $(DOCKER_IMAGE)
	cp install.sh $(@D)
	docker build --progress plain -t $(DOCKER_TAG) $(@D)
	rm $(@D)/install.sh
	$(TARGET_MARKER_END)

%/.published: VERSION = $(shell cat ./$(@D)/version)
%/.published: DOCKER_IMAGE = $(DOCKER_IMAGE_PREFIX):$(subst /,-,$*)
%/.published: DOCKER_TAG = $(shell echo ${DOCKER_IMAGE}-${VERSION} | tr '[:upper:]' '[:lower:]')
%/.published: %/.built
	$(TARGET_MARKER_START)
	docker push $(DOCKER_TAG)
	$(TARGET_MARKER_END)


.DEFAULT_GOAL := publish
ifdef target
    publish: ${target}/.published
else
   	publish: $(shell find . -name Dockerfile | sed 's/Dockerfile/.published/')
endif
	$(TARGET_MARKER_START)
	$(TARGET_MARKER_END)

