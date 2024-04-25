# Use the official Chrome Remote Desktop Docker image
FROM debian:bullseye-slim

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Download and install Chrome Remote Desktop
RUN wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb \
    && dpkg -i chrome-remote-desktop_current_amd64.deb \
    && apt-get install -f -y

# Add a new user 'Albin' and grant sudo privileges
RUN useradd -ms /bin/bash Albin \
    && echo "Albin:Albin4242" | chpasswd \
    && adduser Albin sudo

# Set ownership and permissions
RUN chown -R Albin:Albin /home/Albin \
    && mkdir -p /home/Albin/.config/chrome-remote-desktop/

# Provide authorization code during Docker image build
RUN DISPLAY= /opt/google/chrome-remote-desktop/start-host --code="4/0AeaYSHA5s_KiN8uK0_6iUcEvRYWxvAg_k05Pw45rKHUckD-a7giygVR_JlrDMkNRCP7g8g" --redirect-url="https://remotedesktop.google.com/_/oauthredirect" --user-name="Albin" --pin="123456" --name=$(hostname)
