#!/bin/bash

CLIPNOW=$(wl-paste | sha1sum)

niri msg action screenshot

while [ "$(wl-paste | sha1sum)" = "$CLIPNOW" ]; do
  sleep .05
done

wl-paste | satty -f -
