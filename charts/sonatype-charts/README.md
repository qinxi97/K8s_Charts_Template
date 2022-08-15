![Lint and Test Charts](https://github.com/sonatype/helm3-charts/workflows/Lint%20and%20Test%20Charts/badge.svg)

## Helm3 Charts for Sonatype Products

These charts are designed to work out of the box with minikube using both ingess and ingress dns addons.

The current releases have been tested on minikube v1.12.3 running k8s v1.18.3

### User Documentation

See docs/index.md which is also https://sonatype.github.io/helm3-charts/

### Contributing

See the [contributing document](./CONTRIBUTING.md) for details.

For Sonatypers, note that external contributors must sign the CLA and
the Dev-Ex team must verify this prior to accepting any PR.

### Updating Charts

Charts for Nexus IQ and for NXRM can be updated in `charts/` directories.
The most common updates will be to use new application images and to bump 
chart versions for release.

There should likely be no reason to update anything in `docs/` by hand.

Test a chart in a local k8s cluster (like minikube) by installing the local copy
from within each charts directory: 
```
helm install --generate-name ./
```

### Packaging and Indexing

*Sonatype CI build will package, commit, and publish to the official helm repository.*

Upon update of the `charts/`, run `build.sh` from here in the project root to
create `tgz` packages of the latest chart changes and regenerate the `index.yaml`
file to the `docs/` directory which is the root of the 
[repo site](https://sonatype.github.io/helm3-charts/).

The build process requires Helm 3.

### Further Notes on Usage

#### Resolver File and Ingress-DNS

Use the sample values files provided here.

- `helm install nexus-iq sonatype/nexus-iq-server -f iq-values.yaml`
- `helm install nexus-repo sonatype/nexus-repository-manager -f repo-values.yaml`

If you want to use the custom values file for the demo environment that expose 
the apps on a local domain of *.demo which is done by creating a resolver file. 
On a Mac it's `/etc/resolver/minikube-minikube-demo` with the following entries:
```
domain demo
nameserver 192.168.64.8
search_order 1
timeout 5
```

You'll need to update the IP address to match the running instance's IP address.
Use `minikube ip` to get the address

Docs for Ingress-dns are here
https://github.com/kubernetes/minikube/tree/master/deploy/addons/ingress-dns

#### 413 Errors with Nginx

The default setting for Nginx allows for very small upload sizes. Add this annotation to the ingress 
for each product to remove the limit:
```
nginx.ingress.kubernetes.io/proxy-body-size: "0"
```
