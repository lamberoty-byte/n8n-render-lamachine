# Base Debian stable (évite les erreurs 404 de dépôts)
FROM node:20-bookworm

USER root

# 1. Installation de FFmpeg
RUN apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*

# 2. Installation de n8n
RUN npm install -g n8n --unsafe-perm

# 3. Installation du nœud TikTok (le flag --ignore-scripts règle votre erreur 254)
RUN npm install -g n8n-nodes-tiktok --ignore-scripts --unsafe-perm

# 4. Configuration des dossiers et permissions
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node
USER node
WORKDIR /home/node

# Variables d'environnement pour lier le nœud et autoriser les commandes
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok
ENV N8N_ENABLE_COMMAND_SUBSTITUTION=true

EXPOSE 5678

# Démarrage forcé avec Execute Command visible
CMD ["n8n", "start", "--unpooled-nodes-list", "n8n-nodes-base.executeCommand"]
