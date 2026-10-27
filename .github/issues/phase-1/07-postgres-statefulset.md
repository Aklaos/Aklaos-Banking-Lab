# Postgres : StatefulSet et PersistentVolumeClaim
labels: phase-1,type:learning

## Objectif
Faire tourner un état persistant et comprendre ce que ça change.

## Concepts
StatefulSet, headless Service, PV/PVC/StorageClass (provisioner de kind), identité stable des pods.

## À faire
- [ ] Postgres en StatefulSet avec un PVC
- [ ] Supprimer le pod : les données survivent-elles ?
- [ ] `make down` puis `make up` : que devient la donnée ? Pourquoi ?

## Critère de fin
Note sur ce qu'il faudra pour de vraies sauvegardes (phase 5).
