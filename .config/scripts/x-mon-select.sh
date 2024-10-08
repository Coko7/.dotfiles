#!/usr/bin/env bash
# This script is called in ~/.config/X11/.xinitrc

if [ -n "$1" ]; then
    opts="-f $1"
fi

configs="curry,curry-cinema,nomad,geo,geo-cinema"
pick=`echo $configs | tr ',' '\n' | fzf $opts | head -n 1`

case $pick in
  curry)
      export X_MY_LOC="curry"
    ;;
  curry-cinema)
      export X_MY_LOC="curry-cinema"
    ;;
  geo)
      export X_MY_LOC="geo"
    ;;
  geo-cinema)
      export X_MY_LOC="geo-cinema"
    ;;
  nomad)
      export X_MY_LOC="nomad"
    ;;
  *)
    >&2 echo "x-mon-select: unknown option '$pick'"
    exit 1
    ;;
esac

startx
