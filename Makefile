# Ensure targets are deleted when an error occurred executing the recipe
.DELETE_ON_ERROR:

# Allows usage of automatic variables in prerequisites
.SECONDEXPANSION:

MAKEFLAGS += --warn-undefined-variables

DOCKER_IMAGE_PREFIX := lucasvanlierop/php-extensions

%/.pulled: DOCKER_IMAGE = php:$(subst /,-,$*)
%/.pulled:
	docker pull $(DOCKER_IMAGE)
	touch $@

%/.built: DOCKER_IMAGE = $(DOCKER_IMAGE_PREFIX):$(subst /,-,$*)
%/.built: DOCKER_PHP_BASE_IMAGE_PULLED = $(dir $(@D)).pulled
%/.built: \
	$$(DOCKER_PHP_BASE_IMAGE_PULLED) \
	$$(shell find $$(@D) -type f -not -name .built -not -name .published)
	echo $(DOCKER_PHP_BASE_IMAGE_PULLED)
	-docker pull $(DOCKER_IMAGE)
	docker build --cache-from $(DOCKER_IMAGE) -t $(DOCKER_IMAGE) $(@D)
	touch $@

%/.published: DOCKER_IMAGE = $(DOCKER_IMAGE_PREFIX):$(subst /,-,$*)
%/.published: %/.built
	echo $(DOCKER_IMAGE)
	docker push $(DOCKER_IMAGE)
	touch $@

.DEFAULT_GOAL := publish
publish: \
	$(shell find . -name Dockerfile | sed 's/Dockerfile/.published/')
