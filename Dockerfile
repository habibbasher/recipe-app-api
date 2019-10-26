# Define base image
FROM python:3.7.4-alpine

# It does not allow python to buffer
ENV PYTHONUNBUFFERED 1

# Copy requirements file
COPY ./requirements.txt /requirements.txt

# Postgres db specific commands
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev

# Install requirements from requirements file
RUN pip install -r /requirements.txt

# Remove unnecessary files generated from postgres specific commands
RUN apk del .tmp-build-deps

RUN mkdir /app
# Defining working directory on docker environment
WORKDIR /app
COPY ./app /app

# Adding user who will run the processes
RUN adduser -D user
USER user
