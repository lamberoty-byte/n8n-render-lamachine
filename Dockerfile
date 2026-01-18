FROM node:20-bookworm

USER root

# 1. Installation de FFmpeg
RUN apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*

# 2. Installation de n8n
RUN npm install -g n8n --unsafe-perm

# 3. Installation du nœud TikTok
RUN npm install -g n8n-nodes-tiktok --ignore-scripts --unsafe-perm

# 4. Configuration des dossiers et permissions
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node
USER node
WORKDIR /home/node

# VARIABLES CRITIQUES (Forcent l'IPv4 et le port)
ENV NODE_OPTIONS="--dns-result-order=ipv4first"
ENV N8N_PORT=5678
ENV PORT=5678
ENV N8N_ENABLE_COMMAND_SUBSTITUTION=true
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok

EXPOSE 5678

# Démarrage forcé sur le port 5678
CMD ["n8n", "start", "--port=5678"]
