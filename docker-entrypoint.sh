#!/usr/bin/env sh
main() {
  trap shutdown TERM
  start "$@"
}

shutdown() {
  echo "Caught signal"
  echo "Shutdown server (pid=${PID})"

  kill ${PID}
  wait ${PID}
  exit 0
}

start() {
  java -jar JTS3ServerMod.jar -log log/JTS3ServerMod_InstanceManager.log "$@" &
  PID=$!
  echo "Start server (pid=${PID})"
  wait ${PID}
}

PID=""
main "$@"
