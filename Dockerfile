# 1. ON FORCE L'IMAGE DEBIAN EXPLICITEMENT
# Cela garantit que "apt-get" existe. Plus de doute possible.
FROM n8nio/n8n:debian

USER root

# 2. Installation avec apt-get (Maintenant garanti de fonctionner)
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

# 6. Lancement sécurisé
ENTRYPOINT ["tini", "--", "n8n"]
