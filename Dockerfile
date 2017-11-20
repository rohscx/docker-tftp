FROM ubuntu

MAINTAINER Rohscx <emailaddress.com>
# Update Ubuntu
RUN apt-get update
# Install TFTP Server
RUN apt-get install tftpd-hpa -y
# Create TFTP config file
RUN cp /etc/default/tftpd-hpa /etc/default/tftpd-hpa.ORIGINAL
# Grant edit rights to tftp file and read access to folder
RUN chmod 777 /etc/default/tftpd-hpa
RUN chmod +t /etc/default/
# Grant write access to tftp folder
RUN chown -R tftp /var/lib/tftpboot

# Add TFTP user
RUN adduser --disabled-password --gecos "" tftp_user
# Run Entrypoint script
COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]
RUN chmod 755 /docker-entrypoint.sh
CMD [ "-s" ]
# Set Docker default user and  working directory
USER tftp_user
WORKDIR /home/tftp_user

EXPOSE  69 69/udp
