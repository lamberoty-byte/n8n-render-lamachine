FROM node:20-bookworm

USER root
RUN apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*
RUN npm install -g n8n --unsafe-perm
RUN npm install -g n8n-nodes-tiktok --ignore-scripts --unsafe-perm

RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node
USER node
WORKDIR /home/node

ENV N8N_CUSTOM_EXTENSIONS=/usr/local/lib/node_modules/n8n-nodes-tiktok
ENV N8N_ENABLE_COMMAND_SUBSTITUTION=true
ENV PORT=5678

EXPOSE 5678

# Force l'activation du nœud Execute Command et TikTok
CMD ["n8n", "start", "--port=5678"]
