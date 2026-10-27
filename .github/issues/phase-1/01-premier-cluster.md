# Premier cluster : valider make up et explorer les composants
labels: phase-1,type:learning

## Objectif
Avoir un cluster kind fonctionnel et comprendre ce qui tourne dedans.

## Concepts
Control plane (kube-apiserver, etcd, scheduler, controller-manager), kubelet, nœuds, kube-system, kubeconfig.

## À faire
- [ ] `make up` puis `make status`
- [ ] Lister les pods de `kube-system` et dire le rôle de chacun
- [ ] `docker ps` : retrouver les nœuds kind (ce sont des conteneurs)
- [ ] Lire `.kube/config` : cluster, user, context

## Critère de fin
Un court texte dans `docs/notes/01-cluster.md` expliquant, avec tes mots, ce que fait chaque composant de kube-system.

## Pour casser
Arrête le conteneur d'un worker (`docker stop`) : que devient le nœud ? Les pods ?
