#!/bin/bash -x

source /host/settings.sh

alias=${1:-@local_bcl}
skip_ssl=1
drush --yes $alias php-script $CODE_DIR/ds/cfg/set-oauth2-login.php  \
    "$OAUTH2_SERVER_URL" "$OAUTH2_CLIENT_ID" "$OAUTH2_CLIENT_SECRET" "$skip_ssl"
drush --yes $alias cc all
