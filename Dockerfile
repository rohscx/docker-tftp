FROM ubuntu

MAINTAINER Rohscx <emailaddress.com>
# Update Ubuntu
RUN apt-get update
# Install TFTP Server
RUN apt-get install tftpd-hpa -y
# Create TFTP config file
RUN cp /etc/default/tftpd-hpa /etc/default/tftpd-hpa.ORIGINAL

# Add TFTP user
RUN adduser --disabled-password --gecos "" tftp_user

# Grant write access to tftp folder
RUN chown -R tftp /var/lib/tftpboot

# Grant edit rights to tftp file and read access to folder
RUN chmod 777 /etc/default/tftpd-hpa
RUN chmod 777 /etc/default

#
RUN sed -i "s/--secure/--secure --create/" /etc/default/tftpd-hpa

# restart tftpd-hpa service
RUN echo "sleep 2" > /ect/rc.local
RUN echo "service tftpd-hpa restart" > /ect/rc.local

#
#RUN echo "tftp_user ALL = NOPASSWD: /etc/init.d/tftpd-hpa" >> /etc/sudoers
# Run Entrypoint script
COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT [ "/docker-entrypoint.sh" ]
RUN chmod 755 /docker-entrypoint.sh
CMD [ "-s" ]
# Set Docker default user and  working directory
USER tftp_user
WORKDIR /home/tftp_user

EXPOSE  69 69/udp
