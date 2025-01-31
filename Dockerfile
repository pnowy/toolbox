FROM debian:stable-slim

LABEL maintainer="pnowy"

RUN apt update && \
    apt install -y --no-install-recommends \
        wget \
        tar \
        software-properties-common \
        apt-transport-https \
        git \
        curl \
        jq \
        yq \
        gnupg2 \
        iputils-ping \
        dnsutils \
        httpie && \
    rm -rf /var/lib/apt/lists/*

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm -f kubectl

ENV KUBECTX_VERSION="0.9.5"
RUN curl -L -o /usr/local/bin/kubectx https://raw.githubusercontent.com/ahmetb/kubectx/v${KUBECTX_VERSION}/kubectx \
	&& curl -L -o /usr/local/bin/kubens https://raw.githubusercontent.com/ahmetb/kubectx/v${KUBECTX_VERSION}/kubens \
    && chmod +x /usr/local/bin/kubectx && chmod +x /usr/local/bin/kubens

RUN mkdir -p $HOME/.kube
