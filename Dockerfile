# Use an official Ubuntu as a base image
FROM ubuntu:latest

# Install Chrome Remote Desktop dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    ca-certificates \
    apt-transport-https \
    desktop-file-utils \
    xdg-utils \
    dbus-x11 \
    --no-install-recommends

# Install Chrome Remote Desktop
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update && apt-get install -y \
    google-chrome-stable \
    --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Expose necessary ports for Chrome Remote Desktop
EXPOSE 5900
EXPOSE 22

# Start Chrome Remote Desktop
CMD ["sh", "-c", "DISPLAY= /opt/google/chrome-remote-desktop/start-host --code='4/0AeaYSHCQcU7E_0IJQmJe_3btm1pf4vDJ526cObruWLYnzhyMdvMoyUbE9pxhBcJT1a47gQ' --redirect-url='https://remotedesktop.google.com/_/oauthredirect' --name=$(hostname)"]
