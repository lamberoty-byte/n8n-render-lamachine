# 1. Image fixe (Debian) - Ne change pas d'un build à l'autre
FROM n8nio/n8n:1.71.1

USER root

# 2. Nettoyage et mise à jour des dépôts Debian
RUN apt-get update && apt-get install -y \
    ffmpeg \
    python3 \
    python3-dev \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# 3. Installation du nœud TikTok
WORKDIR /
RUN npm install -g n8n-nodes-tiktok --ignore-scripts --omit=dev

# 4. Configuration
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok

# 5. Sécurité Render : On bascule sur l'utilisateur node
USER node

# 6. Bypass du script d'entrée pour éviter "Operation not permitted"
ENTRYPOINT ["tini", "--", "n8n"]
