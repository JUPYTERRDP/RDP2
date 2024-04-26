# Use an official Ubuntu runtime as the base image
FROM ubuntu:latest

# Install necessary dependencies
RUN apt-get update && apt-get install -y wget gnupg

# Download and install Chrome Remote Desktop
RUN wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
RUN dpkg -i chrome-remote-desktop_current_amd64.deb
RUN apt-get install -y -f

# Start Chrome Remote Desktop service
CMD ["DISPLAY= /opt/google/chrome-remote-desktop/start-host --code="4/0AeaYSHDOvGePfKU3L6Anz68NlobJAOdU-9AmnHwikywzH0r97xAA2Smb5dwdBLTG6iEkCQ" --redirect-url="https://remotedesktop.google.com/_/oauthredirect" --name=$(hostname)"]
