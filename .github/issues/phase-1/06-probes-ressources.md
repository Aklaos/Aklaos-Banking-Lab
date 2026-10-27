# Probes, requests/limits, QoS, OOMKill
labels: phase-1,type:learning

## Objectif
Comprendre comment Kubernetes décide de placer, tuer et redémarrer les pods.

## Concepts
liveness/readiness/startup probes, requests vs limits, classes QoS, throttling CPU, OOMKilled, Namespaces, ResourceQuota, LimitRange.

## À faire
- [ ] Ajouter probes et ressources à `demo`
- [ ] Provoquer un OOMKill (limite mémoire basse + charge)
- [ ] Readiness qui échoue : le pod sort des Endpoints
- [ ] Créer un namespace avec ResourceQuota

## Critère de fin
Post-mortem court dans `docs/incidents/` pour l'OOMKill.
