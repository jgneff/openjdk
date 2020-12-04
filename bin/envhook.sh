#!/bin/bash
# Creates or updates the environment file
{
    printf "# Source this file for OpenJDK environment variables and aliases\n"
    printf "export JAVA_HOME=%s/jvm\n" "$SNAP"
    printf "alias java='openjdk.java'\n"
    printf "alias javac='openjdk.javac'\n"
    printf "alias javadoc='openjdk.javadoc'\n"
    printf "alias jar='openjdk.jar'\n"
    printf "alias jarsigner='openjdk.jarsigner'\n"
    printf "alias jlink='openjdk.jlink'\n"
    printf "alias jpackage='openjdk.jpackage'\n"
} > "$SNAP_COMMON/openjdk.env"
