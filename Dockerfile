# 1. Image de base n8n (Alpine)
FROM n8nio/n8n:latest

# 2. Passer en root pour les installations (obligatoire pour apk)
USER root

# 3. Installer FFmpeg
RUN apk add --no-cache ffmpeg

# 4. Définir le répertoire de travail
WORKDIR /usr/local/lib/node_modules/n8n/

# 5. Installer le nœud communautaire TikTok
# Nous utilisons 'npm' et non 'pnpm' ici pour éviter le ERR_PNPM_NO_GLOBAL_BIN_DIR.
# Cette installation est maintenant locale au dossier de n8n, ce qui est beaucoup plus stable.
RUN npm install n8n-nodes-tiktok

# 6. Revenir à l'utilisateur sécurisé 'node'
USER node
