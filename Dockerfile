# Étape 1: Utiliser une image de base Alpine (l'approche la plus courante pour les images légères)
FROM n8nio/n8n:latest

# Passer temporairement à l'utilisateur 'root' pour l'installation des paquets
USER root

# Installer FFmpeg et toutes ses dépendances en utilisant le gestionnaire de paquets Alpine (apk)
# Le paquet 'ffmpeg' sur Alpine contient le binaire et toutes ses dépendances.
# L'option '--no-cache' et la suppression de la liste 'apk' à la fin gardent l'image légère.
RUN apk add --no-cache ffmpeg && \
    # Nettoyer
    rm -rf /var/cache/apk/*

# Revenir à l'utilisateur par défaut n8n pour la sécurité
USER node
