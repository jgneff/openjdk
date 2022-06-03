#!/bin/bash
# Creates the environment file on installation and updates

# Checks for required environment variables
: "${SNAP:?}"
: "${SNAP_INSTANCE_NAME:?}"
: "${SNAP_DATA:?}"

{
    printf "# Source this file for OpenJDK environment variables and aliases\n"
    printf "export JAVA_HOME=%s/jdk\n" "$SNAP"
    printf "export MANPATH=%s/jdk/man:\n" "$SNAP"
    printf "alias java='%s.java'\n" "$SNAP_INSTANCE_NAME"
    printf "alias javac='%s.javac'\n" "$SNAP_INSTANCE_NAME"
    printf "alias javadoc='%s.javadoc'\n" "$SNAP_INSTANCE_NAME"
    printf "alias jar='%s.jar'\n" "$SNAP_INSTANCE_NAME"
    printf "alias jarsigner='%s.jarsigner'\n" "$SNAP_INSTANCE_NAME"
    printf "alias jlink='%s.jlink'\n" "$SNAP_INSTANCE_NAME"
    printf "alias jpackage='%s.jpackage'\n" "$SNAP_INSTANCE_NAME"
    printf "alias jwebserver='%s.jwebserver'\n" "$SNAP_INSTANCE_NAME"
} > "$SNAP_DATA/openjdk.env"
