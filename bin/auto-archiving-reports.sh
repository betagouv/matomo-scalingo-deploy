#!/bin/bash

if [[ -z "$MATOMO_AUTO_ARCHIVING_FREQUENCY" ]]; then
  echo "Auto-archiving reports job disabled"
else
  bin/fetch-purchased-plugins.sh
  bin/generate-config-ini.sh
  bin/set-license-key.sh
  bin/activate-plugins.sh

  echo "Start auto-archiving reports CRON job"
  while true; do
    echo "Archiving reports... "
    php console core:archive --url "https://$MATOMO_HOST"
    echo "done"
    sleep "$MATOMO_AUTO_ARCHIVING_FREQUENCY"
  done
fi
