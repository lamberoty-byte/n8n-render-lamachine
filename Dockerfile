# 1. Utilisation de l'image Debian
FROM n8nio/n8n:latest-debian

USER root

# 2. Correction des dépôts Debian Buster (car la version est en fin de vie)
# Cette étape permet à apt-get de fonctionner à nouveau
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org/debian-security|archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    sed -i '/buster-updates/d' /etc/apt/sources.list

# 3. Installation de FFmpeg et des dépendances (Maintenant ça va marcher !)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    python3 \
    python3-dev \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# 4. Installation du nœud TikTok
WORKDIR /
RUN npm install -g n8n-nodes-tiktok --ignore-scripts --omit=dev

# 5. Configuration du chemin des extensions
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok

# 6. Revenir à l'utilisateur n8n
USER node
