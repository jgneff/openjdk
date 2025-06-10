![OpenJDK: Current JDK release and early-access builds](images/banner.svg)

OpenJDK is the official reference implementation of the Java Platform, Standard Edition. This project builds [Snap packages](https://snapcraft.io/openjdk) of OpenJDK directly from its [source repositories](https://github.com/openjdk) on GitHub. These packages provide everything you need to develop a Java application on Linux, including all of the latest development tools, class libraries, API documentation, and source code of the Java Development Kit (JDK).

## Quick Setup

Below are some quick setup instructions for developers who are familiar with the Linux command line. For complete instructions, see the [Usage](#usage) section later.

### Confined Usage

Run the JDK tools from your Linux distribution:

```console
$ java --version
openjdk 21.0.7 2025-04-15
OpenJDK Runtime Environment (build 21.0.7+6-Ubuntu-0ubuntu124.04)
OpenJDK 64-Bit Server VM (build 21.0.7+6-Ubuntu-0ubuntu124.04, mixed mode, sharing)
```

Run the JDK tools from this Snap package in a stricty-confined environment:

```console
$ openjdk.java --version
openjdk 24.0.1 2025-04-15
OpenJDK Runtime Environment (build 24.0.1+9-snap)
OpenJDK 64-Bit Server VM (build 24.0.1+9-snap, mixed mode, sharing)
```

Set up the aliases and environment variables for the JDK tools from this Snap package:

```console
$ source $(openjdk)
$ java --version
openjdk 24.0.1 2025-04-15
OpenJDK Runtime Environment (build 24.0.1+9-snap)
OpenJDK 64-Bit Server VM (build 24.0.1+9-snap, mixed mode, sharing)
```

### Unconfined Usage

Switch between the JDK tools from your Linux distribution and the JDK tools from this Snap package by setting the `JAVA_HOME` and `PATH` environment variables as shown below for Debian-based systems:

```console
$ java --version
openjdk 21.0.7 2025-04-15
OpenJDK Runtime Environment (build 21.0.7+6-Ubuntu-0ubuntu124.04)
OpenJDK 64-Bit Server VM (build 21.0.7+6-Ubuntu-0ubuntu124.04, mixed mode, sharing)

$ export JAVA_HOME=/snap/openjdk/current/jdk
$ $JAVA_HOME/bin/java --version
openjdk 24.0.1 2025-04-15
OpenJDK Runtime Environment (build 24.0.1+9-snap)
OpenJDK 64-Bit Server VM (build 24.0.1+9-snap, mixed mode, sharing)

$ export PATH=$JAVA_HOME/bin:$PATH
$ java --version
openjdk 24.0.1 2025-04-15
OpenJDK Runtime Environment (build 24.0.1+9-snap)
OpenJDK 64-Bit Server VM (build 24.0.1+9-snap, mixed mode, sharing)
```

For Fedora-based systems, see the [Usage](#usage) section later.

## Repository

The branches of this repository publish the JDK general-availability release (GA) and early-access builds (EA) for the hardware platforms listed below. The table shows the Debian architecture, machine hardware name, and Java architecture of each build:

| Debian  | Machine | Java    | JDK GA | JDK EA |
|:-------:|:-------:|:-------:|:------:|:------:|
| amd64   | x86_64  | amd64   | ✓ | ✓ |
| arm64   | aarch64 | aarch64 | ✓ | ✓ |
| armhf   | armv7l  | arm     | ✓ | ✓ |
| ppc64el | ppc64le | ppc64le | ✓ | ✓ |
| s390x   | s390x   | s390x   | ✓ | ✓ |

The branches of this repository are named after the Snap channels where the builds are published: *edge*, *beta*, *candidate*, and *stable*. The HEAD branch is *edge*, and merges follow the Snap package releases from *edge* into *beta*, *beta* into *candidate*, and *candidate* into *stable*.

## See Also

This project is one of four that I created to gain control of my development environment:

* [OpenJDK](https://github.com/jgneff/openjdk) - Current JDK release and early-access builds

    [![openjdk](https://snapcraft.io/openjdk/badge.svg)](https://snapcraft.io/openjdk)

* [OpenJFX](https://github.com/jgneff/openjfx) - Current JavaFX release and early-access builds

    [![openjfx](https://snapcraft.io/openjfx/badge.svg)](https://snapcraft.io/openjfx)

* [Strictly Maven](https://github.com/jgneff/strictly-maven) - Apache Maven™ in a strictly-confined snap

    [![strictly-maven](https://snapcraft.io/strictly-maven/badge.svg)](https://snapcraft.io/strictly-maven)

* [Strictly NetBeans](https://github.com/jgneff/strictly-netbeans) - Apache NetBeans® in a strictly-confined snap

    [![strictly-netbeans](https://snapcraft.io/strictly-netbeans/badge.svg)](https://snapcraft.io/strictly-netbeans)

## Schedule

The table below contains the most recent schedule for OpenJDK. The channel columns show the JDK releases found on the channels during each phase of the schedule.

| Date       | Phase                     | Stable | Candidate | Beta | Edge |
| ---------- | ------------------------- |:------:|:---------:|:----:|:----:|
| 2025-03-18 | General Availability      | 24 | ←  | ←  | 25 |
| 2025-06-05 | Rampdown Phase One        | 24 | ←  | 25 | 26 |
| 2025-07-17 | Rampdown Phase Two        | 24 | ←  | 25 | 26 |
| 2025-08-07 | Initial Release Candidate | 24 | 25 | ←  | 26 |
| 2025-08-21 | Final Release Candidate   | 24 | 25 | ←  | 26 |
| 2025-09-16 | General Availability      | 25 | ←  | ←  | 26 |

The leftwards arrow (←) indicates that the channel is closed. When a specific risk-level channel is closed, the Snap Store will select the package from the more conservative risk level in the column to its left. If the channel is re-opened, packages will once again be selected from the original channel.

## Installation

Install the OpenJDK Snap package with the command:

```console
$ sudo snap install openjdk
```

The Snap package is [strictly confined](https://snapcraft.io/docs/snap-confinement) and adds only the following interfaces to its permissions:

* the [home interface](https://snapcraft.io/docs/home-interface) for the JDK tools to read and write files under your home directory,
* the [desktop interfaces](https://snapcraft.io/docs/desktop-interfaces) for the Java launcher to run Java desktop applications, and
* the [network interface](https://snapcraft.io/docs/network-interface) for the Java launcher to run Java network applications.

Install the OpenJDK Snap package from a channel other than the *stable* channel with one of the following commands:

```console
$ sudo snap install openjdk --candidate
$ sudo snap install openjdk --beta
$ sudo snap install openjdk --edge
```

## Trust

The steps in building the packages are open and transparent so that you can gain trust in the process that creates them instead of having to put all of your trust in their publisher.

| Snap Channel | Build File          | Source Code         | Snap Package           |
| ------------ | ------------------- | ------------------- | ---------------------- |
| candidate    | [snapcraft.yaml][1] | [openjdk/jdk24u][4] | [openjdk-candidate][7] |
| beta         | [snapcraft.yaml][2] | [openjdk/jdk][5]    | [openjdk-beta][8]      |
| edge         | [snapcraft.yaml][3] | [openjdk/jdk][6]    | [openjdk-edge][9]      |

[1]: https://github.com/jgneff/openjdk/blob/candidate/snap/snapcraft.yaml
[2]: https://github.com/jgneff/openjdk/blob/beta/snap/snapcraft.yaml
[3]: https://github.com/jgneff/openjdk/blob/edge/snap/snapcraft.yaml

[4]: https://github.com/openjdk/jdk24u/tags
[5]: https://github.com/openjdk/jdk/tags
[6]: https://github.com/openjdk/jdk/tags

[7]: https://launchpad.net/~jgneff/openjdk-snap/+snap/openjdk-candidate
[8]: https://launchpad.net/~jgneff/openjdk-snap/+snap/openjdk-beta
[9]: https://launchpad.net/~jgneff/openjdk-snap/+snap/openjdk-edge

For each of the three channels, the table above links to:

* the Snapcraft build file that creates the Snap package,
* the release tags used to obtain the OpenJDK source code, and
* information about the package and its latest builds on Launchpad.

General-availability releases published to the *candidate* channel are eventually promoted to the *stable* channel.

The [Launchpad build farm](https://launchpad.net/builders) runs each build in a transient container created from trusted images to ensure a clean and isolated build environment. Snap packages built on Launchpad include a manifest that lets you verify the build and identify its dependencies.

## Verify

Each OpenJDK package provides a software bill of materials (SBOM) and a link to its build log. This information is contained in a file called `manifest.yaml` in the directory `/snap/openjdk/current/snap`. The `image-info` section of the manifest provides a link to the package's page on Launchpad with its build status, including the complete log file from the container that ran the build. You can use this information to verify that the OpenJDK Snap package installed on your system was built from source on Launchpad using only the software in [Ubuntu 20.04 LTS](https://cloud-images.ubuntu.com/focal/current/).

For example, I'll demonstrate how I verify the OpenJDK Snap package installed on my system at the time of this writing. The `snap info` command shows that I installed OpenJDK version 24.0.1+9 with revision 2220, the revision for the *amd64* architecture:

```console
$ snap info openjdk
...
channels:
  latest/stable:    24.0.1+9 2025-04-16 (2220) 277MB -
  latest/candidate: ↑
  latest/beta:      ↑
  latest/edge:      25+26    2025-06-06 (2259) 277MB -
installed:          24.0.1+9            (2220) 277MB -
```

The following command prints the build information from the manifest file:

```console
$ grep -A3 image-info /snap/openjdk/current/snap/manifest.yaml
image-info:
  build-request-id: lp-97610881
  build-request-timestamp: '2025-04-15T18:42:57Z'
  build_url: https://launchpad.net/~jgneff/openjdk-snap/+snap/openjdk-candidate/+build/2780824
```

The `build_url` in the manifest is a link to the [page on Launchpad](https://launchpad.net/~jgneff/openjdk-snap/+snap/openjdk-candidate/+build/2780824) with the package's **Build status** and **Store status**. The store status shows that Launchpad uploaded revision 2220 to the Snap Store, which matches the revision installed on my system. The build status shows a link to the log file with the label [buildlog](https://launchpad.net/~jgneff/openjdk-snap/+snap/openjdk-candidate/+build/2780824/+files/buildlog_snap_ubuntu_bionic_amd64_openjdk-candidate_BUILDING.txt.gz).

The end of the log file contains a line with the SHA512 checksum of the package just built, shown below with the checksum split to fit on this page:

```
Snapping...
Snapped openjdk_24.0.1+9_amd64.snap
Starting Snapcraft 7.5.8
Logging execution to '/root/.local/state/snapcraft/log/snapcraft-20250415-190002.159578.log'
762ddc751db5ea7a25951ba63e147e1cde6caceb420df6bb686a8aaf6e45432c
4fbbe959a098bad53f68822649955bcf1a0007dd20b437b7cc90845ba3131d3d
  openjdk_24.0.1+9_amd64.snap
Revoking proxy token...
```

The command below prints the checksum of the package installed on my system:

```console
$ sudo sha512sum /var/lib/snapd/snaps/openjdk_2220.snap
762ddc751db5ea7a25951ba63e147e1cde6caceb420df6bb686a8aaf6e45432c
4fbbe959a098bad53f68822649955bcf1a0007dd20b437b7cc90845ba3131d3d
  /var/lib/snapd/snaps/openjdk_2220.snap
```

The two checksum strings are identical. Using this procedure, I verified that the OpenJDK Snap package installed on my system and the OpenJDK Snap package built and uploaded to the Snap Store by Launchpad are in fact the exact same package. For more information, see [Launchpad Bug #1979844](https://bugs.launchpad.net/launchpad/+bug/1979844), "Allow verifying that a snap recipe build corresponds to a store revision."

## Usage

Once installed, the OpenJDK Snap package includes the following directories:

* `/snap/openjdk/current/jdk` - Java Platform location
* `/snap/openjdk/current/jdk/docs` - Javadoc API documentation
* `/snap/openjdk/current/jdk/man` - Tool reference manuals
* `/snap/openjdk/current/jdk/lib/src.zip` - Source code archive

On Fedora-based systems, these directories are found under the root directory `/var/lib/snapd` as a prefix to the locations shown above for Debian-based systems.

You can use the package in two ways:

1. as a confined set of programs that include all of their dependencies, or
2. as an unconfined suite of software forming a complete Java Platform.

The first method should work on any Linux system, but the programs can access only non-hidden files owned by the user in the user's home directory. See the **Confined Usage** section below for details.

The second method runs with traditional file access, but the programs require a system with Linux kernel version 3.2.0 or later and GNU C library version 2.29 or later. Those versions of the kernel and C library are found, for example, in Ubuntu 20.04 LTS, Fedora 30, or later releases. See the **Unconfined Usage** section below for details.

### Confined Usage

When you run the OpenJDK commands with the prefix `openjdk`, the programs run strictly confined and use only the supporting libraries contained in the Snap package. The package defines the following commands for each of the corresponding JDK tools:

- openjdk.java
- openjdk.javac
- openjdk.javadoc
- openjdk.jar
- openjdk.jarsigner
- openjdk.jlink
- openjdk.jwebserver

The `openjdk` command itself prints the location of a file that defines environment variables and aliases which make it more convenient to use the OpenJDK Snap package:

```console
$ openjdk
/var/snap/openjdk/2220/openjdk.env
```

The file exports the `JAVA_HOME` and `MANPATH` environment variables, and it defines aliases for the JDK tools so that you can enter them without the package prefix:

```console
$ cat $(openjdk)
# Source this file for OpenJDK environment variables and aliases
export JAVA_HOME=/snap/openjdk/2220/jdk
export MANPATH=/snap/openjdk/2220/jdk/man:
alias java='openjdk.java'
alias javac='openjdk.javac'
alias javadoc='openjdk.javadoc'
alias jar='openjdk.jar'
alias jarsigner='openjdk.jarsigner'
alias jlink='openjdk.jlink'
alias jwebserver='openjdk.jwebserver'
```

To set the environment variables and aliases in your current shell, use the `source` or "dot" (`.`) command to read and execute the commands from the file:

```console
$ source $(openjdk)
```

You can then verify that `JAVA_HOME` and the aliases are defined with:

```console
$ printenv | grep JAVA
JAVA_HOME=/snap/openjdk/2220/jdk
$ type java javac
java is aliased to `openjdk.java'
javac is aliased to `openjdk.javac'
$ java --version
openjdk 24.0.1 2025-04-15
OpenJDK Runtime Environment (build 24.0.1+9-snap)
OpenJDK 64-Bit Server VM (build 24.0.1+9-snap, mixed mode, sharing)

```

If you refer to locations outside of your home directory in the arguments to the Snap package commands or aliases, such as the JUnit libraries shown below, you'll see error messages like the following when compiling your program:

```console
$ openjdk.javac -d build/testing --class-path \
  /usr/share/java/junit4.jar:/usr/share/java/hamcrest-core-1.3.jar \
  src/main/java/org/status6/hello/world/Hello.java \
  src/test/java/org/status6/hello/world/HelloTest.java
src/test/java/org/status6/hello/world/HelloTest.java:19:
  error: package org.junit does not exist
import org.junit.Assert;
                ^
```

You'll also see error messages like the following when running your program:

```console
$ openjdk.java --class-path \
  dist/hello-world-1.0.jar:/usr/share/java/junit4.jar:/usr/share/java/hamcrest-core-1.3.jar \
  org.junit.runner.JUnitCore org.status6.hello.world.HelloTest
Error: Could not find or load main class org.junit.runner.JUnitCore
Caused by: java.lang.ClassNotFoundException: org.junit.runner.JUnitCore
```

In this case, copy the external libraries into your home directory to allow access, as in the example shown below:

```console
$ openjdk.javac -d build/testing --class-path \
  $HOME/lib/java/junit4.jar:$HOME/lib/java/hamcrest-core-1.3.jar \
  src/main/java/org/status6/hello/world/Hello.java \
  src/test/java/org/status6/hello/world/HelloTest.java
```

### Unconfined Usage

Build automation tools and integrated development environments (IDEs) usually require the location of a Java Platform, often with a corresponding `JAVA_HOME` environment variable. These tools invoke the JDK programs directly using their absolute paths on your system.

When the programs are invoked directly, they run outside of their strictly-confined container and in your system's environment like any normal program. They have the same access to your system as the user account that runs them, and they depend on having their supporting libraries installed on your system. This is not how you're supposed to run a Snap package, but it works when the correct system dependencies are installed.

Specifically, when invoked directly from their absolute paths, the commands in the OpenJDK Snap package require Linux kernel version 3.2.0 or later and GNU C library (glibc) version 2.29 or later. The following commands will show the versions of the kernel and C library on your system:

```console
$ uname -r
$ ldd --version
```

With the required kernel and C library, you can set the `JAVA_HOME` environment variable and run the programs directly. On Debian-based systems, define:

```console
$ export JAVA_HOME=/snap/openjdk/current/jdk
```

On Fedora-based systems, define:

```console
$ export JAVA_HOME=/var/lib/snapd/snap/openjdk/current/jdk
```

You can then run the programs directly from their installed locations:

```console
$ $JAVA_HOME/bin/java --version
openjdk 24.0.1 2025-04-15
OpenJDK Runtime Environment (build 24.0.1+9-snap)
OpenJDK 64-Bit Server VM (build 24.0.1+9-snap, mixed mode, sharing)
```

If your system has a version of the GNU C library older than 2.29, you'll see error messages similar to the example shown below, which ran on Ubuntu 18.04 LTS with glibc 2.27:

```console
$ $JAVA_HOME/bin/java --version
Error: dl failure on line 532
Error: failed /snap/openjdk/2259/jdk/lib/server/libjvm.so, because
    /lib/x86_64-linux-gnu/libm.so.6: version `GLIBC_2.29' not found
    (required by /snap/openjdk/2259/jdk/lib/server/libjvm.so)
```

In this case, either upgrade your Linux system to a more recent version, or run the JDK tools using their Snap package commands or aliases as follows:

```console
$ openjdk.java --version
openjdk 24.0.1 2025-04-15
OpenJDK Runtime Environment (build 24.0.1+9-snap)
OpenJDK 64-Bit Server VM (build 24.0.1+9-snap, mixed mode, sharing)
```

Most desktop systems will include all of the packages needed to run the JDK tools, except for one: the `binutils` package required by `jlink`. The `jlink` program needs the `objcopy` command from `binutils` to create a custom run-time image. Without the extra package, you'll see an error message like the following:

```console
$ $JAVA_HOME/bin/jlink ...
Error: java.io.IOException: Cannot run program "objcopy": error=2,
    No such file or directory
```

Solve the error by installing the required package:

```console
$ sudo apt install binutils
```

The following two sections compare the support on Ubuntu and Fedora Linux distributions for running the JDK programs confined in their Snap package or unconfined as a Java Platform.

#### Ubuntu

The table below shows the Snap package support for recent releases of Ubuntu:

| Release   | End of Updates | C Library | Confined | Unconfined |
| --------- |:--------------:|:---------:|:--------:|:----------:|
| 16.04 LTS | 2021-04-30     | 2.23      | ✓ |   |
| 18.04 LTS | 2023-05-31     | 2.27      | ✓ |   |
| 20.04 LTS | 2025-05-29     | 2.31      | ✓ | ✓ |
| 22.04 LTS | 2027-06-01     | 2.35      | ✓ | ✓ |
| 24.04 LTS | 2029-05-31     | 2.39      | ✓ | ✓ |

#### Fedora

The table below shows the Snap package support for recent releases of Fedora:

| Release | End of Updates | C Library | Confined | Unconfined |
|:-------:|:--------------:|:---------:|:--------:|:----------:|
| 24      | 2017-08-08     | 2.23      | ✓ |   |
| 25      | 2017-12-12     | 2.24      | ✓ |   |
| 26      | 2018-05-29     | 2.25      | ✓ |   |
| 27      | 2018-11-30     | 2.26      | ✓ |   |
| 28      | 2019-05-28     | 2.27      | ✓ |   |
| 29      | 2019-11-26     | 2.28      | ✓ |   |
| 30      | 2020-05-26     | 2.29      | ✓ | ✓ |
| 31      | 2020-11-24     | 2.30      | ✓ | ✓ |
| 32      | 2021-05-25     | 2.31      | ✓ | ✓ |
| 33      | 2021-11-30     | 2.32      | ✓ | ✓ |
| 34      | 2022-06-07     | 2.33      | ✓ | ✓ |
| 35      | 2022-12-13     | 2.34      | ✓ | ✓ |
| 36      | 2023-05-16     | 2.35      | ✓ | ✓ |
| 37      | 2023-12-05     | 2.36      | ✓ | ✓ |
| 38      | 2024-05-21     | 2.37      | ✓ | ✓ |
| 39      | 2024-11-26     | 2.38      | ✓ | ✓ |
| 40      | 2025-05-13     | 2.39      | ✓ | ✓ |
| 41      | 2025-11-19     | 2.40      | ✓ | ✓ |
| 42      | 2026-05-13     | 2.41      | ✓ | ✓ |

## Build

You can build the Snap package on Linux by installing [Snapcraft](https://snapcraft.io/snapcraft) on your development workstation. The `snap/snapcraft.yaml` files on the *candidate*, *beta*, and *edge* branches define the build for each channel. Run the following commands to install Snapcraft, clone this repository, and start building the package:

```console
$ sudo snap install snapcraft --classic
$ git clone https://github.com/jgneff/openjdk.git
$ cd openjdk
$ snapcraft
```

To run the build remotely on Launchpad, enter the command:

```console
$ snapcraft remote-build
```

See the [Snapcraft Documentation](https://documentation.ubuntu.com/snapcraft/stable/) for more information about building Snap packages.

## License

This project is licensed under the GNU General Public License v2.0 with the Classpath exception, the same license used by Oracle for the JDK project. See the files [LICENSE](LICENSE), [ADDITIONAL_LICENSE_INFO](ADDITIONAL_LICENSE_INFO), and [ASSEMBLY_EXCEPTION](ASSEMBLY_EXCEPTION) for details.

Java and OpenJDK are trademarks or registered trademarks of Oracle and/or its affiliates. See the file [TRADEMARK](TRADEMARK) for details.
