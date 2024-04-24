# Use a base image
FROM ubuntu:latest

# Install Chrome Remote Desktop dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gdebi \
    xvfb \
    xbase-clients \
    curl \
    sudo \
    apt-transport-https \
    dbus-x11 \
    xfonts-100dpi \
    xfonts-75dpi \
    xfonts-scalable \
    xfonts-cyrillic \
    software-properties-common \
    psmisc \
    python3-packaging \
    python3-psutil \
    python3-xdg \
    libutempter0 \
    xserver-xorg-video-dummy

# Download and install Chrome Remote Desktop
RUN wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
RUN dpkg -i chrome-remote-desktop_current_amd64.deb

# Expose port for Chrome Remote Desktop
EXPOSE 3389

# Start Chrome Remote Desktop service
CMD ["sh", "-c", "DISPLAY= /opt/google/chrome-remote-desktop/start-host --code=\"4/0AeaYSHAToiyjWeMre1Fi1EVpAO8PMkADzKwPHLnybrv4VC8tnnKGlcp3P4OcUQPoEmZweQ\" --redirect-url=\"https://remotedesktop.google.com/_/oauthredirect\" --name=$(hostname)"]
