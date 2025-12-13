FROM n8nio/n8n:latest

USER root

# 1. Installer FFmpeg
RUN apk add --no-cache ffmpeg

# 2. Installer le nœud TikTok (avec la correction anti-plantage)
RUN npm install -g n8n-nodes-tiktok --ignore-scripts

USER node
