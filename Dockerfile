FROM fedora:45
ARG TARGETARCH=amd64
ENV CLAUDE_CONFIG_DIR=/claude-config
RUN dnf -y update && yum clean all
RUN dnf install -y git bash vim python3 wget jq yq curl python3-pip poppler-utils pandoc opentofu make librsvg2-tools inkscape ImageMagick python3-cairosvg && \
    adduser user && \
    wget https://go.dev/dl/go1.26.2.linux-${TARGETARCH}.tar.gz && \
    rm -rf /usr/local/go && tar -C /usr/local -xzf go1.26.2.linux-${TARGETARCH}.tar.gz && \
    rm go1.26.2.linux-${TARGETARCH}.tar.gz && \ 
    mkdir -p /claude-config && \
    touch /claude-config/.keep && \
    chown -R 1000:1000 /claude-config && \
    curl -L https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh && \
    chmod +x ./dotnet-install.sh && \
    mkdir /usr/local/dotnet && \
    ./dotnet-install.sh --runtime dotnet --channel 8.0 --quality preview --install-dir /usr/local/dotnet && \
    rm -f  ./dotnet-install.sh 
USER 1000:1000
ENV PATH="${PATH}:/usr/local/go/bin:/home/user/go/bin:/usr/local/dotnet"
ENV GOPATH="/home/user/go"
WORKDIR /tmp
RUN curl -fsSL https://claude.ai/install.sh | bash && \
    curl -fsSL https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.sh | bash && \
    mkdir -p /home/user/go/bin 
COPY entrypoint.sh /
COPY .bashrc /home/user/.bashrc
COPY .bashrc /root/.bashrc
ENTRYPOINT ["/entrypoint.sh"]




