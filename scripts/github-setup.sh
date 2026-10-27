#!/usr/bin/env bash
# Crée labels, milestones et issues sur GitHub. À lancer depuis l'hôte, dépôt cloné, `gh auth login` fait.
# Idempotent : ne recrée pas ce qui existe déjà. Usage : scripts/github-setup.sh [--dry-run]
set -euo pipefail
cd "$(dirname "$0")/.."
DRY=${1:-}
run() { if [ "$DRY" = "--dry-run" ]; then echo "[dry-run] $*"; else "$@"; fi; }

command -v gh >/dev/null || { echo "gh requis"; exit 1; }
REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner)
echo "Dépôt cible : $REPO"

# Labels
while IFS='|' read -r name color desc; do
  run gh label create "$name" --color "$color" --description "$desc" --force
done <<'LABELS'
phase-1|0e8a16|Fondations
phase-2|1d76db|GitOps et CI
phase-3|fbca04|Observabilité
phase-4|d93f0b|Sécurité
phase-5|5319e7|Fiabilité
phase-6|0052cc|Environnement réel
phase-7|b60205|Avancé
type:learning|c5def5|Concept Kubernetes à apprendre
type:app|bfd4f2|Code applicatif
type:adr|fef2c0|Décision d'architecture
type:docs|d4c5f9|Documentation
type:incident|e99695|Incident ou post-mortem
LABELS

# Milestones
existing=$(gh api "repos/$REPO/milestones?state=all&per_page=100" -q '.[].title')
while IFS='|' read -r title desc; do
  grep -qxF "$title" <<<"$existing" || run gh api "repos/$REPO/milestones" -f title="$title" -f description="$desc" >/dev/null
done <<'MILESTONES'
Phase 1 - Fondations|kind, Deployments, Services, Gateway API (Envoy), config, probes, Postgres
Phase 2 - GitOps et CI|GitHub Actions, images multi-arch signées, Kustomize/Helm, Argo CD
Phase 3 - Observabilité|Prometheus, Grafana, Loki, traces, SLO, alertes et runbooks
Phase 4 - Sécurité|RBAC, NetworkPolicies, Pod Security, Kyverno, secrets, cert-manager, mTLS
Phase 5 - Fiabilité|HPA/KEDA, PDB, canary, chaos, backup/restore
Phase 6 - Environnement réel|OpenTofu, k3s/VPS ou cloud éphémère, multi-environnements
Phase 7 - Avancé|Opérateur/CRD, upgrade de cluster, FinOps
MILESTONES

# Issues de la phase 1
have=$(gh issue list --state all --limit 500 --json title -q '.[].title')
for f in .github/issues/phase-1/*.md; do
  title=$(sed -n '1s/^# //p' "$f")
  labels=$(sed -n '2s/^labels: //p' "$f")
  grep -qxF "$title" <<<"$have" && { echo "existe : $title"; continue; }
  run gh issue create --title "$title" --label "$labels" --milestone "Phase 1 - Fondations" --body "$(tail -n +4 "$f")"
done
