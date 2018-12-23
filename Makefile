# @afirth 2018-12
# checks Chart.yaml for a version, and uploads a release to github
# GITHUB_USER, GITHUB_TOKEN, and GITHUB_REPO must be set
# see also https://github.com/c4milo/github-release
# optimised for gcr.io/cloud-builders/go:debian

.SHELLFLAGS := -eux -o pipefail -c
MAKEFLAGS += --warn-undefined-variables
SHELL=/bin/bash
.SUFFIXES:

NAME := $(GITHUB_USER)/$(GITHUB_REPO)
VERSION := $(shell cat VERSION)

all: dist release

#dist creates VERSION
dist:
	./helm-package.bash

release:
	@latest_tag=$$(git describe --tags `git rev-list --tags --max-count=1` || true); \
	comparison="$$latest_tag..HEAD"; \
	version=$$(cat VERSION); \
	if [ -z "$$latest_tag" ]; then comparison=""; fi; \
	changelog=$$(git log $$comparison --oneline --no-merges); \
	$$(go env GOPATH)/bin/github-release $(NAME) $(VERSION) "$$(git rev-parse --abbrev-ref HEAD)" "**Changelog**<br/>$$changelog" 'dist/*'; \
	git pull

deps:
	go get -v github.com/c4milo/github-release

.PHONY: all deps dist release
