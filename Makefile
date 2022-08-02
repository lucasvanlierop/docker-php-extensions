PHP_VERSION?=7.4
PHP_DIST?=bullseye
PHP_EXT_DIR=${PHP_VERSION}/${PHP_DIST}
DOCKER_IMAGE=etriasnl/php-extensions
DOCKER_PROGRESS?=auto
MAKEFLAGS += --warn-undefined-variables --always-make
.DEFAULT_GOAL := _

exec_docker=docker run -it --rm -v "$(shell pwd):/app" -w /app

${PHP_EXT_DIR}/%/.releaser: VERSION=$(subst /,-,${@D})-$(shell cat "${@D}/version" | tr '[:upper:]' '[:lower:]')
${PHP_EXT_DIR}/%/.releaser: DOCKER_TAG=${DOCKER_IMAGE}:${VERSION}
${PHP_EXT_DIR}/%/.releaser:
	echo "[RELEASING] ${DOCKER_TAG}"
	${exec_docker} hadolint/hadolint hadolint --ignore DL3059 "${@D}/Dockerfile"
	cp install.sh.dist "${@D}/install.sh"
	docker buildx build --progress "${DOCKER_PROGRESS}" -t "${DOCKER_TAG}" --load "${@D}"
	rm "${@D}/install.sh"

${PHP_EXT_DIR}/%/.publisher: VERSION=$(subst /,-,${@D})-$(shell cat "${@D}/version" | tr '[:upper:]' '[:lower:]')
${PHP_EXT_DIR}/%/.publisher: DOCKER_TAG=${DOCKER_IMAGE}:${VERSION}
${PHP_EXT_DIR}/%/.publisher: ${PHP_EXT_DIR}/%/.releaser
	echo "[PUBLISHING] ${DOCKER_TAG}"
	docker push "${DOCKER_TAG}"

release: ${PHP_EXT_DIR}/${ext}/.releaser
release-all: $(shell find "${PHP_EXT_DIR}" -name Dockerfile | sed 's/Dockerfile/.releaser/')
publish: ${PHP_EXT_DIR}/${ext}/.publisher
publish-all: $(shell find "${PHP_EXT_DIR}" -name Dockerfile | sed 's/Dockerfile/.publisher/')
