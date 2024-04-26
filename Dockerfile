# Use an official Ubuntu runtime as the base image
FROM ubuntu:latest

# Install necessary dependencies
RUN apt-get update && apt-get install -y wget gnupg

# Download and install Chrome Remote Desktop
RUN wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
RUN dpkg -i chrome-remote-desktop_current_amd64.deb
RUN apt-get install -y -f

# Start Chrome Remote Desktop service
CMD ["/opt/google/chrome-remote-desktop/start-host", "--code=YOUR_VERIFICATION_CODE", "--redirect-url=https://remotedesktop.google.com/_/oauthredirect", "--name=YOUR_HOST_NAME"]
