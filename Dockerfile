# 1. On utilise la dernière version officielle
FROM n8nio/n8n:latest

USER root

# 2. SCRIPT HYBRIDE : Détecte automatiquement si on est sur Alpine ou Debian
# Si "apk" existe, on l'utilise. Sinon, on utilise "apt-get".
RUN if command -v apk > /dev/null; then \
        echo "Alpine Linux détecté. Installation via APK..."; \
        apk add --no-cache ffmpeg python3 make g++ build-base git; \
    elif command -v apt-get > /dev/null; then \
        echo "Debian Linux détecté. Installation via APT..."; \
        apt-get update && apt-get install -y ffmpeg python3 python3-dev build-essential git; \
        rm -rf /var/lib/apt/lists/*; \
    else \
        echo "ERREUR CRITIQUE : Impossible de détecter le gestionnaire de paquets."; \
        exit 1; \
    fi

# 3. Installation du nœud TikTok
WORKDIR /
RUN npm install -g n8n-nodes-tiktok --ignore-scripts --omit=dev

# 4. Configuration des extensions
ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok

# 5. Retour à l'utilisateur sécurisé
USER node

# 6. Lancement
ENTRYPOINT ["tini", "--", "n8n"]
