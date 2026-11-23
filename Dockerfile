FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends nginx-light ca-certificates curl libfontconfig1 \
    && rm -rf /var/lib/apt/lists/*
ARG BUILD_URL=https://github.com/Bercail-online/kitties-mayhem-server/releases/download/server-1.1.0/KittiesMayhem-linux.tar.gz
WORKDIR /app
RUN curl -fsSL "$BUILD_URL" -o /tmp/km.tgz && mkdir /tmp/km && tar -xzf /tmp/km.tgz -C /tmp/km \
    && find /tmp/km -name KittiesMayhem.x86_64 -type f -exec mv {} /app/ \; && rm -rf /tmp/km /tmp/km.tgz \
    && chmod +x /app/KittiesMayhem.x86_64
COPY nginx.conf start.sh /app/
RUN chmod +x /app/start.sh && useradd -m -u 1000 kitty && chown -R kitty /app
USER kitty
ENV HOME=/home/kitty PORT=10000 BOTS=3 FRAGS=15 TIME=300
EXPOSE 10000
CMD ["/app/start.sh"]
