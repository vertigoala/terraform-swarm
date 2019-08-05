#!/bin/bash
#
# SERVERNAME must point to a manager instance
#
# if SERVERNAME is empty tries to parse it with jq
if [ -z "$SERVERNAME" ]; then
    SERVERNAME=$(python3 terraform.py --debug --list | jq '.managers.hosts | .[] ')
    export SERVERNAME="${SERVERNAME//\"}"
fi
#export DOCKER_HOST=tcp://$SERVERNAME:2375
export DOCKER_HOST=ssh://ubuntu@$SERVERNAME
