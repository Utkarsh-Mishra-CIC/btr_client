cmd_create_help() {
    cat <<_EOF
    create
        Create the container '$CONTAINER'.

_EOF
}

rename_function cmd_create orig_cmd_create
cmd_create() {
    local code_dir=$(dirname $(realpath $APP_DIR))
    orig_cmd_create \
        --volume $code_dir:/usr/local/src/btr_client \
        --volume $(pwd)/var-www:/var/www \
        --workdir /var/www \
        --env CODE_DIR=/usr/local/src/btr_client \
        --env DRUPAL_DIR=/var/www/bcl

    rm -f btr_client
    ln -s var-www/bcl/profiles/btr_client .
}
