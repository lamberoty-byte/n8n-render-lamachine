# 1. Image de base n8n (Alpine)
FROM n8nio/n8n:latest

# 2. Passer en root pour les installations (obligatoire pour apk et pnpm)
USER root

# 3. Installer FFmpeg
RUN apk add --no-cache ffmpeg

# 4. Installer l'outil de gestion des paquets 'pnpm' (NÉCESSAIRE pour le nœud TikTok)
RUN npm install -g pnpm

# 5. Installer le nœud communautaire TikTok
# Nous utilisons 'pnpm' ici pour éviter l'erreur 'only-allow pnpm' que vous aviez.
# Le répertoire doit être créé en premier, car pnpm en Alpine pose problème sinon.
RUN mkdir -p /usr/local/lib/node_modules/n8n-nodes-tiktok
RUN pnpm install -g n8n-nodes-tiktok

# 6. Revenir à l'utilisateur sécurisé 'node'
USER node
