#!/bin/bash
# Prints the path to the environment file
printf "%s/openjdk.env\n" "${SNAP_DATA:?}"
