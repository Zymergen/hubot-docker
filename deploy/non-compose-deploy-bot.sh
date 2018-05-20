#/bin/bash -xv

set -eu

# Set the 3 variables below
export STUDENT_ID="999"
export SLACK_TOKEN="xoxb-slack-token"
export HUB_USER="myuser"

export BIND_ADDRESS="0.0.0.0"
export ENVIRONMENT="development"
export SERVICE_NAME="${STUDENT_ID}_bot"
export SERVICE_ENV="development"
export EXPRESS_USER="${STUDENT_ID}_bot"
export EXPRESS_PASSWORD="${STUDENT_ID}_pw"
export PORT="8080"
export HUBOT_ADAPTER="slack"
export HUBOT_ALIAS="${STUDENT_ID}"
export HUBOT_NAME="${STUDENT_ID}_bot"
export HUBOT_LOG_LEVEL="debug"
export REDIS_URL="redis://127.0.0.1:6379"
export HUBOT_SLACK_TOKEN="${SLACK_TOKEN}"

docker build -t ${HUB_USER}/mybot:latest .
docker push ${HUB_USER}/mybot:latest
docker rm -f ${STUDENT_ID}_bot || true
docker run \
    -e BIND_ADDRESS="${BIND_ADDRESS}" \
    -e ENVIRONMENT="${ENVIRONMENT}" \
    -e SERVICE_NAME="${SERVICE_NAME}" \
    -e SERVICE_ENV="${SERVICE_ENV}" \
    -e EXPRESS_USER="${EXPRESS_USER}" \
    -e EXPRESS_PASSWORD="${EXPRESS_PASSWORD}" \
    -e PORT="${PORT}" \
    -e HUBOT_ADAPTER="${HUBOT_ADAPTER}" \
    -e HUBOT_ALIAS="${HUBOT_ALIAS}" \
    -e HUBOT_NAME="${HUBOT_NAME}" \
    -e HUBOT_LOG_LEVEL="${HUBOT_LOG_LEVEL}"\
    -e REDIS_URL="${REDIS_URL}" \
    -e HUBOT_SLACK_TOKEN="${HUBOT_SLACK_TOKEN}" \
    -d --restart="unless-stopped" --name ${STUDENT_ID}_bot ${HUB_USER}/mybot:latest

