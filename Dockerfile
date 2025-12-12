# Étape 1: Utiliser l'image de base n8n (qui est basée sur Alpine/BusyBox)
FROM n8nio/n8n:latest

# Passer à l'utilisateur 'root' (administrateur) pour installer les paquets.
USER root

# Installer FFmpeg et ses dépendances avec le gestionnaire de paquets Alpine (apk).
RUN apk add --no-cache ffmpeg && \
    # Nettoyer le cache d'apk pour garder l'image légère
    rm -rf /var/cache/apk/*

# Étape CRUCIALE : Créer un lien symbolique vers un chemin du PATH plus universel.
# Cela garantit que le binaire est trouvé même si le PATH de l'utilisateur 'node' est restreint.
RUN ln -s /usr/bin/ffmpeg /usr/local/bin/ffmpeg

# Revenir à l'utilisateur par défaut 'node' pour des raisons de sécurité.
USER node
