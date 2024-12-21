FROM debian:stable-slim
RUN apt-get update && \
    apt-get install --assume-yes curl lsb-release gpg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN curl https://pkg.cloudflareclient.com/pubkey.gpg | gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg

RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] \
    https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/cloudflare-client.list

RUN apt-get update && \
    apt-get install --assume-yes cloudflare-warp && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "warp-cli" ]
