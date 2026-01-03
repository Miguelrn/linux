FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install SSH and basic tools
RUN apt update && \
    apt install -y openssh-server sudo && \
    mkdir /var/run/sshd

# Create a user
RUN useradd -m -s /bin/bash dockeruser && \
    echo "dockeruser:password" | chpasswd && \
    usermod -aG sudo dockeruser

# Allow SSH login
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
