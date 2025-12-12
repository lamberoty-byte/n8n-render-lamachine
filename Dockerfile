
FROM debian:stable-slim AS ffmpeg_builder
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    libssl-dev \
    locales \
    && rm -rf /var/lib/apt/lists/*
FROM n8nio/n8n:latest
USER root
COPY --from=ffmpeg_builder /usr/bin/ffmpeg /usr/local/bin/ffmpeg
COPY --from=ffmpeg_builder /usr/lib/x86_64-linux-gnu/ /usr/lib/
COPY --from=ffmpeg_builder /lib/x86_64-linux-gnu/ /lib/
COPY --from=ffmpeg_builder /usr/lib/ /usr/lib/
USER node
