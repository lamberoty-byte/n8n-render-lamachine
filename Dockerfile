# 1. Image de base n8n
FROM n8nio/n8n:latest

# 2. Passer en root
USER root

# 3. Installer les dépendances essentielles (Python et outils de compilation)
# Ajout de git et python3-dev pour la stabilité de l'environnement n8n interne
RUN apk add --no-cache build-base python3 python3-dev git

# 4. Installer FFmpeg (Traitement vidéo)
RUN apk add --no-cache ffmpeg

# 5. Se placer à la racine pour éviter les restrictions de dossier n8n
WORKDIR /

# 6. Installer le nœud TikTok GLOBALEMENT
# --ignore-scripts est OBLIGATOIRE
RUN npm install -g n8n-nodes-tiktok --ignore-scripts --omit=dev

# 7. Dire à n8n où trouver ce nouveau nœud
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok

# 8. Revenir à l'utilisateur sécurisé
USER node
