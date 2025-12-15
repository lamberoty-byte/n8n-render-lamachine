# 1. Image de base
FROM n8nio/n8n:latest

# 2. Passer en root
USER root

# 3. Installer FFmpeg (pour le traitement vidéo)
RUN apk add --no-cache ffmpeg

# 4. Installer pnpm via npm (nécessaire pour lire le paquet TikTok)
RUN npm install -g pnpm

# 5. Se placer dans le dossier d'installation de n8n
WORKDIR /usr/local/lib/node_modules/n8n

# 6. Installer le nœud TikTok AVEC pnpm mais LOCALEMENT
# 'pnpm add' sans '-g' installe le paquet directement dans le dossier courant
# Cela contourne l'erreur de chemin global ET l'erreur de protocole npm.
RUN pnpm add n8n-nodes-tiktok

# 7. Revenir à l'utilisateur sécurisé
USER node
