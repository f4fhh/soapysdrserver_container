#!/bin/bash
set -euo pipefail

_term() {
  echo "Caught signal!" 
  kill -TERM "$child" 2>/dev/null
}
    
trap _term SIGTERM SIGINT

# Start system bus and avahi before the server
mkdir -p /run/dbus
dbus-daemon --system --fork
avahi-daemon --daemonize --no-chroot

# Si aucun argument n'est passé ($# -eq 0), on définit --bind=0.0.0.0 par défaut
if [ $# -eq 0 ]; then
  set -- --bind=0.0.0.0
fi

SoapySDRServer "$@" &

child=$! 
wait "$child"