# Use an official Ubuntu as a base image
FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    sudo \
    wget \
    gnupg \
    ca-certificates \
    apt-transport-https \
    desktop-file-utils \
    xdg-utils \
    dbus-x11 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Add user to the docker group
ARG USER_ID
RUN useradd -m -s /bin/bash --uid $USER_ID user \
    && usermod -aG sudo,docker user \
    && echo "user:password" | chpasswd

# Copy your application files into the container
COPY . /app

# Set the working directory
WORKDIR /app

# Expose any ports your app needs
EXPOSE 8080

# Start Chrome Remote Desktop
CMD ["sh", "-c", "DISPLAY= /opt/google/chrome-remote-desktop/start-host --code=4/0AeaYSHCwv_MT8geuCsro52oCxfVHWKUt1YMRf2EAFSe_txw-c4kMz8aEqj7WSZ9aeZgDZA --redirect-url=https://remotedesktop.google.com/_/oauthredirect --name=$(hostname) --user-name=user --pin=123456"]
