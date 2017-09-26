FROM debian:stretch

WORKDIR /opt/s3wipe

RUN apt-get -y update
RUN apt-get -y install python-boto

COPY . ./
RUN chmod 755 s3wipe

ENTRYPOINT ["./s3wipe"]
