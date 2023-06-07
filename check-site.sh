#!/bin/bash

while true; do
  if [ "$(curl --silent https://sammys-travels.devreltim.io/api/health)" == '{"status":200}' ]; then
    echo "Site is UP"
  else
    echo "Site is DOWN"
  fi
  sleep 3
done
