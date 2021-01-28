#!/bin/bash
# Creates or updates the environment file

# Checks for required environment variables
: "${SNAP:?}"
: "${SNAP_COMMON:?}"

# Variables for finding the Java launcher
root=/var/lib/snapd
java=/jdk/bin/java
{
    printf "# Source this file for OpenJDK environment variables and aliases\n"
    if [ -x "${root}${SNAP}${java}" ]; then
        printf "export JAVA_HOME=%s/jdk\n" "${root}${SNAP}"
        printf "export MANPATH=%s/jdk/man:\n" "${root}${SNAP}"
    elif [ -x "${SNAP}${java}" ]; then
        printf "export JAVA_HOME=%s/jdk\n" "${SNAP}"
        printf "export MANPATH=%s/jdk/man:\n" "${SNAP}"
    fi
    printf "alias java='openjdk.java'\n"
    printf "alias javac='openjdk.javac'\n"
    printf "alias javadoc='openjdk.javadoc'\n"
    printf "alias jar='openjdk.jar'\n"
    printf "alias jarsigner='openjdk.jarsigner'\n"
    printf "alias jlink='openjdk.jlink'\n"
    printf "alias jpackage='openjdk.jpackage'\n"
} > "${SNAP_COMMON}/openjdk.env"
