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

# Install Chrome Browser and Chrome Remote Desktop
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && echo "deb [arch=amd64] https://dl.google.com/linux/chrome-remote-desktop/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome-remote-desktop.list \
    && apt-get update && apt-get install -y \
    google-chrome-stable \
    chrome-remote-desktop \
    --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up Chrome Remote Desktop
RUN useradd -m user \
    && echo "user:password" | chpasswd \
    && usermod -aG sudo user \
    && usermod -s /bin/bash user \
    && usermod -aG chrome-remote-desktop user \
    && mkdir -p /home/user/.config/chrome-remote-desktop \
    && touch /home/user/.config/chrome-remote-desktop/host#RANDOMSTRINGHERE \
    && chown -R user:user /home/user \
    && chmod 777 /home/user/.config/chrome-remote-desktop/host#RANDOMSTRINGHERE

# Expose necessary ports for Chrome Remote Desktop
EXPOSE 5900
EXPOSE 22

# Start Chrome Remote Desktop
CMD ["sh", "-c", "DISPLAY= /opt/google/chrome-remote-desktop/start-host --code=4/0AeaYSHA89TfnQRCgm5BRclExSfYJhSGoGe-7dVDZCb0w07onqZuR6znHK0NBZsUOPV6d0A --redirect-url=https://remotedesktop.google.com/_/oauthredirect --name=$(hostname) --user-name=user --pin=123456"]
