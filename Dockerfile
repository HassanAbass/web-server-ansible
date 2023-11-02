
# Use the official image as a parent image
FROM ubuntu

# Update the system
RUN apt-get update --fix-missing && apt-get upgrade -y

# Install OpenSSH Server
RUN apt-get install -y openssh-server python3-pip

# Set up configuration for SSH
RUN mkdir /var/run/sshd
RUN echo 'root:pass' | chpasswd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

# SSH login fix. Otherwise, user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Expose the SSH port
EXPOSE 22

# Run SSH
CMD ["/usr/sbin/sshd", "-D"]
