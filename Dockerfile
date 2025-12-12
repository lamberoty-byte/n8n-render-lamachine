# Étape 1: BUILDER - Utilisation de Debian pour installer FFmpeg et toutes ses dépendances (avec glibc).
FROM debian:stable-slim AS ffmpeg_builder

# Installer FFmpeg et les outils de base Debian
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    libssl-dev \
    locales \
    # Installer les librairies C standard (glibc et libstdc++)
    libc6 \
    libstdc++6 \
    # Nettoyage
    && rm -rf /var/lib/apt/lists/*


# Étape 2: FINAL - Utiliser l'image n8n (Alpine) et copier les dépendances.
FROM n8nio/n8n:latest

# Passer à root pour les copies
USER root

# COPIE 1: Copier l'exécutable FFmpeg
COPY --from=ffmpeg_builder /usr/bin/ffmpeg /usr/local/bin/ffmpeg

# COPIE 2: Copier TOUTES les librairies GLIBC et STD C++
# Ceci est l'étape la plus critique pour résoudre les erreurs de "symbole introuvable" (libstdc++ et libgcc)
COPY --from=ffmpeg_builder /usr/lib/x86_64-linux-gnu/ /usr/lib/
COPY --from=ffmpeg_builder /lib/x86_64-linux-gnu/ /lib/

# COPIE 3: Copier le chargeur dynamique GLIBC lui-même pour surmonter l'erreur ld-linux-x86-64.so.2
# Il doit être copié à la racine /lib/ pour être trouvé par le binaire FFmpeg
COPY --from=ffmpeg_builder /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 /lib/ld-linux-x86-64.so.2

# COPIE 4: Copier le binaire GLIBC lui-même pour les symboles manquants
COPY --from=ffmpeg_builder /lib/x86_64-linux-gnu/libc.so.6 /lib/libc.so.6
COPY --from=ffmpeg_builder /usr/lib/ /usr/lib/

# Revenir à l'utilisateur par défaut 'node' pour la sécurité.
USER node
