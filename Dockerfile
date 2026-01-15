# 1. Image de base (Alpine) qui a fonctionné au build précédent
FROM n8nio/n8n:latest

USER root

# 2. Installation des dépendances système pour TikTok et FFmpeg
RUN apk add --no-cache ffmpeg python3 make g++ build-base git

# 3. Installation du nœud TikTok en GLOBAL
# On ne change PAS de WORKDIR pour ne pas casser n8n
RUN npm install -g n8n-nodes-tiktok --ignore-scripts --omit=dev

# 4. On indique à n8n où trouver le nœud installé
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok

# 5. On revient à l'utilisateur par défaut sans rien toucher d'autre
USER node

# 6. On ne définit PAS d'ENTRYPOINT personnalisé (on laisse celui de n8n par défaut)
