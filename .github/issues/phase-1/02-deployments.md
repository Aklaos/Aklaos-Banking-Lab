# Deployment, ReplicaSet, Pod : déployer une appli de test
labels: phase-1,type:learning

## Objectif
Maîtriser la chaîne Deployment → ReplicaSet → Pod avec une image simple (ex. podinfo ou nginx).

## Concepts
Manifests déclaratifs, labels/selectors, réplicas, rolling update, rollback.

## À faire
- [ ] Écrire toi-même `apps/demo/deployment.yaml` (pas de `kubectl create` impératif)
- [ ] `kubectl apply`, monter à 3 réplicas, observer la répartition sur les workers
- [ ] Changer la version d'image : suivre le rolling update (`kubectl rollout status`)
- [ ] `kubectl rollout undo`

## Critère de fin
Tu sais expliquer ce qui se passe quand tu supprimes un pod, et quand tu modifies le template du Deployment.

## Pour casser
Mets une image inexistante : lis `describe` et les events (ImagePullBackOff).
