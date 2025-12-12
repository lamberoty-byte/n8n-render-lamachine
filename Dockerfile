# On part de l'image officielle n8n (qui est basée sur Alpine Linux)
FROM n8nio/n8n:latest

# 1. Passer en root pour avoir le droit d'installer des programmes
USER root

# 2. Installer FFmpeg proprement avec le gestionnaire natif (apk)
# Cela installe automatiquement toutes les bonnes bibliothèques compatibles
RUN apk add --no-cache ffmpeg

# 3. Revenir à l'utilisateur 'node' pour la sécurité (standard n8n)
USER node
