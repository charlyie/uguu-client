#!/bin/bash
# UGUU client (Shell client)
#
# A CLI for Uguu file sharing
#
# The MIT License (MIT)
# Copyright (c) 2020 Charles Bourgeaux <charles@resmush.it> and contributors
# You are not obligated to bundle the LICENSE file with your projects as long
# as you leave these references intact in the header comments of your source files.

# Editable variables
ENDPOINT="https://uguu.se"
APPNAME="Uguu"
# End of editable variables

APP_VERSION="1.1.0"
OVERRIDE_CONF_FILE="/etc/ushare.conf"
GREEN="\033[0;32m"
WHITE="\033[1;37m"
NC="\033[0m" # No Color
REQUIRED_PACKAGES=( "curl" "jq" )

#Load Configuration file if provided
if [ -f "$OVERRIDE_CONF_FILE" ]; then
    source "$OVERRIDE_CONF_FILE"
fi

# Output printing function
cli_output(){
	if [[ $2 == "nohead" ]]; 
	then 
		printf "${1}\n"
	else
		printf "${WHITE}[${GREEN}${APPNAME}${WHITE}] %s${NC}\n" "$1"
	fi
}

# Display Current Configuration
get_configuration(){
    #Load Configuration file if provided
    if [ ! -f "$OVERRIDE_CONF_FILE" ]; then
        OVERRIDE_CONF_FILE="None"
    fi
    cli_output "Configuration loaded:" nohead
    cli_output "> App Name :\t\t ${APPNAME}" nohead
    cli_output "> Version :\t\t ${APP_VERSION}" nohead
    cli_output "> Configuration File :\t ${OVERRIDE_CONF_FILE}" nohead
    cli_output "> Endpoint :\t\t ${ENDPOINT}" nohead
}

# Set a Configuration
set_configuration(){
    cat >$OVERRIDE_CONF_FILE <<EOL
ENDPOINT="$ENDPOINT"
APPNAME="$APPNAME"
EOL
    cli_output "Configuration saved in ${OVERRIDE_CONF_FILE}"
}


# Manage arguments
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    cli_output "UGUU client v.${APP_VERSION}, a Command Line Interface for UGUU compatible API" nohead
	cli_output "(c) Charles Bourgeaux <charles@resmush.it>\n" nohead
	cli_output "Usage: ushare <filename>"  nohead
	cli_output "Startup:" nohead
    cli_output "  -e <endpoint> or --endpoint <endpoint> \t\t set a new endpoint." nohead
    cli_output "  -h or --help \t\t\t\t\t print this help." nohead
	cli_output "  -i or --info \t\t display configuration informations." nohead
    cli_output "  -v or --version \t\t\t\t display the version of this client." nohead
    shift # past argument
	exit 0
    ;;
    -v|--version)
    cli_output "UGUU client v.${APP_VERSION}" nohead
    shift # past argument
    exit 0
    ;;
    -i|--info)
    get_configuration
    shift # past argument
    exit 0
    ;;
    -e|--endpoint)
    ENDPOINT="$2"
    set_configuration
    shift # past argument
    shift # past argument
    exit 0
    ;;
    -*)    # unknown option
    cli_output "Invalid option: ${1}. Type --help to show help" nohead
    shift
    exit 0
    ;;
    --*)    # unknown option
    cli_output "Invalid option: ${1}. Type --help to show help" nohead
    shift 
    exit 0
    ;;
    *)    # unknown option
    FILE=$1 # save it in an array for later
    shift # past argument
    ;;
esac
done

# Package requirements check
for x in "${REQUIRED_PACKAGES[@]}"
do
if ! which "$x" > /dev/null; 
then
  cli_output "The command $x was not found on your system. Try to install it before running this app!"
  exit 0
fi
done

# File argument available ?
if [ -z "$FILE" ]; then
    cli_output "Missing file provided. Usage : ushare path/to/file"
    exit 1
fi

# File provided available ?
FILENAME=$(basename -- "$FILE")
if [ ! -f "$FILE" ]; then
    cli_output "File ${FILE} was not found!"
    exit 1
fi

# Call the API
FILESIZE=$(du -h "${FILE}" | awk '{print $1}')
cli_output "Starting transferring file ${FILENAME} (${FILESIZE})..."

RESPONSE=$(curl -# -F "files[]=@${FILE}" "${ENDPOINT}/upload.php")
RETURN=$(echo "$RESPONSE" | jq '.success')

if [ "true" != "$RETURN" ]; then
	RESPONSE=$(echo "$RESPONSE" | jq '.description' -r)
	cli_output "An error has occured : ${RESPONSE}."
    exit 1
fi

URL=$(echo "$RESPONSE" | jq '.files' | jq '.[0].url' -r)
cli_output "Link to share : ${URL}"