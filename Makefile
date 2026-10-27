# Lab Aklaos Banking. Principe : tout est local au dossier du projet.
#  - outils (kind, kubectl, helm) dans $(TOOLS_DIR)/bin, HORS du dépôt
#  - kubeconfig dans ./.kube/config (jamais ~/.kube/config)
#  - caches/config helm dans ./.local
#  - seule dépendance système : Docker
CLUSTER ?= aklaos
ROOT    := $(CURDIR)
TOOLS_DIR ?= $(HOME)/Dev/aklaos-outils
BIN     := $(TOOLS_DIR)/bin
LOCAL   := $(ROOT)/.local
KIND_CONFIG := cluster/kind-config.yaml

# Versions épinglées (à relever volontairement)
KIND_VERSION    ?= v0.33.0
KUBECTL_VERSION ?= v1.34.0
HELM_VERSION    ?= v3.17.0

OS   := $(shell uname -s | tr A-Z a-z)
ARCH := $(shell uname -m | sed -e 's/x86_64/amd64/' -e 's/aarch64/arm64/')

export PATH := $(BIN):$(PATH)
export KIND_EXPERIMENTAL_PROVIDER := docker
export KUBECONFIG := $(ROOT)/.kube/config
export HELM_CACHE_HOME  := $(LOCAL)/helm/cache
export HELM_CONFIG_HOME := $(LOCAL)/helm/config
export HELM_DATA_HOME   := $(LOCAL)/helm/data

.PHONY: help tools hooks up down reset status env clean-tools
.DEFAULT_GOAL := help

help: ## Liste les commandes
	@grep -E '^[a-z-]+:.*## ' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  %-12s %s\n", $$1, $$2}'

tools: ## Vérifie les outils (utilise ceux du PATH, télécharge seulement les manquants)
	@command -v docker >/dev/null || { echo "Docker requis"; exit 1; }
	@mkdir -p $(BIN) $(LOCAL)
	@command -v kind >/dev/null    || { curl -fsSLo $(BIN)/kind https://kind.sigs.k8s.io/dl/$(KIND_VERSION)/kind-$(OS)-$(ARCH) && chmod +x $(BIN)/kind; }
	@command -v kubectl >/dev/null || { curl -fsSLo $(BIN)/kubectl https://dl.k8s.io/release/$(KUBECTL_VERSION)/bin/$(OS)/$(ARCH)/kubectl && chmod +x $(BIN)/kubectl; }
	@command -v helm >/dev/null    || { curl -fsSL https://get.helm.sh/helm-$(HELM_VERSION)-$(OS)-$(ARCH).tar.gz | tar -xz -C $(LOCAL) && mv $(LOCAL)/$(OS)-$(ARCH)/helm $(BIN)/helm && rm -rf $(LOCAL)/$(OS)-$(ARCH); }
	@for t in kind kubectl; do command -v $$t >/dev/null || { echo "manquant: $$t"; exit 1; }; done

hooks: ## Installe pre-commit dans un venv local (.local/venv)
	python3 -m venv $(LOCAL)/venv
	$(LOCAL)/venv/bin/pip install -q pre-commit
	$(LOCAL)/venv/bin/pre-commit install

up: tools ## Crée le cluster kind (kubeconfig local)
	@mkdir -p $(dir $(KUBECONFIG))
	@kind get clusters | grep -qx $(CLUSTER) && echo "$(CLUSTER) existe déjà" && kind export kubeconfig --name $(CLUSTER) --kubeconfig $(KUBECONFIG) || kind create cluster --name $(CLUSTER) --config $(KIND_CONFIG) --kubeconfig $(KUBECONFIG)
	@kubectl cluster-info

down: tools ## Détruit le cluster
	kind delete cluster --name $(CLUSTER) --kubeconfig $(KUBECONFIG)

reset: down up ## Détruit puis recrée

status: ## État des nœuds et pods
	kubectl get nodes -o wide
	kubectl get pods -A

env: ## Affiche les exports pour ouvrir un shell dans l'environnement du lab
	@echo 'export PATH=$(BIN):$$PATH KUBECONFIG=$(KUBECONFIG) HELM_CACHE_HOME=$(HELM_CACHE_HOME) HELM_CONFIG_HOME=$(HELM_CONFIG_HOME) HELM_DATA_HOME=$(HELM_DATA_HOME)'

clean-tools: ## Supprime ./.local et ./.kube (pas les outils)
	rm -rf $(LOCAL) $(ROOT)/.kube
