# Define base image
FROM python:3.7-alpine

# It does not allow python to buffer
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN mkdir /app
# Defining working directory on docker environment
WORKDIR /app
COPY ./app /app

# Adding user who will run the processes
RUN adduser -D user
USER user
