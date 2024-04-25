# Use the official ubuntu base image
FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb && \
    dpkg -i chrome-remote-desktop_current_amd64.deb && \
    apt-get install -f -y && \
    apt-get install -y libxkbcommon0 libxrandr2 libxtst6

# Provide authorization code during Docker image build
RUN DISPLAY= /opt/google/chrome-remote-desktop/start-host \
    --code="4/0AeaYSHA5s_KiN8uK0_6iUcEvRYWxvAg_k05Pw45rKHUckD-a7giygVR_JlrDMkNRCP7g8g" \
    --redirect-url="https://remotedesktop.google.com/_/oauthredirect" \
    --name=$(hostname)

# Expose the RDP port
EXPOSE 3389
