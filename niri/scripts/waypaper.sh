#!/bin/bash

if pgrep -x 'waypaper' >/dev/null; then
  pkill -f 'waypaper'
else
  waypaper
fi
