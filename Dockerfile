# 1. Image de base n8n
FROM n8nio/n8n:latest

# 2. Passer en root pour les installations
USER root

# 3. Installer FFmpeg (Indispensable pour vos vidéos)
RUN apk add --no-cache ffmpeg

# 4. Installer le nœud TikTok en forçant l'installation
# L'option --ignore-scripts contourne l'erreur "only-allow pnpm"
RUN npm install -g n8n-nodes-tiktok --ignore-scripts

# 5. Revenir à l'utilisateur sécurisé
USER node
