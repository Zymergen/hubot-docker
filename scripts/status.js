//
// Description:
//   wiki
//
// Dependencies:
//   None
//
// Commands:
//   wiki
//   wiki search <thing>
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