![OpenJDK: Current JDK release and early-access builds](images/banner.svg)

OpenJDK is the official reference implementation of the Java Platform, Standard Edition. This project builds [Snap packages](https://snapcraft.io/openjdk) of OpenJDK directly from its [source repositories](https://github.com/openjdk) on GitHub. These packages provide everything you need to develop a Java application on Linux, including all of the latest development tools, class libraries, API documentation, and source code of the Java Development Kit (JDK).

The branches of this repository publish the JDK general-availability (GA) release and early-access (EA) builds for six hardware platforms, listed below by their Debian architectures and machine hardware names:

| Architecture | Machine | JDK GA | JDK EA |
|:------------:|:-------:|:------:|:------:|
| amd64        | x86_64  | ✔ | ✔ |
| arm64        | aarch64 | ✔ | ✔ |
| armhf        | armv7l  | ✔ | ✔ |
| i386         | i686    | ✔ | ✔ |
| ppc64el      | ppc64le | ✔ | ✔ |
| s390x        | s390x   | ✔ | ✔ |

**Note:** this repository uses branches differently from most repositories on GitHub. It follows the workflow recommended by Junio Hamano, the core maintainer of Git, for managing [permanent parallel branches](https://www.spinics.net/linux/lists/git/msg94767.html). The `snapcraft.yaml` build files are found only on the *candidate*, *beta*, and *edge* branches, named after the Snap channels where the builds are published. The files common to all branches are updated only on the *main* branch. Merges are done from the *main* branch to the three channel branches, never the other way.

## See also

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

The table below shows the most recent schedule for OpenJDK. The channel columns list the JDK releases found on the channel during each phase of the schedule.

| Date       | Phase                     | Stable | Candidate | Beta | Edge |
| ---------- | ------------------------- |:------:|:---------:|:----:|:----:|
| 2022-03-22 | General Availability      | 18 | ←  | ←  | 19 |
| 2022-06-09 | Rampdown Phase One        | 18 | ←  | 19 | 20 |
| 2022-07-21 | Rampdown Phase Two        | 18 | ←  | 19 | 20 |
| 2022-08-11 | Initial Release Candidate | 18 | 19 | ←  | 20 |
| 2022-08-25 | Final Release Candidate   | 18 | 19 | ←  | 20 |
| 2022-09-20 | General Availability      | 19 | ←  | ←  | 20 |

The leftwards arrow (←) indicates that the channel is closed. When a specific risk-level channel is closed, the Snap Store will select the package from the more conservative risk level in the column to its left. If the channel is re-opened, packages will once again be selected from the original channel.

## Install

Install the OpenJDK Snap package with the command:

```console
$ sudo snap install openjdk
```

The Snap package is [strictly confined](https://snapcraft.io/docs/snap-confinement) and adds only the following interfaces to its permissions:

* the [home interface](https://snapcraft.io/docs/home-interface) for the JDK tools to read and write files under your home directory,
* the [desktop interfaces](https://snapcraft.io/docs/desktop-interfaces) for the Java launcher to run Java desktop applications, and
* the [network interface](https://snapcraft.io/docs/network-interface) for the Java launcher to run Java networking applications and remote desktop applications with X11 forwarding.

Install the OpenJDK Snap package from a channel other than the *stable* channel with one of the following commands:

```console
$ sudo snap install openjdk --candidate
$ sudo snap install openjdk --beta
$ sudo snap install openjdk --edge
```

## Trust

The steps in building the packages are open and transparent so that you can gain trust in the process that creates them instead of having to put all of your trust in their publisher.

| Snap Channel | Build File     | Source Code         | Snap Package           |
| ------------ | -------------- | ------------------- | ---------------------- |
| candidate    | [candidate][1] | [openjdk/jdk19u][4] | [openjdk-candidate][7] |
| beta         | [beta][2]      | [openjdk/jdk][5]    | [openjdk-beta][8]      |
| edge         | [edge][3]      | [openjdk/jdk][6]    | [openjdk-edge][9]      |

[1]: https://github.com/jgneff/openjdk/blob/candidate/snap/snapcraft.yaml
[2]: https://github.com/jgneff/openjdk/blob/beta/snap/snapcraft.yaml
[3]: https://github.com/jgneff/openjdk/blob/edge/snap/snapcraft.yaml

[4]: https://github.com/openjdk/jdk19u/tags
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

Each OpenJDK package provides a software bill of materials (SBOM) and a link to its build log. This information is contained in a file called `manifest.yaml` in the directory `/snap/openjdk/current/snap`. The `image-info` section of the manifest provides a link to the package's page on Launchpad with its build status, including the complete log file from the container that ran the build. You can use this information to verify that the OpenJDK Snap package installed on your system was built from source on Launchpad using only the software in [Ubuntu 18.04 LTS](https://cloud-images.ubuntu.com/bionic/current/).

For example, I'll demonstrate how I verify the OpenJDK Snap package installed on my system at the time of this writing. The `snap info` command shows that I installed OpenJDK version 19+36 with revision 1079, the revision for the *amd64* architecture:

```console
$ snap info openjdk
...
channels:
  latest/stable:    19+36 2022-09-20 (1079) 247MB -
  latest/candidate: ↑
  latest/beta:      ↑
  latest/edge:      20+15 2022-09-15 (1090) 249MB -
installed:          19+36            (1079) 247MB -
```

The following command prints the build information from the manifest file:

```console
$ grep -A3 image-info /snap/openjdk/current/snap/manifest.yaml
image-info:
  build-request-id: lp-73864071
  build-request-timestamp: '2022-09-06T16:01:55Z'
  build_url: https://launchpad.net/~jgneff/openjdk-snap/+snap/openjdk-candidate/+build/1872495
```

The `build_url` in the manifest is a link to the [page on Launchpad](https://launchpad.net/~jgneff/openjdk-snap/+snap/openjdk-candidate/+build/1872495) with the package's **Build status** and **Store status**. The store status shows that Launchpad uploaded revision 1079 to the Snap Store, which matches the revision installed on my system. The build status shows a link to the log file with the label *buildlog*.

The end of the log file contains a line with the SHA512 checksum of the package just built, shown below with the checksum edited to fit on this page:

```
Snapping...
Snapped openjdk_19+36_amd64.snap
Starting Snapcraft 7.1.3
Logging execution to
  '/root/.cache/snapcraft/log/snapcraft-20220906-161326.995272.log'
1594263134ecf752...bcc699101fca509f  openjdk_19+36_amd64.snap
Revoking proxy token...
```

The command below prints the checksum of the package installed on my system:

```console
$ sudo sha512sum /var/lib/snapd/snaps/openjdk_1079.snap
1594263134ecf752...bcc699101fca509f  /var/lib/snapd/snaps/openjdk_1079.snap
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

The first method should work on any Linux system, but the programs can access only non-hidden files owned by the user in the user's home directory. See the **Confined** section below for details.

The second method runs with traditional file access, but the programs require a system with Linux kernel version 3.2.0 or later and GNU C library version 2.27 or later. Those versions of the kernel and C library are found, for example, in Ubuntu 18.04 LTS, Fedora 28, or later releases. See the **Unconfined** section below for details.

### Confined

When you run the OpenJDK commands with the prefix `openjdk`, the programs run strictly confined and use only the supporting libraries contained in the Snap package. The package defines the following commands for each of the corresponding JDK tools:

- openjdk.java
- openjdk.javac
- openjdk.javadoc
- openjdk.jar
- openjdk.jarsigner
- openjdk.jlink
- openjdk.jpackage
- openjdk.jwebserver

The `openjdk` command itself prints the location of a file that defines environment variables and aliases which make it more convenient to use the OpenJDK Snap package:

```console
$ openjdk
/var/snap/openjdk/x1/openjdk.env
```

The file exports the `JAVA_HOME` and `MANPATH` environment variables, and it defines aliases for the JDK tools so that you can enter them without the package prefix:

```console
$ cat $(openjdk)
# Source this file for OpenJDK environment variables and aliases
export JAVA_HOME=/snap/openjdk/x1/jdk
export MANPATH=/snap/openjdk/x1/jdk/man:
alias java='openjdk.java'
alias javac='openjdk.javac'
alias javadoc='openjdk.javadoc'
alias jar='openjdk.jar'
alias jarsigner='openjdk.jarsigner'
alias jlink='openjdk.jlink'
alias jpackage='openjdk.jpackage'
alias jwebserver='openjdk.jwebserver'
```

To set the environment variables and aliases in your current shell, use the `source` or "dot" (`.`) command to read and execute the commands from the file:

```console
$ . $(openjdk)
```

You can then verify that `JAVA_HOME` and the aliases are defined with:

```console
$ printenv | grep JAVA
JAVA_HOME=/snap/openjdk/x1/jdk
$ type java javac
java is aliased to `openjdk.java'
javac is aliased to `openjdk.javac'
$ java --version
openjdk 19 2022-09-20
OpenJDK Runtime Environment (build 19+36-snap)
OpenJDK 64-Bit Server VM (build 19+36-snap, mixed mode, sharing)
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

### Unconfined

Build automation tools and integrated development environments (IDEs) usually require the location of a Java Platform, often with a corresponding `JAVA_HOME` environment variable. These tools invoked the JDK programs directly using their absolute paths on your system.

When the programs are invoked directly, they run outside of their strictly-confined container and in your system's environment like any normal program. They have the same access to your system as the user account that runs them, and they depend on having their supporting libraries installed on your system. This is not how you're supposed to run Snap packages, but it works when the correct system dependencies are present.

Specifically, when invoked directly from their absolute paths, the commands in the OpenJDK Snap package require Linux kernel version 3.2.0 or later and GNU C library (GLIBC) version 2.27 or later. The following commands will show the versions of the kernel and GLIBC on your system:

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
openjdk 19 2022-09-20
OpenJDK Runtime Environment (build 19+36-snap)
OpenJDK 64-Bit Server VM (build 19+36-snap, mixed mode, sharing)
```

If your system has a version of the GNU C library older than 2.27, you'll see error messages similar to the example shown below, which ran on Ubuntu 16.04 LTS with GLIBC 2.23:

```console
$ $JAVA_HOME/bin/java --version
Error: dl failure on line 534
Error: failed /snap/openjdk/x1/jdk/lib/server/libjvm.so, because
    /lib/x86_64-linux-gnu/libm.so.6: version `GLIBC_2.27' not found
    (required by /snap/openjdk/x1/jdk/lib/server/libjvm.so)
```

In this case, either upgrade your Linux system to a more recent version, or run the JDK tools using their Snap package commands or aliases as follows:

```console
$ openjdk.java --version
openjdk 19 2022-09-20
OpenJDK Runtime Environment (build 19+36-snap)
OpenJDK 64-Bit Server VM (build 19+36-snap, mixed mode, sharing)
```

Most desktop installations will already have the libraries required by the JDK tools, but the `jlink` and `jpackage` programs require two additional packages when they run outside of the Snap package container. They both need the `objcopy` program from the `binutils` package to create the custom run-time image, and the `jpackage` program needs the `fakeroot` package to create a Debian package.

Without these extra packages, you'll see error messages like the following:

```console
$ $JAVA_HOME/bin/jlink ...
Error: java.io.IOException: Cannot run program "objcopy": error=2,
    No such file or directory
```

```console
$ $JAVA_HOME/bin/jpackage ...
Bundler DEB Bundle skipped because of a configuration problem:
    Can not find fakeroot. Reason: Cannot run program "fakeroot":
    error=2, No such file or directory
```

Solve these errors by installing the required packages:

```console
$ sudo apt install binutils fakeroot
```

The following two sections compare the support on Ubuntu and Fedora Linux distributions for running the JDK programs confined in their Snap package or unconfined as a Java Platform.

#### Ubuntu

The table below shows the Snap package support for recent releases of Ubuntu:

| Release   | End of Updates | C Library | Confined | Unconfined |
| --------- |:--------------:|:---------:|:--------:|:----------:|
| 16.04 LTS | 2021-04-30     | 2.23      | ✔ |   |
| 18.04 LTS | 2023-04-26     | 2.27      | ✔ | ✔ |
| 20.04 LTS | 2025-04-23     | 2.31      | ✔ | ✔ |
| 22.04 LTS | 2027-04-21     | 2.34      | ✔ | ✔ |

#### Fedora

The table below shows the Snap package support for recent releases of Fedora:

| Release | End of Updates | C Library | Confined | Unconfined |
|:-------:|:--------------:|:---------:|:--------:|:----------:|
| 24      | 2017-08-08     | 2.23      | ✔ |   |
| 25      | 2017-12-12     | 2.24      | ✔ |   |
| 26      | 2018-05-29     | 2.25      | ✔ |   |
| 27      | 2018-11-30     | 2.26      | ✔ |   |
| 28      | 2019-05-28     | 2.27      | ✔ | ✔ |
| 29      | 2019-11-26     | 2.28      | ✔ | ✔ |
| 30      | 2020-05-26     | 2.29      | ✔ | ✔ |
| 31      | 2020-11-24     | 2.30      | ✔ | ✔ |
| 32      | 2021-05-25     | 2.31      | ✔ | ✔ |
| 33      | 2021-11-30     | 2.32      | ✔ | ✔ |
| 34      | 2022-05-17     | 2.33      | ✔ | ✔ |
| 35      | 2022-12-07     | 2.34      | ✔ | ✔ |
| 36      | 2023-05-24     | 2.35      | ✔ | ✔ |

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

See the [Snapcraft Overview](https://snapcraft.io/docs/snapcraft-overview) page for more information about building Snap packages.

## License

This project is licensed under the GNU General Public License v2.0 with the Classpath exception, the same license used by Oracle for the OpenJDK project. See the files [LICENSE](LICENSE) and [ADDITIONAL_LICENSE_INFO](ADDITIONAL_LICENSE_INFO) for details.

Java and OpenJDK are trademarks or registered trademarks of Oracle and/or its affiliates. See the file [TRADEMARK](TRADEMARK) for details.
