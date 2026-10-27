# Roadmap (un milestone GitHub par phase)

1. **Fondations** : kind, Deployments, Services, Gateway API (Envoy), ConfigMaps/Secrets, probes, requests/limits, Postgres (StatefulSet/PVC).
2. **GitOps et CI** : GitHub Actions, images multi-arch signées, Kustomize/Helm, Argo CD.
3. **Observabilité** : Prometheus, Grafana, Loki, traces OpenTelemetry, SLO, alertes et runbooks.
4. **Sécurité** : RBAC, NetworkPolicies, Pod Security, Kyverno, gestion des secrets, cert-manager, mTLS.
5. **Fiabilité** : HPA/KEDA, PDB, canary (Argo Rollouts), chaos, backup/restore.
6. **Environnement réel** : OpenTofu, k3s/VPS ou cloud éphémère, multi-environnements.
7. **Avancé** : opérateur/CRD, upgrade de cluster, FinOps.
