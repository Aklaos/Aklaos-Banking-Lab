# Aklaos-Banking-Lab

Lab Kubernetes d'apprentissage autour d'une petite appli de banking. L'objectif est la **plateforme** (déploiement, GitOps, observabilité, sécurité, fiabilité), pas la complexité métier.

## Démarrage rapide
Seul prérequis système : **Docker**. Tout le reste (kind, kubectl, helm, kubeconfig, caches) est installé dans le dossier du projet (`~/Dev/aklaos-outils` (hors dépôt), `.kube/`, `.local/`) et ne touche ni `~/.kube` ni le système.

```
make up       # télécharge les outils si besoin, crée le cluster kind
make env      # exports pour utiliser kubectl/helm dans ton shell (eval "$(make env)")
make status   # nœuds et pods
make down     # détruit tout (l'état vit dans git)
```

Option : avec [direnv](https://direnv.net), `direnv allow` à la racine charge automatiquement l'environnement du lab (`.envrc`, exports écrits en clair) dans chaque nouveau shell. Relis `.envrc` avant chaque `direnv allow`.

Contrôles de sécurité (secrets, YAML) : ils tournent sur GitHub à chaque PR (`.github/workflows/securite.yml`), pas sur ta machine.

## Organisation
- `cluster/` : configuration du cluster local
- `apps/` : services applicatifs
- `platform/` : composants de plateforme (Gateway, monitoring, ...)
- `docs/adr/` : décisions d'architecture
- `docs/roadmap.md` : phases, suivies par milestones et issues GitHub
