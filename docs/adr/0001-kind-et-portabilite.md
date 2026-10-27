# ADR 0001 : kind comme cluster local, portable vers autre chose

- Statut : accepté
- Date : 2026-10-27

## Contexte
Lab personnel, allumé/éteint à volonté, développé sur Ubuntu, avec une possible bascule sur Mac (arm64), puis plus tard sur un vrai cluster (k3s/VPS ou cloud).

## Décision
- kind (Kubernetes in Docker), 1 control-plane + 2 workers.
- L'état du lab vit dans git : `make down` détruit tout, `make up` reconstruit.
- Uniquement des outils multiplateformes : docker, kind, kubectl, helm, kustomize.
- **Isolation** : le laptop héberge d'autres projets. Outils dans `./bin`, kubeconfig dans `./.kube`, caches dans `./.local`. Seul Docker est système. Aucune écriture dans `~/.kube` ni installation globale.
- Images construites multi-arch (amd64 + arm64).

## Conséquences
- Rien de spécifique à kind dans les manifests, sauf `cluster/`, pour faciliter la migration.
- Podman est possible mais non retenu au départ (rootless demande des réglages cgroups) ; à réévaluer.
