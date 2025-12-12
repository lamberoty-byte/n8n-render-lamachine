# Étape 1: BUILDER - Utilisation de Debian (qui a apt-get) pour installer FFmpeg et toutes ses dépendances.
FROM debian:stable-slim AS ffmpeg_builder

# Installer le paquet ffmpeg et les dépendances nécessaires au fonctionnement du binaire.
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    libssl-dev \
    locales \
    # Nettoyage
    && rm -rf /var/lib/apt/lists/*


# Étape 2: FINAL - Utiliser l'image n8n et COPIER les éléments nécessaires depuis l'étape 1
FROM n8nio/n8n:latest

# Passer temporairement à l'utilisateur 'root' pour effectuer la copie
USER root

# COPIE 1: Copier l'exécutable FFmpeg
# Il est copié dans un chemin de PATH standard (/usr/local/bin)
COPY --from=ffmpeg_builder /usr/bin/ffmpeg /usr/local/bin/ffmpeg

# COPIE 2: Copier TOUTES les dépendances du système nécessaires pour l'exécution
# Copie des bibliothèques standard pour résoudre les dépendances manquantes.
COPY --from=ffmpeg_builder /usr/lib/x86_64-linux-gnu/ /usr/lib/
COPY --from=ffmpeg_builder /lib/x86_64-linux-gnu/ /lib/
COPY --from=ffmpeg_builder /usr/lib/ /usr/lib/

# --- LA LIGNE RUN ldconfig EST SUPPRIMÉE ICI ---

# Revenir à l'utilisateur par défaut 'node' pour des raisons de sécurité
USER node
