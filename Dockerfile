# Utilisation de Debian Bookworm (stable et à jour)
FROM node:20-bookworm

# 1. Installation de FFmpeg
RUN apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*

# 2. Installation de n8n (Dernière version)
RUN npm install -g n8n --unsafe-perm

# 3. Installation du nœud TikTok
RUN mkdir -p /home/node/.n8n/custom
RUN npm install --prefix /home/node/.n8n/custom n8n-nodes-tiktok

# Gestion des permissions
RUN chown -R node:node /home/node
USER node
WORKDIR /home/node

# Configuration
ENV N8N_CUSTOM_EXTENSIONS=/home/node/.n8n/custom/node_modules/n8n-nodes-tiktok
ENV N8N_ENABLE_COMMAND_SUBSTITUTION=true

EXPOSE 5678

# Lancement forcé avec le nœud Execute Command visible
CMD ["n8n", "start", "--unpooled-nodes-list", "n8n-nodes-base.executeCommand"]
