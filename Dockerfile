# 1. Utiliser l'image officielle n8n (Alpine)
FROM n8nio/n8n:latest

# 2. Passer en root (administrateur) pour installer les outils
USER root

# 3. Installer FFmpeg (MÉTHODE APPROUVÉE)
RUN apk add --no-cache ffmpeg

# 4. Installer le nœud communautaire TikTok
# Nous l'installons globalement pour qu'il soit accessible par n8n
RUN npm install -g n8n-nodes-tiktok

# 5. Revenir à l'utilisateur 'node' pour la sécurité
USER node
