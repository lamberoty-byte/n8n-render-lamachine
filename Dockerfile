# 1. On utilise une base Node.js certifiée (Debian Bookworm)
# C'est une image stable où apt-get est GARANTI
FROM node:20-bookworm

# 2. Installation de TOUT ce dont vous avez besoin (FFmpeg, Python, etc.)
USER root
RUN apt-get update && apt-get install -y \
    ffmpeg \
    python3 \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# 3. Installation de n8n et du nœud TikTok en global
# --unsafe-perm est nécessaire pour l'installation globale de n8n
RUN npm install -g n8n n8n-nodes-tiktok --unsafe-perm

# 4. Configuration de l'environnement
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok
ENV NODE_ENV=production

# 5. Création d'un dossier de travail pour éviter les erreurs de permission
WORKDIR /home/node/.n8n
RUN chown -R node:node /home/node

# 6. On repasse sur l'utilisateur node
USER node

# 7. Port par défaut de n8n
EXPOSE 5678

# 8. Commande de lancement propre
CMD ["n8n", "start"]
