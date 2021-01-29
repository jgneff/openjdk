#!/bin/bash
# Prints the path to the environment file

# Checks for required environment variables
: "${SNAP_INSTANCE_NAME:?}"

path=/var/snap/${SNAP_INSTANCE_NAME}/common
printf "%s/openjdk.env\n" "${path}"
