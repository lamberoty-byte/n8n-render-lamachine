# 1. Image de base
FROM n8nio/n8n:latest

# 2. Passer en root
USER root

# 3. Installer FFmpeg
RUN apk add --no-cache ffmpeg

# 4. ASTUCE CRITIQUE : Se placer à la racine pour éviter les restrictions de dossier n8n
WORKDIR /

# 5. Installer le nœud TikTok GLOBALEMENT
# --ignore-scripts : OBLIGATOIRE pour contourner l'erreur "only-allow pnpm" que vous avez eue
# --omit=dev : Pour alléger l'installation
RUN npm install -g n8n-nodes-tiktok --ignore-scripts --omit=dev

# 6. Dire à n8n où trouver ce nouveau nœud
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok

# 7. Revenir à l'utilisateur sécurisé
USER node
