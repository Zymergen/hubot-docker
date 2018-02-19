#!/usr/bin/env powershell

$BASE = "$HOME\docker-class-201"

Write-Host "This will reset all the class data under $BASE !!!"
Write-Host ""
Write-Host "Are you sure this is what you want to do?"

$confirmation = Read-Host "You must type 'yes' to confirm: "
if ($confirmation -eq 'yes') {
  rm "$BASE/hubot-docker/bot-with-server/mongodb/data/db/*" -r -fo
  rm "$BASE/hubot-docker/bot-with-server/rocketchat/data/uploads/*" -r -fo
  cp "$BASE/hubot-docker/.git_keep" "$BASE/hubot-docker/bot-with-server/mongodb/data/db/.git_keep"
  Write-Host "completed"
} else {
  Write-Host "aborted"
}

