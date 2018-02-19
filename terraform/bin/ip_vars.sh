#!/bin/bash

if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
  echo "The script ${BASH_SOURCE[0]} is being sourced..."
  echo
else
  echo "You must source this bash script, not run it directly."
  echo
  exit 1
fi

export server_ip=$(terraform output  | grep server | cut -d " " -f 3)
export server_ips=(${server_ip})
echo "\${server_ips[${num}]}: ${server_ips[${num}]}"
