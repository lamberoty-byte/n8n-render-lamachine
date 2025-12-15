# 1. Image de base n8n
FROM n8nio/n8n:latest

# 2. Passer en root pour les installations (obligatoire pour apk)
USER root

# 3. Installer FFmpeg (Pour le traitement des fichiers vidéo/audio)
RUN apk add --no-cache ffmpeg

# 4. Installer pnpm via npm (nécessaire pour gérer les dépendances "workspace:" du noeud)
RUN npm install -g pnpm

# 5. Se placer dans le répertoire d'installation de n8n
WORKDIR /usr/local/lib/node_modules/n8n

# 6. CORRECTION DE L'ERREUR PNPM_UNEXPECTED_STORE
# Supprimer les métadonnées de cache existantes qui causent un conflit 
# entre l'environnement de build de n8n et votre environnement actuel.
RUN rm -f node_modules/.modules.yaml

# 7. Installer le nœud TikTok AVEC pnpm mais LOCALEMENT
# 'pnpm add' sans '-g' résout le problème de chemin d'installation global et le problème de protocole.
RUN pnpm add n8n-nodes-tiktok

# 8. Revenir à l'utilisateur sécurisé 'node'
USER node
