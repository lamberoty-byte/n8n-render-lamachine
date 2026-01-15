# 1. Base Node.js stable
FROM node:20-bookworm

# 2. Installation des dépendances système
USER root
RUN apt-get update && apt-get install -y \
    ffmpeg \
    python3 \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# 3. Installation de n8n normalement
RUN npm install -g n8n --unsafe-perm

# 4. Installation de TikTok en IGNORANT leur blocage pnpm
# Le flag --ignore-scripts est la clé ici
RUN npm install -g n8n-nodes-tiktok --ignore-scripts --unsafe-perm

# 5. Configuration de l'environnement
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok
ENV NODE_ENV=production

# 6. Dossier de travail
WORKDIR /home/node/.n8n
RUN chown -R node:node /home/node

# 7. Passage à l'utilisateur non-root
USER node

# 8. Lancement
EXPOSE 5678
CMD ["n8n", "start"]
