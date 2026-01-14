# 1. Utilisation de la version stable la plus récente
FROM n8nio/n8n:latest

USER root

# 2. Installation des outils requis (Base Alpine)
# build-base contient make et g++ indispensables pour compiler certains modules npm
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

# 4. Configuration du dossier des extensions pour n8n
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok

# 5. On repasse sur l'utilisateur 'node' pour la sécurité Render
USER node

# 6. On force le démarrage via tini pour éviter les erreurs "Operation not permitted"
ENTRYPOINT ["tini", "--", "n8n"]
