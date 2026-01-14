# 1. Image de base n8n (Basée sur Debian désormais)
FROM n8nio/n8n:latest

# 2. Passer en root pour les installations
USER root

# 3. Mettre à jour les dépôts et installer les dépendances avec apt-get
# build-essential remplace build-base sur Debian
RUN apt-get update && apt-get install -y \
    build-essential \
    python3 \
    python3-dev \
    git \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# 4. Se placer à la racine pour l'installation du nœud
WORKDIR /

# 5. Installer le nœud TikTok GLOBALEMENT
# On garde --ignore-scripts pour éviter le conflit pnpm
RUN npm install -g n8n-nodes-tiktok --ignore-scripts --omit=dev

# 6. Configurer le chemin des extensions
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok

# 7. Revenir à l'utilisateur n8n
USER node
