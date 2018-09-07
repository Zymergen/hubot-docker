# ------------------------------------------------------
#                       Dockerfile
# ------------------------------------------------------
# image:    hubot
# name:     zymergen/hubot
# repo:     https://github.com/mind-doc/hubot
# Requires: node:alpine
# authors:  development@minddoc.com
# ------------------------------------------------------

FROM node:8.11.4-alpine
LABEL maintainer="glonkarzymergen.com"

RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base \
  && pip install virtualenv 


# Install hubot 3.x dependencies
RUN apk update && apk upgrade \
  && apk add redis jq \
  && npm install -g yo generator-hubot@next \
  && rm -rf /var/cache/apk/*

# Create hubot user with privileges
RUN addgroup -g 501 hubot \
  && adduser -D -h /minddocbot -u 501 -G hubot hubot
ENV HOME /minddocbot
WORKDIR /minddocbot
RUN chown -R hubot:hubot .
USER hubot

# Install hubot
ENV HUBOT_NAME zed
ENV HUBOT_OWNER="Zymergen <software@zymergen.com>"
ENV HUBOT_DESCRIPTION="A robot may not harm humanity, or, by inaction, allow humanity to come to harm"
ENV HUBOT_SLACK_TOKEN="$SLACK_TOKEN"
RUN yo hubot --adapter=slack --owner="$HUBOT_OWNER" --name="$HUBOT_NAME" --description="$HUBOT_DESCRIPTION" --defaults
# Set up extra external scripts (what we consider "essentials")

ADD ./scripts ./scripts

ADD package.json ./
RUN npm install

COPY external-scripts.json ./
RUN npm install --save $(jq -c -r '.[]' external-scripts.json | tr '\n' ' ')

EXPOSE 80

# Set up mandatory environment variables defaults
ENTRYPOINT ["/bin/sh", "-c", "bin/hubot --name $HUBOT_NAME --adapter slack"]

