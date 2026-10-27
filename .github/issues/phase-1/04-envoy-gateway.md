# Installer Envoy Gateway (Helm) et exposer demo via HTTPRoute
labels: phase-1,type:learning,type:adr

## Objectif
Exposer `demo` à l'extérieur via Gateway API (voir ADR 0002).

## Concepts
GatewayClass, Gateway, HTTPRoute, CRD, Helm, séparation des rôles.

## À faire
- [ ] Installer Envoy Gateway avec le helm local (`bin/helm`), version épinglée, dans `platform/envoy-gateway/`
- [ ] Lister les CRD installées et expliquer leur rôle
- [ ] Créer une GatewayClass, une Gateway, une HTTPRoute vers `demo`
- [ ] Atteindre `demo` depuis l'hôte via le port mappé (voir `cluster/kind-config.yaml`)

## Critère de fin
`curl localhost:8080` répond depuis `demo`. Les manifests sont dans git.

## Pour casser
HTTPRoute avec un mauvais `parentRef` ou un mauvais backend : lis le `status` de la route.
