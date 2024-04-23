# Use an official Ubuntu as a base image
FROM ubuntu:latest

# Install necessary packages for Chrome Remote Desktop
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

# Verify Chrome Remote Desktop Installation
RUN apt-get update && apt-get install -y google-chrome-stable chrome-remote-desktop --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Inspect Image Contents to Find start-host Script
RUN find / -name start-host

# Update Script Path in CMD (replace '/path/to/start-host' with the correct path)
CMD ["sh", "-c", "/path/to/start-host --code=4/0AeaYSHCwv_MT8geuCsro52oCxfVHWKUt1YMRf2EAFSe_txw-c4kMz8aEqj7WSZ9aeZgDZA --redirect-url=https://remotedesktop.google.com/_/oauthredirect --name=$(hostname) --user-name=user --pin=123456"]
