FROM debian:stable-slim AS ffmpeg_builder
RUN apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*
FROM n8nio/n8n:latest
USER root
COPY --from=ffmpeg_builder /usr/bin/ffmpeg /usr/local/bin/ffmpeg
COPY --from=ffmpeg_builder /usr/lib/x86_64-linux-gnu/libav* /usr/lib/
COPY --from=ffmpeg_builder /usr/lib/x86_64-linux-gnu/libsw* /usr/lib/
COPY --from=ffmpeg_builder /usr/lib/x86_64-linux-gnu/libpostproc* /usr/lib/
USER node
