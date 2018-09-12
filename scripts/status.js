//
// Description:
//   status
//
// Dependencies:
//   None
//
// Commands:
//   is lims up
//   is lims down
//   zed status lims
//
//
module.exports = function (robot) {
  const regex_hear = /(is lims up|is lims down)/i;
  const regex_respond = /status lims/i;

  robot.hear(regex_hear, (msg) => {
    msg.send(`status.zymergen.net`);
  });

  robot.respond(regex_respond, (msg) => {
    msg.send(`status.zymergen.net`);
  });

}