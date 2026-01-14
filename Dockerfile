# 1. On prend la dernière version officielle (qui est sous Debian)
FROM n8nio/n8n:latest

# 2. On passe en root pour avoir le droit d'installer des logiciels
USER root

# 3. Installation des dépendances avec apt-get (car nous sommes sur Debian)
# On installe FFmpeg, Python et les outils de compilation pour TikTok
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

# 5. On indique à n8n où trouver le nœud TikTok
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok

# 6. CRUCIAL POUR RENDER : On rebascule sur l'utilisateur 'node'
USER node

# 7. On force le démarrage propre pour éviter le crash "Operation not permitted"
ENTRYPOINT ["tini", "--", "n8n"]
