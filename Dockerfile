FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install SSH server
RUN apt update && \
    apt install -y openssh-server && \
    mkdir /var/run/sshd

# Create non-root user
RUN useradd -m -s /bin/bash dockeruser

# Prepare SSH directory
RUN mkdir -p /home/dockeruser/.ssh && \
    chmod 700 /home/dockeruser/.ssh && \
    chown -R dockeruser:dockeruser /home/dockeruser/.ssh

# Copy public key into container
COPY docker_linux.pub /tmp/docker_linux.pub

# Install public key
RUN cat /tmp/docker_linux.pub >> /home/dockeruser/.ssh/authorized_keys && \
    chmod 600 /home/dockeruser/.ssh/authorized_keys && \
    chown dockeruser:dockeruser /home/dockeruser/.ssh/authorized_keys && \
    rm /tmp/docker_linux.pub

# SSH hardening
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config


EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
