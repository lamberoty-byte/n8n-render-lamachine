# 1. Image de base n8n
FROM n8nio/n8n:latest

# 2. Passer en root pour les installations
USER root

# 3. Installer FFmpeg (Succès confirmé dans les logs précédents)
RUN apk add --no-cache ffmpeg

# 4. Installer pnpm via npm
RUN npm install -g pnpm

# 5. Se placer dans le répertoire de n8n
WORKDIR /usr/local/lib/node_modules/n8n

# 6. LA CORRECTION : Supprimer le fichier de métadonnées qui cause le conflit de "Store"
# Cela force pnpm à utiliser le magasin local actuel au lieu de chercher celui du serveur de build n8n.
RUN rm -f node_modules/.modules.yaml

# 7. Installer le nœud TikTok (Maintenant que le conflit est résolu)
RUN pnpm add n8n-nodes-tiktok

# 8. Revenir à l'utilisateur sécurisé
USER node
