# 1. Image de base n8n (Alpine)
FROM n8nio/n8n:latest

# 2. Passer en root pour les installations
USER root

# 3. Installer FFmpeg
RUN apk add --no-cache ffmpeg

# 4. Installer le nœud TikTok alternatif (plus stable à installer)
RUN npm install -g n8n-nodes-tiktok-uploader

# 5. Revenir à l'utilisateur sécurisé 'node'
USER node
