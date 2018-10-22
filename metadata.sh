
#!/bin/bash

# assign variables
ACTION=${1}

function create_files() {
curl -vs http://169.254.169.254/latest/dynamic/instance-identity/document/ 2>&1 | tee backend1-identity.json
curl -vs https://s3.amazonaws.com/seis665/message.json 2>&1 | tee backend1-message.txt
cp /var/log/nginx/access.log .
}

function display_version() {
version=0.5.0
echo $version
}

function display_help() {
cat << EOF
Usage: ${0} {-c|--create|-v|--version|-h|--help} <filename>
OPTIONS:
        -c | --create   Create files
        -v | --version  Display version of file
        -h | --help     Display the command help
Examples:
        Create files:
                $ ${0} -c
        Display  version of the file:
                $ ${0} -v
        Display help:
                $ ${0} -h
EOF
}

case "$ACTION" in
        -c| --create)
                create_files
                ;;
        -v| --version)
                display_version
                ;;
        -h| --help)
                display_help
                ;;
        *)
        echo "Usage ${0} {-c} {-v} {-h}"
        exit 1
esac
