# Services et DNS : ClusterIP, CoreDNS, chemin d'un paquet
labels: phase-1,type:learning

## Objectif
Comprendre comment un pod en joint un autre (point fort à creuser avec ta base réseau).

## Concepts
Service ClusterIP/NodePort, Endpoints/EndpointSlices, CoreDNS, kube-proxy (iptables ou IPVS), CNI.

## À faire
- [ ] Exposer `demo` par un Service ClusterIP
- [ ] Depuis un pod debug : `nslookup demo`, FQDN `demo.<ns>.svc.cluster.local`
- [ ] Inspecter les règles iptables d'un nœud (`docker exec` dans le nœud kind) : retrouver le Service
- [ ] Suivre le chemin pod → Service → pod

## Critère de fin
Un schéma du chemin d'un paquet dans `docs/notes/03-services.md`.

## Pour casser
Mets un mauvais selector : les Endpoints sont vides. Que voit le client ?
