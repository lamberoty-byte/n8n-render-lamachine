# 1. Utilisation de l'image Debian officielle (le tag exact de Docker Hub)
FROM n8nio/n8n:latest-debian

# 2. Passage en ROOT pour l'installation
USER root

# 3. Installation des outils (Maintenant garanti sur cette image)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    python3 \
    python3-dev \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# 4. Installation du nœud TikTok
WORKDIR /
RUN npm install -g n8n-nodes-tiktok --ignore-scripts --omit=dev

# 5. Configuration du chemin
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok

# 6. On repasse sur l'utilisateur 'node' pour Render
USER node

# 7. Lancement
ENTRYPOINT ["tini", "--", "n8n"]
