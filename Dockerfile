# Use an official Ubuntu runtime as the base image
FROM ubuntu:latest

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    xserver-xorg-video-dummy \
    policykit-1 \
    xbase-clients \
    psmisc \
    python3 \
    python3-packaging \
    python3-psutil \
    python3-xdg \
    libcairo2 \
    libdbus-1-3 \
    libdrm2 \
    libexpat1 \
    libgbm1 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libutempter0 \
    libx11-6 \
    libxcb1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxkbcommon0 \
    xvfb

# Download Chrome Remote Desktop package
RUN wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb

# Install Chrome Remote Desktop package
RUN dpkg -i chrome-remote-desktop_current_amd64.deb

# Install dependencies
RUN apt-get install -y -f

# Set up Chrome Remote Desktop
CMD ["sh", "-c", "DISPLAY= /opt/google/chrome-remote-desktop/start-host --code=\"4/0AeaYSHDOvGePfKU3L6Anz68NlobJAOdU-9AmnHwikywzH0r97xAA2Smb5dwdBLTG6iEkCQ\" --redirect-url=\"https://remotedesktop.google.com/_/oauthredirect\" --name=$(hostname) --user-name=Albin"]
