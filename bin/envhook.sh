#!/bin/bash
# Creates or updates the environment file

# Checks for required environment variables
: "${SNAP_INSTANCE_NAME:?}"
: "${SNAP_REVISION:?}"
: "${SNAP_COMMON:?}"

# Snaps are under '/var/lib/snapd/snap' on Fedora, '/snap' on Debian.
root=/var/lib/snapd
snap=/snap/${SNAP_INSTANCE_NAME}/${SNAP_REVISION}
java=/jdk/bin/java
name=${SNAP_INSTANCE_NAME}

{
    printf "# Source this file for OpenJDK environment variables and aliases\n"
    if [ -x "${root}${snap}${java}" ]; then
        printf "export JAVA_HOME=%s/jdk\n" "${root}${snap}"
        printf "export MANPATH=%s/jdk/man:\n" "${root}${snap}"
    elif [ -x "${snap}${java}" ]; then
        printf "export JAVA_HOME=%s/jdk\n" "${snap}"
        printf "export MANPATH=%s/jdk/man:\n" "${snap}"
    fi
    printf "alias java='%s.java'\n" "${name}"
    printf "alias javac='%s.javac'\n" "${name}"
    printf "alias javadoc='%s.javadoc'\n" "${name}"
    printf "alias jar='%s.jar'\n" "${name}"
    printf "alias jarsigner='%s.jarsigner'\n" "${name}"
    printf "alias jlink='%s.jlink'\n" "${name}"
    printf "alias jpackage='%s.jpackage'\n" "${name}"
    printf "alias jwebserver='%s.jwebserver'\n" "${name}"
} > "${SNAP_COMMON}/openjdk.env"
