#!/bin/sh

ScullLoad=/usr/bin/scull_load
ScullUnload=/usr/bin/scull_unload
ModuleLoad=/usr/bin/module_load
ModuleUnload=/usr/bin/module_unload
AesdcharLoad=/usr/bin/aesdchar_load
AesdcharUnload=/usr/bin/aesdchar_unload

if [ "$1" = "start" ]; then
    cd /etc/init.d/ || exit 1
    if [ -x "$ScullLoad" ]; then
        "$ScullLoad"
    fi
    if [ -x "$ModuleLoad" ]; then
        "$ModuleLoad" faulty
    fi
    if [ -x "$AesdcharLoad" ]; then
        "$AesdcharLoad" 
    fi
    if ! lsmod | grep -q "hello"; then
        modprobe hello
    fi

elif [ "$1" = "stop" ]; then
    if lsmod | grep -q "hello"; then
        rmmod hello
    fi
    if [ -x "$ScullUnload" ]; then
        "$ScullUnload"
    fi
    if [ -x "$AesdcharUnload" ]; then
        "$AesdcharUnload"
    fi
    if [ -x "$ModuleUnload" ]; then
        "$ModuleUnload" faulty
    fi

else
    echo "Usage: $0 {start|stop}"
    exit 1
fi

exit 0

