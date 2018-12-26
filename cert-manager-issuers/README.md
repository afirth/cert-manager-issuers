# Cert-Manager-Issuers

## Quickstart

To setup the [letsencrypt](https://letsencrypt.org/) staging and prod http01 ACME endpoints as ClusterIssuers (so you can use the kube-lego style `kubernetes.io/tls-acme: "true"`):

First install the [cert-manager chart](https://github.com/helm/charts/tree/master/stable/cert-manager) with the ingress shim set up:

```
$ helm install --name my-release \
--set ingressShim.defaultIssuerName=letsencrypt-prod,ingressShim.defaultIssuerKind=ClusterIssuer \
stable/cert-manager
```

Then install this chart with the default values.yaml and your email address:

```
$ helm install --name my-release \
-f values.yaml \
--set email=<you@example.com> \
incubator/cert-manager-issuers
```

## Values

## FAQ

### Why isn't this chart part of cert-manager?

Due to technical limitations of helm v2, custom resource definitions must be created before a custom resource can be defined. This means that no issuers are included in the [cert-manager helm chart](https://github.com/helm/charts/tree/master/stable/cert-manager), as they would fail to create.

## Stability

This chart is in alpha. Backwards incompatible changes will be avoided if possible, but no guarantees.
It's likely that this chart won't be needed after helm v3 is released.

## Contributing

PRs are welcome, especially to support more functionality.
