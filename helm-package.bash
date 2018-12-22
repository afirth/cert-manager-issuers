#!/usr/bin/env bash
set -eux -o pipefail

#get version for release step
helm inspect chart ./ | perl -ne 'print if s/.*version: (v[\d.]+.*)/$1/' > VERSION

rm -rf dist && mkdir dist

#package the chart
helm package --save=false -d dist/ ./

#sha512 the tarball
(cd dist && find . -name '*.tgz' -type f | xargs -I % sh -c 'shasum -a 512 % > $(basename % .tgz).sha512')
