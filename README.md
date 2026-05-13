# ft_transcendence

Un jeu de Pong multijoueur en temps réel avec système d'authentification, chat en direct, tournois et intégration blockchain.

![Screenshot 1](docs/images/Capture%20d'écran%202024-08-19%20à%2018.53.38.jpg)

## Apercu du projet

![Screenshot 2](docs/images/Capture%20d'écran%202024-08-19%20à%2018.54.12.jpg)
![Screenshot 3](docs/images/Capture%20d'écran%202024-08-19%20à%2018.55.32.jpg)

### Fonctionnalites principales

![Screenshot 4](docs/images/Capture%20d'écran%202024-08-19%20à%2018.55.41.jpg)
![Screenshot 5](docs/images/Capture%20d'écran%202024-08-19%20à%2018.55.48.jpg)

## Architecture

Ce projet est une application full-stack containerisée avec Docker Compose :

- **Backend**: Django 3.2 + Django REST Framework + Django Channels (WebSockets)
- **Frontend**: SPA Vanilla JavaScript avec Bootstrap
- **Base de données**: PostgreSQL
- **Cache/Message Broker**: Redis
- **Reverse Proxy**: Nginx avec SSL/TLS
- **Blockchain** (optionnel): Smart contracts Solidity avec Foundry

## Fonctionnalités

- Jeu Pong multijoueur en temps réel via WebSockets
- Système d'authentification avec JWT
- Gestion d'amis
- Tournois avec brackets
- Chat en direct
- Historique des parties
- Profils utilisateurs avec avatars
- Adversaire IA
- Support multilingue (EN, FR, ES, IS)
- Intégration blockchain (optionnelle)

## Prérequis

- Docker
- Docker Compose
- Ports disponibles: 8080 (HTTP), 4443 (HTTPS), 5432 (PostgreSQL), 6380 (Redis)

## Installation et lancement

### 1. Configuration de l'environnement

Créez/modifiez le fichier `.env` à la racine du projet :

```bash
# Hostname (pour production, utilisez votre domaine)
HOSTNAME_VAR="pong.sabinomonte.ch"

# Base de données
DB_NAME="pongdatabase"
DB_USER="val"
DB_PASS="VotreMotDePasseSecurise"

# Email (SendGrid)
EMAIL_HOST_PASSWORD='VotreCleAPISendGrid'

# Blockchain (optionnel)
SEPOLIA_URL=''
PRIVATE_KEY=''
```

### 2. Certificats SSL

Pour un environnement local, les certificats sont générés automatiquement au premier lancement du conteneur Nginx.

Pour la production avec Cloudflare :
```bash
# Placez vos certificats dans :
nginx/certs/nginx.crt
nginx/private/nginx.key
```

### 3. Lancer l'application

```bash
# Construction et lancement
make re

# Ou simplement
docker compose up -d --build
```

### 4. Accéder à l'application

- **Frontend**: https://localhost:4443 (ou https://pong.sabinomonte.ch)
- **API Backend**: https://localhost:4443/api/
- **Admin Django**: https://localhost:4443/admin/
- **WebSocket**: wss://localhost:4443/ws/

## Commandes Make disponibles

```bash
make build      # Construire les images Docker
make up         # Démarrer les conteneurs
make down       # Arrêter et supprimer les conteneurs
make re         # Rebuild complet (down + build + up)
make clear_db   # Nettoyer la base de données
make nuke       # Supprimer tous les conteneurs et images
make ww3        # Nettoyage complet (down + nuke + prune)
make help       # Afficher l'aide
```

## Structure du projet

```
ft_transcendence/
├── backend/              # API Django
│   ├── authentication/   # Login/register/JWT
│   ├── db/              # Modèle User
│   ├── friends/         # Système d'amis
│   ├── games_history/   # Historique
│   ├── livechat/        # Chat temps réel
│   ├── supervisor/      # Moteur de jeu
│   ├── blockchain/      # Intégration blockchain
│   └── pong_game/       # Config Django
├── frontend/            # SPA JavaScript
│   └── website/         # Assets statiques
├── nginx/              # Reverse proxy
├── db/                 # PostgreSQL
├── blockchain/         # Smart contracts (optionnel)
└── docker-compose.yml  # Orchestration
```

## Développement

### Accéder aux logs

```bash
# Tous les services
docker compose logs -f

# Un service spécifique
docker compose logs -f backend
docker compose logs -f frontend
docker compose logs -f nginx
```

### Accéder à un conteneur

```bash
docker exec -it backend bash
docker exec -it db psql -U val -d pongdatabase
```

### Migrations Django

```bash
docker exec -it backend python manage.py makemigrations
docker exec -it backend python manage.py migrate
```

### Créer un superuser

```bash
docker exec -it backend python manage.py createsuperuser
```

## Déploiement en production

### LXC avec Cloudflare

1. **Configuration DNS Cloudflare**:
   - Pointez `pong.sabinomonte.ch` vers l'IP de votre LXC
   - Configurez SSL/TLS en mode "Full (strict)"

2. **Mise à jour de l'environnement**:
   ```bash
   # Dans .env
   HOSTNAME_VAR="pong.sabinomonte.ch"
   ```

3. **Certificats SSL**:
   - Utilisez les certificats Origin de Cloudflare
   - Ou générez avec Let's Encrypt/Certbot

4. **Sécurité**:
   - Changez les mots de passe dans `.env`
   - Configurez le pare-feu
   - Limitez l'accès aux ports sensibles

5. **Lancement**:
   ```bash
   docker compose up -d --build
   ```

## Troubleshooting

### Les conteneurs ne démarrent pas
```bash
docker compose down -v
docker compose up --build
```

### Erreur de connexion à la base de données
```bash
# Vérifier que PostgreSQL est prêt
docker compose logs db
```

### Erreur SSL
```bash
# Régénérer les certificats
cd nginx
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout private/nginx.key -out certs/nginx.crt \
  -subj "/CN=pong.sabinomonte.ch"
```

### Port déjà utilisé
```bash
# Identifier le processus
lsof -i :4443
# Arrêter le service ou changer le port dans docker-compose.yml
```

## Technologies utilisées

**Backend**:
- Django 3.2
- Django REST Framework
- Django Channels + Daphne
- Python-socketio
- Pygame (moteur de jeu)
- PostgreSQL + psycopg2
- Redis
- SendGrid (emails)

**Frontend**:
- Vanilla JavaScript
- Bootstrap 4.5.2
- i18next (i18n)
- Socket.IO client

**Infrastructure**:
- Docker + Docker Compose
- Nginx
- Redis (Alpine)
- PostgreSQL (latest)

**Blockchain** (optionnel):
- Foundry
- Solidity
- Ethers.js
- Express.js

## Licence

Projet 42 School - ft_transcendence

## Auteurs

Développé dans le cadre du cursus 42 School
