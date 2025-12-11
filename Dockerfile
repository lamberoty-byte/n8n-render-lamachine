FROM n8nio/n8n:1.0.0-debian
RUN apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*
