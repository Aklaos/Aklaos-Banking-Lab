# Service accounts (Go) + Postgres : première vraie appli
labels: phase-1,type:app

## Objectif
Premier service applicatif : comptes et soldes, en Go, adossé à Postgres.

## Répartition
- Code Go, Dockerfile et migrations : écrits par l'assistant.
- Manifests Kubernetes (Deployment, Service, HTTPRoute, config) : écrits par toi.

## À faire
- [ ] Code `apps/accounts/` (API REST minimale, `/healthz`, `/readyz`)
- [ ] Image construite et chargée dans kind (`kind load docker-image`)
- [ ] Manifests écrits à la main, connectés à Postgres (#7) et exposés via Gateway (#4)

## Critère de fin
Créer et lire un compte via `curl` à travers la Gateway.
