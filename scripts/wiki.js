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
  const regex_search = /(wiki search)(.*)/i;
  const regex_rules = /(wiki list)/i;
  const regex_all = /wiki$/i;

  robot.respond(regex_search, (msg) => {
    let [dummy, command, search, reason] = msg.match;
    msg.send(`<https://wiki.zymergen.net/dosearchsite.action?queryString=${encodeURI(search.trim())}|Wiki search result of "${search.trim()}">`);
  });

  robot.respond(regex_all, (msg) => {
    msg.send(`<https://wiki.zymergen.net/display/DEV/Coding+and+Shipping+at+Zymergen|Coding and Shipping at Zymergen>
<https://wiki.zymergen.net/pages/viewpage.action?pageId=3902193|Organization & Culture>
<https://wiki.zymergen.net/display/DEV/How-to+articles|How-to articles>
<https://wiki.zymergen.net/display/DEV/LIMS+Releases|LIMS Releases>
<https://wiki.zymergen.net/display/DEV/Meeting+notes|Meeting nots>
<https://wiki.zymergen.net/display/DEV/Office+Hour+Notes|Office Hour Notes>`
    );
  });

}