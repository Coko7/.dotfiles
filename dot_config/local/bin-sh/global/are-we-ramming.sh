#!/usr/bin/env bash

# Threshold in MB (25 GB = 25600 MB)
THRESHOLD=$((27 * 1024 * 1024))

while true; do
  USED_MEMORY=$(free -m | awk 'NR==2{print $3}')

  # Check if used memory exceeds threshold
  if [ "$USED_MEMORY" -gt $THRESHOLD ]; then
    notify-send -u critical "System" \
      "HEY, your RAM usage is ${USED_MEMORY}MB right now. Its over 9000 buddy, you gotta wake up.\n
The RAM? THE RAM?? WHERE IS THE RAAAAAAMMMMMMM GOING?????!!!!\n
KILL THE PROCESSES\n
KILL THEM ALL\n
WE NEED TO KEEP THE OS ALIVE AT ALL COST!!!!!!!!\n
COME OOOOOOOOOOOOOOOOOOOOONNNNNNNNNNNNNNNNNNN!!!!!!!!!!!!!!!!!!!" \
      -i "$HOME/Pictures/Memes/veiny-dude.jpg" \
      -h string:x-canonical-private-synchronous:bat-alert
  fi

  sleep 2
done
