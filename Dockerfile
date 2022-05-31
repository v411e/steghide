FROM debian:bullseye

RUN apt update; apt install steghide -y

VOLUME /data
WORKDIR /data

COPY hide.sh /hide.sh

ENTRYPOINT ["/hide.sh"]
