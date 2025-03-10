#!/bin/sh

ScullLoad=/usr/bin/scull_load
ScullUnload=/usr/bin/scull_unload
ModuleLoad=/usr/bin/module_load
ModuleUnload=/usr/bin/module_unload

case "$1" in
  start) 
  cd /etc/init.d/ || exit 1
    [ -x "$ScullLoad" ] && "$ScullLoad"
    [ -x "$ModuleLoad" ] && "$ModuleLoad" faulty
    lsmod | grep -q "hello" || modprobe hello
    ;;
  stop)
    lsmod | grep -q "hello" && rmmod hello
    [ -x "$ScullUnload" ] && "$ScullUnload"
    [ -x "$ModuleUnload" ] && "$ModuleUnload" faulty
    ;;
  *)
    echo "Usage: $0 {start|stop}"
    exit 1
    ;;
esac

exit 0
