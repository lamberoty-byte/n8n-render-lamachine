# Utilisation de l'image officielle n8n (dernière version)
FROM docker.n8n.io/n8nio/n8n:latest

USER root

# 1. Installation de FFmpeg pour Debian
RUN apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*

# 2. Installation du nœud TikTok dans le répertoire système de n8n
RUN cd /usr/local/lib/node_modules/n8n && npm install n8n-nodes-tiktok

USER node

# Force l'affichage du nœud "Execute Command" au démarrage
CMD ["n8n", "start", "--unpooled-nodes-list", "n8n-nodes-base.executeCommand"]
