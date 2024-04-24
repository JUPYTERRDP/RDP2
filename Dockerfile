# Use a base image
FROM ubuntu:latest

# Set noninteractive mode and specify the keyboard layout
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
RUN apt-get update && apt-get install -y locales && \
    locale-gen en_US.UTF-8

# Install necessary packages and dependencies
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
    xserver-xorg-video-dummy \
    # Install Chrome Remote Desktop
    && wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb \
    && dpkg -i chrome-remote-desktop_current_amd64.deb \
    && apt-get install -f -y \
    # Create user account "Albin" and grant sudo permissions
    && useradd -ms /bin/bash Albin \
    && echo "Albin:Albin4242" | chpasswd \
    && adduser Albin sudo \
    # Change ownership of home directory to Albin
    && chown -R Albin:Albin /home/Albin \
    # Create necessary directory for Chrome Remote Desktop
    && mkdir -p /home/Albin/.config/chrome-remote-desktop/

# Check connectivity to a website
RUN curl -IsS https://remotedesktop.google.com -o /dev/null \
    && ls -la /home/Albin/.config/chrome-remote-desktop/ \
    && tail -n 100 /var/log/syslog

# Provide authorization code during Docker image build
RUN DISPLAY= /opt/google/chrome-remote-desktop/start-host --code="4/0AeaYSHDXW7s_uExaeFz0Q0hiaToo9zFzW_gp8mYaw1av4Nm9Tv2t4bNFaRXI44ljmCcNAA" --redirect-url="https://remotedesktop.google.com/_/oauthredirect" --user-name="Albin" --pin="123456" --name=$(hostname)

# Expose the RDP port
EXPOSE 3389
