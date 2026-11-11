FROM alpine:3.21

# Set the environment variable for kubectl version
# This is the version of kubectl you want to install. You can change it as needed.
ENV KUBECTL_VERSION=v1.33.4
# Install required tools and kubectl
RUN  apk add --no-cache curl bash ca-certificates \
  # && KUBECTL_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt) \
  && curl -LO https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
  && apk update && apk upgrade \
  && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
  && rm -f kubectl

# Create user and group with ID 1001 (Bitnami style)
RUN addgroup -g 1001 app && adduser -D -u 1001 -G app app

# Switch to non-root user
USER app

# Set default shell to bash
SHELL ["/bin/bash", "-c"]

# Entrypoint for debugging (override as needed)
ENTRYPOINT ["kubectl"]
