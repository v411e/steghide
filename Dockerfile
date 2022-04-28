FROM debian:bullseye

RUN apt update; apt install steghide -y

VOLUME /data
WORKDIR /data

ENTRYPOINT ["steghide"]

CMD ["--help"]
