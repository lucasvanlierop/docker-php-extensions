PHP_EXT_DIR=7.4/bullseye
DOCKER_IMAGE_PREFIX=etriasnl/php-extensions
MAKEFLAGS += --warn-undefined-variables

%/.releaser: VERSION=$(shell cat "./${@D}/version")
%/.releaser: DOCKER_IMAGE="${DOCKER_IMAGE_PREFIX}:$(subst /,-,$*)"
%/.releaser: DOCKER_TAG=$(shell echo "${DOCKER_IMAGE}-${VERSION}" | tr '[:upper:]' '[:lower:]')
%/.releaser:
	echo "[RELEASING] ${DOCKER_TAG}"
	cp install.sh.dist "${@D}/install.sh"
	docker buildx build -t "${DOCKER_TAG}" "${@D}"
	rm "${@D}/install.sh"

%/.publisher: VERSION=$(shell cat "./${@D}/version")
%/.publisher: DOCKER_IMAGE="${DOCKER_IMAGE_PREFIX}:$(subst /,-,$*)"
%/.publisher: DOCKER_TAG=$(shell echo "${DOCKER_IMAGE}-${VERSION}" | tr '[:upper:]' '[:lower:]')
%/.publisher: %/.releaser
	echo "[PUBLISHING] ${DOCKER_TAG}"
	docker push "${DOCKER_TAG}"

release: ${PHP_EXT_DIR}/${ext}/.releaser
release-all: $(shell find "${PHP_EXT_DIR}" -name Dockerfile | sed 's/Dockerfile/.releaser/')
publish: ${PHP_EXT_DIR}/${ext}/.publisher
publish-all: $(shell find "${PHP_EXT_DIR}" -name Dockerfile | sed 's/Dockerfile/.publisher/')
