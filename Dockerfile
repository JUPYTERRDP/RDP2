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

# Create the directory for Chrome Remote Desktop config if it does not exist
RUN mkdir -p /home/Albin/.config/chrome-remote-desktop/

# Check connectivity to a website
RUN curl -IsS https://remotedesktop.google.com -o /dev/null && \
    ls -la /home/Albin/.config/chrome-remote-desktop/

# Provide authorization code during Docker image build
RUN DISPLAY= /opt/google/chrome-remote-desktop/start-host --code="4/0AeaYSHA4OsGc4EJ7r7reAYhhlRFpHX6WFjcYY7C3t5cP9B-IYkqK167bRjatq-Ew3YeMwQ" --redirect-url="https://remotedesktop.google.com/_/oauthredirect" --user-name="Albin" --pin="123456" --name=$(hostname)

# Expose the RDP port
EXPOSE 3389

# Set the start command with the specified user name and PIN
CMD ["sh", "-c", "DISPLAY= /opt/google/chrome-remote-desktop/start-host --user-name=\"Albin\" --pin=\"123456\" --name=$(hostname)\""]
