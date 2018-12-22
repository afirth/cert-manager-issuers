# @afirth 2018-12
# checks Chart.yaml for a version, and uploads a release to github
# GITHUB_USER, GITHUB_TOKEN, and GITHUB_REPO must be set
# see also https://github.com/c4milo/github-release
# optimised for gcr.io/cloud-builders/go:alpine

.SHELLFLAGS := -eux -o pipefail -c
MAKEFLAGS += --warn-undefined-variables
SHELL=/bin/bash
.SUFFIXES:

NAME := $(GITHUB_USER)/$(GITHUB_REPO)
VERSION := $(shell helm inspect chart ./ | perl -ne 'print if s/.*version: (v[\d.]+.*)/$1/')


dist:
	rm -rf dist && mkdir dist
	helm package --save=false -d dist/ ./
	cd $(shell pwd)/dist && find . -name '*.tgz' -type f | xargs -I % sh -c 'shasum -a 512 % > $$(basename % .tgz).sha512'

release: dist
	@latest_tag=$$(git describe --tags `git rev-list --tags --max-count=1`); \
	comparison="$$latest_tag..HEAD"; \
	if [ -z "$$latest_tag" ]; then comparison=""; fi; \
	changelog=$$(git log $$comparison --oneline --no-merges); \
	github-release $(NAME) $(VERSION) "$$(git rev-parse --abbrev-ref HEAD)" "**Changelog**<br/>$$changelog" 'dist/*'; \
	git pull

deps:
	go get github.com/c4milo/github-release

.PHONY: deps dist release
