#!/bin/bash

BASE="${HOME}/docker-workshop"

echo "This will reset all the class data under ${BASE} !!!"
echo
echo "Are you sure this is what you want to do?"
read -p "You must type 'yes' to confirm: " -r
echo
if [[ $REPLY == "yes" ]]; then
  rm -rf ${BASE}/hubot-docker/bot-with-server/mongodb/data/db/*
  rm -rf ${BASE}/hubot-docker/bot-with-server/rocketchat/data/uploads/*
  echo "completed"
else
  echo "aborted"
fi

