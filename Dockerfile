# Utilisation de l'image officielle n8n (dernière version)
FROM docker.n8n.io/n8nio/n8n:latest

USER root

# 1. Installation de FFmpeg
RUN apk add --no-cache ffmpeg

# 2. Installation forcée du nœud TikTok dans le répertoire global de n8n
RUN cd /usr/local/lib/node_modules/n8n && npm install n8n-nodes-tiktok

# Retour à l'utilisateur n8n pour la sécurité
USER node

# Force l'affichage du nœud "Execute Command" au démarrage
CMD ["n8n", "start", "--unpooled-nodes-list", "n8n-nodes-base.executeCommand"]
