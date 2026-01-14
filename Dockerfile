# 1. Image standard (celle que Render trouve sans problème)
FROM n8nio/n8n:latest

USER root

# 2. Correction des dépôts Debian (au cas où l'image est ancienne)
RUN if grep -q "buster" /etc/os-release; then \
    sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org/debian-security|archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    sed -i '/buster-updates/d' /etc/apt/sources.list; \
    fi

# 3. Installation avec apt-get (Debian) et non apk (Alpine)
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

# 5. Configuration
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok

# 6. Bypass de l'erreur "Operation not permitted" de Render
USER node
ENTRYPOINT ["tini", "--", "n8n"]
