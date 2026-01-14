# 1. Image que Render arrive à télécharger
FROM n8nio/n8n:latest

# 2. Passage en root pour l'installation
USER root

# 3. Installation des outils (Version Alpine car 'latest' est maintenant Alpine)
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

# 6. Sécurité Render : On définit l'utilisateur avant le lancement
USER node

# 7. On lance n8n en ignorant le script d'entrée qui cause l'erreur de permission
ENTRYPOINT ["tini", "--", "n8n"]
