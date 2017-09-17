FROM node:6.11.3

RUN mkdir -p /data/app/bin && mkdir -p /data/app/scripts

RUN apt-get -y update

ADD ./bin /data/app/bin
ADD ./scripts /data/app/scripts
ADD ./*.json /data/app/

RUN cd /data/app && npm install

WORKDIR /data/app
CMD ["/data/app/bin/hubot-env"]

