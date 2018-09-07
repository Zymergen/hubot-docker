//
// Description:
//   Compliment someone
//
// Dependencies:
//   None
//
// Commands:
//   hubot status etl
//
//
const request = require('request-promise-native')

module.exports = function (robot) {
  const regex = /status etl/i;
  const etlUrl = 'https://lims-jobs.zymergen.net/streametl/status';

  robot.respond(regex, (msg) => {
    getEtlStatus()
      .then(consumers => msg.send(constructMsg(consumers)))
      .catch(err => console.log(err));
  });

  constructMsg = (consumers) => {
    let msg = '`Name                                         |State|Current|Max allowed|Status`\n';
    consumers.forEach(consumer => {
      consumer.state = consumer.status === 'OK' ? ':white_check_mark:' : ':x:';
      consumer.status = consumer.status === 'OK' ? ':white_check_mark:' : ':x:';
      msg += `\`${formatTextToLength(consumer.name, 45)}\` | ${consumer.state} | \`${formatTextToLength(consumer.current_lag, 7)}\` | \`${formatTextToLength(consumer.max_allowed_lag, 7)}\` | ${consumer.status}\n`;
    })
    return {
      "text": msg,
      "username": "markdownbot",
      "mrkdwn": true,
      "attachments": [
        {
          "fallback": "More details at https://lims-jobs.zymergen.net/streametl/status",
          "actions": [
            {
              "type": "button",
              "text": "More details",
              "url": "https://lims-jobs.zymergen.net/streametl/status"
            }
          ]
        }
      ]
    };
  }

  formatTextToLength = (text, length) => {
    const space = ' ';
    let toBeAdded = '';
    for (let i = 0; i < length - String(text).length; i++) {
      toBeAdded += space;
    }
    return String(text) + toBeAdded;
  }

  getEtlStatus = () =>
    request(etlUrl, {
      method: 'get',
      json: true
    }).then(res => res.consumers)
}