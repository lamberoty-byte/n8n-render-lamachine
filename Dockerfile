# 1. On FORCE la version Debian pour être SUR d'avoir apt-get
FROM n8nio/n8n:latest-debian

# 2. Passer en root pour les installations
USER root

# 3. Installation des outils avec apt-get (Garanti sur cette image)
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

# 6. Revenir à l'utilisateur sécurisé
USER node
