# Étape 1: Utiliser l'image de base n8n (qui est basée sur Alpine)
FROM n8nio/n8n:latest

# Passer à l'utilisateur 'root' (administrateur) pour installer les paquets.
USER root

# Installer FFmpeg et ses dépendances avec le gestionnaire de paquets Alpine (apk).
# L'installation doit être faite par 'root' pour les permissions.
RUN apk add --no-cache ffmpeg && \
    # Nettoyer le cache d'apk pour garder l'image légère
    rm -rf /var/cache/apk/*

# Revenir à l'utilisateur par défaut 'node' pour des raisons de sécurité.
USER node
