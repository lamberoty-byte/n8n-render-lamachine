# 1. On garde l'image qui fonctionne chez vous
FROM n8nio/n8n:1.74.3

USER root

# 2. Installation via APK (obligatoire sur Alpine)
# Nous installons FFmpeg, Python et les outils de compilation
RUN apk add --no-cache \
    ffmpeg \
    python3 \
    make \
    g++ \
    build-base \
    git

# 3. Installation du nœud TikTok
WORKDIR /
RUN npm install -g n8n-nodes-tiktok --ignore-scripts --omit=dev

# 4. Configuration du chemin des extensions
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok

# 5. On repasse sur l'utilisateur 'node'
USER node

# 6. Lancement
ENTRYPOINT ["tini", "--", "n8n"]
