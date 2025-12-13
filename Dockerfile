# 1. Utiliser l'image officielle n8n (Alpine)
FROM n8nio/n8n:latest

# 2. Passer en root pour les installations (obligatoire pour apk et npm global)
USER root

# 3. Installation du binaire SYSTEME (FFmpeg)
RUN apk add --no-cache ffmpeg

# 4. Installation du package NODE.JS (TikTok)
# Cette étape est séparée pour garantir que l'environnement Node.js est bien initialisé
RUN npm install -g n8n-nodes-tiktok

# 5. Revenir à l'utilisateur 'node' pour la sécurité
USER node
