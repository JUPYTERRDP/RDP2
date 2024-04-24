# Use a base image
FROM ubuntu:latest

# Set noninteractive mode and specify the keyboard layout
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
RUN apt-get update && apt-get install -y locales && \
    locale-gen en_US.UTF-8

# Update package lists
RUN apt-get update

# Install Chrome Remote Desktop dependencies
RUN apt-get install -y \
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

# Download Chrome Remote Desktop package and install
RUN wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb && \
    dpkg -i chrome-remote-desktop_current_amd64.deb && \
    apt-get install -f -y

# Cleanup downloaded package
RUN rm chrome-remote-desktop_current_amd64.deb

# Create user account "Albin" with password "Albin4242"
RUN useradd -ms /bin/bash Albin && \
    echo "Albin:Albin4242" | chpasswd && \
    adduser Albin sudo

# Set permissions for the user's home directory
RUN chown -R Albin:Albin /home/Albin

# Set the start command with the specified user name and PIN
CMD ["sh", "-c", "DISPLAY= /opt/google/chrome-remote-desktop/start-host --code=\"4/0AeaYSHCQ_nJEfaUm9BBbZhFVVo2iATdxytRwjJRPbYoGEiYZ18K-mNRnKViHToO3hgSxKg\" --redirect-url=\"https://remotedesktop.google.com/_/oauthredirect\" --user-name=\"Albin\" --pin=\"123456\" --name=$(hostname)"]
