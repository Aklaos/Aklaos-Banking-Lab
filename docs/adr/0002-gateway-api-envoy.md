# ADR 0002 : Gateway API avec Envoy Gateway plutôt qu'Ingress

- Statut : accepté
- Date : 2026-10-27

## Contexte
L'API Ingress est stable mais figée (feature-frozen) ; Gateway API est la voie recommandée. Le contrôleur Ingress NGINX communautaire est en fin de vie.

## Décision
Gateway API, implémentée par Envoy Gateway.

## Alternatives écartées
- Ingress + contrôleur : API figée, annotations non portables.
- Cilium Gateway API : intéressant, mais ajoute la complexité d'un CNI de remplacement dès la phase 1. À réévaluer en phase sécurité.

## Conséquences
Séparation des rôles GatewayClass / Gateway / HTTPRoute, qui reflète un contexte d'équipe.
