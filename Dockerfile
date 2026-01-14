# 1. Utilisation de la version UBUNTU (plus fiable pour les installations)
FROM n8nio/n8n:latest-ubuntu

# 2. Passage en ROOT obligatoire pour installer FFmpeg
USER root

# 3. Installation propre sur base Ubuntu/Debian
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

# 5. On indique à n8n où est le nœud
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok

# 6. On repasse sur l'utilisateur par défaut pour Render
USER node

# 7. Lancement
ENTRYPOINT ["tini", "--", "n8n"]
