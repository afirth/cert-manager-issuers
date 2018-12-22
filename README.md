# cert-manager-issuers [WIP]

## Why

Due to technical limitations of helm v2, custom resource definitions must be created before a custom resource can be defined. This means that no issuers are included in the [cert-manager helm chart](https://github.com/helm/charts/tree/master/stable/cert-manager), as they would fail to create.

## Quickstart

``` 
$ helm repo add github-cert-manager-issuers 'https://raw.githubusercontent.com/afirth/cert-manager-issuers/master/'
$ helm install cert-manager-issuers
```

or if using cloudbuild or the helm docker builder: (https://github.com/GoogleCloudPlatform/cloud-builders-community/tree/master/helm)

```
$HELM_REPO_NAME=github-cert-manager-issuers
$HELM_REPO_URL=https://raw.githubusercontent.com/afirth/cert-manager-issuers/master/
```

## TODO

move this to a `charts` repo and host the repo on github pages, or get it into incubator

## Contributing

PRs are welcome.
