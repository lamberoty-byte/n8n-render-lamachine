# 1. Utilisation du tag officiel exact pour Alpine
FROM n8nio/n8n:alpine

# 2. Passage en root pour installer les outils système
USER root

# 3. Installation des outils (apk fonctionne sur l'image alpine)
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

# 5. Configuration du chemin des extensions
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok

# 6. Crucial pour Render : On définit l'utilisateur avant le lancement
USER node

# 7. On lance n8n directement pour éviter les erreurs de permissions ("Operation not permitted")
ENTRYPOINT ["tini", "--", "n8n"]
