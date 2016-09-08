FROM debian:jessie

MAINTAINER Eldon Koyle <ekoyle@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && \
    apt-get install -q -y apache2 libaprutil1-dbd-pgsql

RUN a2enmod dbd
RUN a2enmod rewrite

EXPOSE 80/tcp
EXPOSE 443/tcp

COPY ./start_apache.sh /usr/local/bin/start_apache.sh

RUN chmod u+x /usr/local/bin/start_apache.sh

#ENTRYPOINT ["/usr/local/bin/start_postgres.py"]
CMD "/usr/local/bin/start_apache.sh"

