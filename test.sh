#!/bin/bash

echo "List installed packages..."
docker run --rm --entrypoint="" "${1}" apt list --installed
echo "Check if app works..."
app_url="http://localhost:8989/system/status"
docker run --rm --network host -d --name service "${1}"
currenttime=$(date +%s); maxtime=$((currenttime+60)); while (! curl -fsSL "${app_url}" > /dev/null) && [[ "$currenttime" -lt "$maxtime" ]]; do sleep 1; currenttime=$(date +%s); done
curl -fsSL "${app_url}" > /dev/null
status=$?
echo "Show docker logs..."
docker logs service
exit ${status}