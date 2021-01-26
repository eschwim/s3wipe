FROM python:3

WORKDIR /opt/s3wipe

COPY . ./
RUN pip install --no-cache-dir -r requirements.txt
RUN chmod 755 s3wipe

ENTRYPOINT ["./s3wipe"]
