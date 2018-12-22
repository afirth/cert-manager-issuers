#!/usr/bin/env bash
set -eux -o pipefail

chart_name=cert-manager-issuers
#get version for release step
helm inspect chart ./$chart_name | perl -ne 'print if s/.*version: (v[\d.]+.*)/$1/' > VERSION

rm -rf dist && mkdir dist

#package the chart
helm package --save=false -d dist/ ./$chart_name

#sha512 the tarball
(cd dist && find . -name '*.tgz' -type f | xargs -I % sh -c 'shasum -a 512 % > $(basename % .tgz).sha512')
