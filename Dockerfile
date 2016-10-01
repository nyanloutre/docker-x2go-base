FROM ubuntu:16.04
MAINTAINER Paul TREHIOU <paul.trehiou@gmail.com>

# Upgrade packages
RUN apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        software-properties-common \
        openssh-server \
        firefox \
        lxde-core \
        lxterminal && \
    add-apt-repository ppa:x2go/stable && apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y x2goserver && \
    apt-get clean && apt-get autoremove

# SSH runtime
RUN mkdir /var/run/sshd

# Configure default user
RUN adduser --gecos "X2Go User" --disabled-password x2go
RUN echo "x2go:x2go" | chpasswd

# Run it
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
