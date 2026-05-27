FROM fedora:45
ARG TARGETARCH=amd64
RUN dnf -y update && yum clean all
RUN dnf install -y git bash vim python3 wget jq yq curl python3-pip poppler-utils pandoc && \
    adduser user && \
    wget https://go.dev/dl/go1.26.2.linux-${TARGETARCH}.tar.gz && \
    rm -rf /usr/local/go && tar -C /usr/local -xzf go1.26.2.linux-${TARGETARCH}.tar.gz && \
    rm go1.26.2.linux-${TARGETARCH}.tar.gz
USER user 
RUN curl -fsSL https://claude.ai/install.sh | bash
COPY entrypoint.sh /
COPY .bashrc /home/user/.bashrc
COPY .bashrc /root/.bashrc
ENTRYPOINT /entrypoint.sh 

