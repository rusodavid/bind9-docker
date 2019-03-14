FROM ubuntu:18.04
LABEL maintainer="rusodavid@gmail.com"

#ARG DEBIAN_FRONTEND=noninteractive

#install && configure bind9 dns
RUN apt-get update && apt-get install -y bind9 bind9utils dnsutils vim

#remove apt lists
RUN rm -rf /var/lib/apt/lists/* 

# Run Chrome as non privileged user
#USER chrome

RUN chown bind:bind /etc/bind/*
# give bind access to the log directory
#RUN mkdir /var/log/bind
#RUN chown bind:bind /var/log/bind/


COPY named.conf.log /etc/bind/named.conf.log
COPY named.conf.local /etc/bind/named.conf.local
COPY db.rev.1.168.192.in-addr.arpa /etc/bind/db.rev.1.168.192.in-addr.arpa
COPY db.rev.2.168.192.in-addr.arpa /etc/bind/db.rev.2.168.192.in-addr.arpa
COPY db.home.lan /etc/bind/db.home.lan
COPY named.conf.options /etc/bind/named.conf.options
COPY named.conf /etc/bind/named.conf
COPY named.conf.blocked /etc/bind/named.conf.blocked
COPY blockeddomain.hosts /etc/namedb/blockeddomain.hosts
COPY named.conf.blocked.custom /etc/bind/named.conf.blocked.custom

COPY tail.sh /tail.sh


EXPOSE 53/udp
CMD service bind9 start | /tail.sh 
#tail -F /var/log/bind/bind.log
#ENTRYPOINT [ "bash" ]
