# On force la version Debian pour avoir apt-get et une stabilité totale
FROM n8nio/n8n:latest-debian

USER root

# 1. Installation de FFmpeg (Fonctionne à 100% sur cette image)
RUN apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*

# 2. Installation du nœud TikTok
RUN mkdir -p /home/node/.n8n/custom && \
    npm install --prefix /home/node/.n8n/custom n8n-nodes-tiktok

USER node

# Configuration pour charger le nœud TikTok et forcer l'affichage de "Execute Command"
ENV N8N_CUSTOM_EXTENSIONS=/home/node/.n8n/custom/node_modules/n8n-nodes-tiktok
ENV N8N_ENABLE_COMMAND_SUBSTITUTION=true

# Commande de démarrage qui force l'activation du nœud de commande
CMD ["n8n", "start", "--unpooled-nodes-list", "n8n-nodes-base.executeCommand"]
