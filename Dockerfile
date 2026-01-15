FROM node:20-bookworm

USER root
# Installation de ffmpeg et des outils de build
RUN apt-get update && apt-get install -y ffmpeg python3 build-essential git && rm -rf /var/lib/apt/lists/*

# Installation de n8n et du nœud TikTok
RUN npm install -g n8n --unsafe-perm
RUN npm install -g n8n-nodes-tiktok --ignore-scripts --unsafe-perm

# Définition du dossier de travail
WORKDIR /home/node/.n8n

# Variables pour n8n
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok
ENV N8N_ENABLE_COMMAND_SUBSTITUTION=true

# On s'assure que l'utilisateur node a les bons droits
RUN chown -R node:node /home/node
USER node

EXPOSE 5678

# On lance n8n avec les options de sécurité directement dans la commande
CMD ["n8n", "start", "--unpooled-nodes-list", "n8n-nodes-base.executeCommand"]
