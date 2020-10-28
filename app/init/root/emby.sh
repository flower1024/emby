#!/usr/bin/env bash

handleERR() {
    echo "$0 Error on line $1"
}
set -e
trap 'handleERR $LINENO' ERR

chown emby:emby /config /transcode /tmp
