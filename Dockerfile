# Use a base image
FROM ubuntu:latest

# Set noninteractive mode and specify the keyboard layout
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
RUN apt-get update && apt-get install -y locales && \
    locale-gen en_US.UTF-8

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

# Create a user account "Albin" with password "Albin4242"
RUN useradd -m -s /bin/bash Albin && echo "Albin:Albin4242" | chpasswd

# Download and install Chrome Remote Desktop
RUN wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
RUN dpkg -i chrome-remote-desktop_current_amd64.deb

# Automatically provide the PIN "123456" during setup
RUN echo "123456" | /opt/google/chrome-remote-desktop/start-host --code="4/0AeaYSHCQ_nJEfaUm9BBbZhFVVo2iATdxytRwjJRPbYoGEiYZ18K-mNRnKViHToO3hgSxKg" --redirect-url="https://remotedesktop.google.com/_/oauthredirect" --user-name="Albin" --name=$(hostname)

# Expose port for Chrome Remote Desktop
EXPOSE 3389

# Start Chrome Remote Desktop service
CMD ["sh", "-c", "DISPLAY= /opt/google/chrome-remote-desktop/start-host --code=\"4/0AeaYSHCQ_nJEfaUm9BBbZhFVVo2iATdxytRwjJRPbYoGEiYZ18K-mNRnKViHToO3hgSxKg\" --redirect-url=\"https://remotedesktop.google.com/_/oauthredirect\" --name=$(hostname) --pin=123456"]
