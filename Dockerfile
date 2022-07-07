FROM ubuntu:18.04

RUN apt-get update -y
RUN apt-get install -y python3-pip

COPY . /

WORKDIR /

RUN pip3 install Flask

ENTRYPOINT [ "python3" ]

CMD [ "easy_flask.py" ]
