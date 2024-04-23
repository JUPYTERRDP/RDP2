# Use an official Ubuntu as a base image
FROM ubuntu:latest

# Set default value for USER_ID argument
ARG USER_ID=1000

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

# Add user to the docker group and set password
RUN useradd -m -s /bin/bash --uid $USER_ID user \
    && usermod -aG sudo,docker user \
    && echo "user:password" | chpasswd

# Set up Chrome Remote Desktop
RUN mkdir -p /home/user/.config/chrome-remote-desktop \
    && touch /home/user/.config/chrome-remote-desktop/host#bd7733f68c64930bfe11c86a71286e1a.json \
    && chown -R user:user /home/user \
    && chmod -R 777 /home/user/.config/chrome-remote-desktop/

# Set the working directory
WORKDIR /home/user

# Expose any ports your app needs
EXPOSE 22
EXPOSE 5900

# Debugging: Print hostname and content of /etc/hosts for troubleshooting
RUN hostname && cat /etc/hosts

# Start Chrome Remote Desktop
CMD ["sh", "-c", "DISPLAY= /opt/google/chrome-remote-desktop/start-host --code=4/0AeaYSHCwv_MT8geuCsro52oCxfVHWKUt1YMRf2EAFSe_txw-c4kMz8aEqj7WSZ9aeZgDZA --redirect-url=https://remotedesktop.google.com/_/oauthredirect --name=$(hostname) --user-name=user --pin=123456"]
