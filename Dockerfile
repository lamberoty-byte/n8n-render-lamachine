# 1. On utilise le tag exact (SANS le mot -debian)
FROM n8nio/n8n:1.74.3

# 2. Passage en ROOT pour installer les outils
USER root

# 3. Mise à jour des dépôts et installation de FFmpeg et Python
# On ajoute une commande pour forcer la mise à jour des certificats
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ffmpeg \
    python3 \
    python3-dev \
    build-essential \
    git \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# 4. Installation du nœud TikTok
WORKDIR /
RUN npm install -g n8n-nodes-tiktok --ignore-scripts --omit=dev

# 5. Configuration du chemin des extensions
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok

# 6. Rebasculer sur l'utilisateur 'node' (impératif pour Render)
USER node

# 7. Commande de démarrage
ENTRYPOINT ["tini", "--", "n8n"]
