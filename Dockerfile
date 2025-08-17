FROM debian:stable-slim

LABEL org.opencontainers.image.title="toolbox"
LABEL org.opencontainers.image.source="https://github.com/pnowy/toolbox"
LABEL org.opencontainers.image.description="Debian stable-slim with kubectl, kubectx, kubens, yq, jq, httpie and other tools"
LABEL maintainer="pnowy"

ENV KUBECTX_VERSION="0.9.5"

RUN apt update && \
    apt install -y --no-install-recommends \
        ca-certificates \
        wget \
        tar \
        git \
        curl \
        jq \
        yq \
        gnupg2 \
        iputils-ping \
        dnsutils \
        httpie \
    && rm -rf /var/lib/apt/lists/* \
    && dpkgArch="$(dpkg --print-architecture)" \
    && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/${dpkgArch}/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm -f kubectl \
    && curl -L -o /usr/local/bin/kubectx https://raw.githubusercontent.com/ahmetb/kubectx/v${KUBECTX_VERSION}/kubectx \
	&& curl -L -o /usr/local/bin/kubens https://raw.githubusercontent.com/ahmetb/kubectx/v${KUBECTX_VERSION}/kubens \
    && chmod +x /usr/local/bin/kubectx && chmod +x /usr/local/bin/kubens

RUN mkdir -p $HOME/.kube
