# 1. On utilise une version spécifique très récente sous Debian Bookworm
FROM n8nio/n8n:1.74.3-debian

USER root

# 2. Mise à jour et installation (Cette fois les dépôts seront trouvés)
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

# 5. Retour utilisateur node
USER node

# 6. Lancement
ENTRYPOINT ["tini", "--", "n8n"]
