#!/usr/bin/env bash

handleERR() {
    echo "$0 Error on line $1"
}
set -e
trap 'handleERR $LINENO' ERR

UMASK_SET=${UMASK_SET:-022}
umask "$UMASK_SET"

APP_DIR="/app/emby"
export LD_LIBRARY_PATH="${APP_DIR}"
export FONTCONFIG_PATH="${APP_DIR}"/etc/fonts

if [ -d "/lib/x86_64-linux-gnu" ]; then
	export LIBVA_DRIVERS_PATH=/usr/lib/x86_64-linux-gnu/dri:"${APP_DIR}"/dri
fi
export SSL_CERT_FILE="${APP_DIR}"/etc/ssl/certs/ca-certificates.crt

exec /app/emby/EmbyServer -programdata /config -ffdetect /app/emby/ffdetect -ffmpeg /app/emby/ffmpeg -ffprobe /app/emby/ffprobe -restartexitcode 3