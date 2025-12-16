# 1. Image de base n8n
FROM n8nio/n8n:latest

# 2. Passer en root pour les installations
USER root

# 3. Installer les dépendances essentielles (Python et outils de compilation)
# Ces outils sont souvent requis par des packages Node complexes comme ceux qui gèrent les fichiers/vidéos
RUN apk add --no-cache build-base python3

# 4. Installer FFmpeg (Traitement vidéo)
RUN apk add --no-cache ffmpeg

# 5. Se placer à la racine pour éviter les restrictions de dossier n8n
WORKDIR /

# 6. Installer le nœud TikTok GLOBALEMENT
# --ignore-scripts est OBLIGATOIRE pour contourner l'erreur "only-allow pnpm"
RUN npm install -g n8n-nodes-tiktok --ignore-scripts --omit=dev

# 7. Dire à n8n où trouver ce nouveau nœud (essentiel car installé globalement)
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok

# 8. Revenir à l'utilisateur sécurisé
USER node
