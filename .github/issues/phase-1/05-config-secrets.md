# ConfigMaps et Secrets : configuration d'une appli
labels: phase-1,type:learning

## Objectif
Injecter de la configuration par variables d'environnement et par fichiers montés.

## Concepts
ConfigMap, Secret (base64 n'est pas du chiffrement), volumes, mise à jour à chaud.

## À faire
- [ ] Config par env var et par volume
- [ ] Modifier la ConfigMap : que se passe-t-il pour chaque mode ?
- [ ] Lire un Secret : constater qu'il est juste encodé

## Critère de fin
Note expliquant pourquoi on ne committe jamais un Secret en clair (prépare la phase 4 : External Secrets/Vault).
