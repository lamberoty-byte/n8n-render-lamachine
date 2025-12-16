# 1. Image de base n8n
FROM n8nio/n8n:latest

# 2. Passer en root pour les installations
USER root

# 3. Installer FFmpeg (Toujours requis pour vos vidéos)
RUN apk add --no-cache ffmpeg

# 4. Installer le nœud TikTok GLOBALEMENT avec NPM
# --ignore-scripts : Contourne l'interdiction "only-allow pnpm"
# --omit=dev : N'installe que le nécessaire pour gagner de la place
# Nous ne changeons PAS de répertoire (WORKDIR), ce qui évite les conflits avec le package.json de n8n
RUN npm install -g n8n-nodes-tiktok --ignore-scripts --omit=dev

# 5. Définir la variable pour que n8n trouve le nœud
# Par sécurité, on force n8n à regarder dans le dossier global
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok

# 6. Revenir à l'utilisateur sécurisé
USER node
