# 1. Image de base officielle (Alpine - Node 20+)
FROM n8nio/n8n:latest

# 2. On passe en root pour installer FFmpeg
USER root

# 3. Installation des outils (Base Alpine)
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

# 5. Configuration des chemins
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok

# 6. CRUCIAL POUR RENDER : On force l'utilisateur 'node' dès maintenant
# et on court-circuite le script de démarrage qui cause l'erreur "Operation not permitted"
USER node

# 7. On lance n8n directement sans passer par le script 'entrypoint' qui bugge sur Render
ENTRYPOINT ["tini", "--", "n8n"]
