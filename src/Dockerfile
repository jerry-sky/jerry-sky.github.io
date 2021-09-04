FROM python:3.9-slim-buster

WORKDIR /wrk
ENTRYPOINT /bin/bash


RUN apt-get update
RUN apt-get install -y curl inotify-tools


# install Pandoc and Sass (Dart)
ADD src/install* /tmp/
RUN /tmp/install-pandoc.sh
RUN /tmp/install-sass.sh

# install utility that will refresh the page on every file change
RUN python3 -m pip install httpwatcher
