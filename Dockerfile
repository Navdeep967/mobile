FROM ubuntu:22.04

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    PORT=8080

RUN apt-get update && \
    apt-get install -y curl openssh-server sudo && \
    curl -fsSL https://code-server.dev/install.sh | sh && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd -m coder && echo 'coder:coder' | chpasswd && adduser coder sudo

RUN mkdir /var/run/sshd && \
    sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config && \
    echo "PermitRootLogin no" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

RUN ssh-keygen -A

EXPOSE 8080 2222

COPY run_combined.sh /run_combined.sh
RUN chmod +x /run_combined.sh

WORKDIR /home/coder

CMD ["/bin/bash", "/run_combined.sh"]
