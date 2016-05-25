FROM debian:jessie

MAINTAINER Platzhalter <platzhalter@sigaint.org>

RUN apt-get update
RUN apt-get install -y tor
RUN mkdir /tor
RUN cp /etc/tor/torrc /tor

VOLUME [ "/tor" ]

EXPOSE 9050

ENTRYPOINT [ "tor" ]
CMD [ "-f", "/tor/torrc" ]
