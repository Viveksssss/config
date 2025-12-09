#!/bin/bash

if pgrep -x 'clipse-gui' >/dev/null; then
  pkill -f 'clipse-gui'
else
  clipse-gui
fi
