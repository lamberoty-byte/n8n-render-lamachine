# 1. On fixe la dernière version stable connue sous Debian
FROM n8nio/n8n:1.74.3

USER root

# 2. Installation avec apt-get (Gestionnaire Debian)
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

# 5. Sécurité Render : On repasse sur l'utilisateur node
USER node

# 6. Bypass du script d'entrée pour éviter les crashs de permission sur Render
ENTRYPOINT ["tini", "--", "n8n"]
