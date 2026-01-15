# 1. Image de base officielle
FROM n8nio/n8n:latest

# 2. On passe en root pour avoir les droits d'installation
USER root

# 3. Installation pour DEBIAN (car votre log dit "apk: not found")
# On nettoie le cache à la fin pour gagner de la place
RUN apt-get update && apt-get install -y \
    ffmpeg \
    python3 \
    python3-dev \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# 4. Installation de TikTok en mode GLOBAL
# IMPORTANT : On ne change PAS de WORKDIR pour ne pas perdre les commandes n8n
RUN npm install -g n8n-nodes-tiktok --ignore-scripts --omit=dev

# 5. On définit le chemin pour que n8n trouve le nœud
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok

# 6. On repasse sur l'utilisateur 'node'
USER node

# On laisse n8n utiliser son propre système de démarrage (pas d'ENTRYPOINT)
