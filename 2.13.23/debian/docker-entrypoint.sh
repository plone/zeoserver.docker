#!/bin/bash
set -e

COMMANDS="help logtail show stop fg kill quit wait foreground logreopen reload shell status"
START="start restart"

if [[ $START == *"$1"* ]]; then
  _stop() {
    bin/zeoserver stop
    kill -TERM $child 2>/dev/null
  }

  trap _stop SIGTERM SIGINT
  bin/zeoserver start
  bin/zeoserver logtail &

  child=$!
  wait "$child"
else
  if [[ $COMMANDS == *"$1"* ]]; then
    exec bin/instance "$@"
  fi
  exec "$@"
fi
