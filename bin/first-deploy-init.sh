#!/bin/bash

echo "Initializing Matomo database and users..."

bin/generate-config-ini.sh

php console database:create-tables && \
  php console core:update --yes && \
  php console admin:create-superuser --login $MATOMO_INIT_USER_LOGIN --email $MATOMO_INIT_USER_EMAIL --password $MATOMO_INIT_USER_PASSWORD && \
  php console admin:create-site --name $MATOMO_INIT_SITE_NAME --url $MATOMO_INIT_SITE_URL
