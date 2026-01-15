FROM node:20-bookworm

USER root
RUN apt-get update && apt-get install -y ffmpeg python3 build-essential git && rm -rf /var/lib/apt/lists/*

# Installation globale
RUN npm install -g n8n --unsafe-perm
RUN npm install -g n8n-nodes-tiktok --ignore-scripts --unsafe-perm

# --- CONFIGURATION INTERNE FORCÉE ---
# On crée le dossier de config et on écrit les permissions directement dedans
RUN mkdir -p /home/node/.n8n
RUN echo '{"nodes":{"exclude":[]},"code":{"allowExternalModules":"All"}}' > /home/node/.n8n/config

# On s'assure que n8n a les droits de lire ce fichier
RUN chown -R node:node /home/node/.n8n
# ------------------------------------

ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok
ENV NODE_FUNCTION_ALLOW_EXTERNAL=child_process,fs,path
ENV N8N_ENABLE_COMMAND_SUBSTITUTION=true

WORKDIR /home/node/.n8n
USER node

EXPOSE 5678
CMD ["n8n", "start"]
