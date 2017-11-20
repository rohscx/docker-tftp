FROM ubuntu

MAINTAINER Rohscx <emailaddress.com>

RUN apt-get update

RUN apt-get install tftpd-hpa -y

RUN cp /etc/default/tftpd-hpa /etc/default/tftpd-hpa.ORIGINAL

RUN chmod 777 /etc/default/tftpd-hpa

RUN chown -R tftp /var/lib/tftpboot

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]

RUN chmod 755 /docker-entrypoint.sh

CMD [ "-s" ]

EXPOSE  69 69/udp
