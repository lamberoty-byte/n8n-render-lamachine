FROM debian:stable-slim AS ffmpeg_builder
RUN apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*
FROM n8nio/n8n:latest
USER root
COPY --from=ffmpeg_builder /usr/bin/ffmpeg /usr/local/bin/ffmpeg
USER node
