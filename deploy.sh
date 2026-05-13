#!/bin/bash

# Script de déploiement pour ft_transcendence
# Usage: ./deploy.sh [local|production]

set -e

MODE=${1:-local}

echo "===================================="
echo "Déploiement ft_transcendence"
echo "Mode: $MODE"
echo "===================================="

# Vérifier que .env existe
if [ ! -f .env ]; then
    echo "❌ Erreur: Le fichier .env n'existe pas"
    echo "Copiez .env.example vers .env et configurez-le"
    exit 1
fi

# Arrêter les conteneurs existants
echo "🛑 Arrêt des conteneurs existants..."
docker compose down

# Nettoyer les volumes si mode production
if [ "$MODE" = "production" ]; then
    echo "🧹 Nettoyage des volumes (mode production)..."
    docker compose down -v
    docker volume prune -f
fi

# Construire les images
echo "🏗️  Construction des images Docker..."
docker compose build --no-cache

# Démarrer les conteneurs
echo "🚀 Démarrage des conteneurs..."
docker compose up -d

# Attendre que les services soient prêts
echo "⏳ Attente du démarrage des services..."
sleep 10

# Vérifier l'état des conteneurs
echo "📊 État des conteneurs:"
docker compose ps

echo ""
echo "✅ Déploiement terminé!"
echo ""
echo "📝 Accès à l'application:"
if [ "$MODE" = "local" ]; then
    echo "   Frontend: https://localhost:4443"
    echo "   API: https://localhost:4443/api/"
    echo "   Admin: https://localhost:4443/admin/"
else
    HOSTNAME=$(grep HOSTNAME_VAR .env | cut -d '=' -f2 | tr -d '"')
    echo "   Frontend: https://$HOSTNAME"
    echo "   API: https://$HOSTNAME/api/"
    echo "   Admin: https://$HOSTNAME/admin/"
fi
echo ""
echo "📋 Logs:"
echo "   docker compose logs -f"
echo ""