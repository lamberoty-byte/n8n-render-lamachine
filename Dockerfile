# 1. On précise explicitement ALPINE pour que 'apk' fonctionne
FROM n8nio/n8n:latest-alpine

# 2. Passage en root pour l'installation
USER root

# 3. Installation des outils (Cette fois 'apk' sera bien là)
RUN apk add --no-cache \
    ffmpeg \
    python3 \
    make \
    g++ \
    build-base \
    git

# 4. Installation du nœud TikTok
WORKDIR /
RUN npm install -g n8n-nodes-tiktok --ignore-scripts --omit=dev

# 5. Configuration du chemin
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok

# 6. CRUCIAL POUR RENDER : On force l'utilisateur node
USER node

# 7. On court-circuite le script de démarrage pour éviter "Operation not permitted"
ENTRYPOINT ["tini", "--", "n8n"]
