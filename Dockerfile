# -----------------------------------------------------------------------------

FROM   alpine

ENV    PORT=30022

COPY ./docker-entrypoint.sh /


# Download and install everything from the repos.
RUN    apk add --update openssh && \
       mkdir /var/run/sshd && \
       /usr/bin/ssh-keygen -A

VOLUME ["/saves"]

# Set root password
RUN    PASSWORD=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 15 | head -n 1` && \
       echo "root:$PASSWORD" >> /root/passwdfile && \
       echo "************************************" && \
       echo "The user password is $PASSWORD" && \
       echo "************************************" && \
       addgroup -S sshuser && \
       adduser -S -D -H -s /bin/ash -h /saves -G sshuser -g sshuser sshuser && \
       echo "sshuser:$PASSWORD" >> /root/passwdfile

RUN    echo "Welcome to Alpine Linux!" > /etc/motd
# Apply root password
RUN    chpasswd -c SHA512 < /root/passwdfile && \
       rm /root/passwdfile


# Port 22 is used for ssh
EXPOSE 30022

# Fix all permissions
RUN     chmod +x /docker-entrypoint.sh

# Starting sshd
ENTRYPOINT ["/docker-entrypoint.sh"]
