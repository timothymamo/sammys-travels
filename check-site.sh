#!/bin/bash

while true; do
  var=$(date +"%H:%M:%S")
  if [ "$(curl --silent https://sammys-travels.devreltim.io/api/health)" == '{"status":200}' ]; then
    echo "Site is UP - $var"
  else
    echo "Site is DOWN - $var"
  fi
  sleep 5
done
