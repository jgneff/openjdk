![OpenJDK: Current JDK Release and Early-Access Builds](images/banner.svg)

OpenJDK is the official reference implementation of the Java Platform, Standard Edition. This project builds [Snap packages](https://snapcraft.io/openjdk) of OpenJDK directly from its [source repositories](https://github.com/openjdk). These packages provide everything you need to develop a Java application on Linux, including all of the latest development tools, class libraries, API documentation, and source code of the Java Development Kit (JDK).

The OpenJDK general-availability (GA) release and early-access (EA) builds are published for all of the hardware platforms listed below, identified by their Debian architectures and machine hardware names:

| Architecture | Hardware | OpenJDK GA | OpenJDK EA |
|:------------:|:--------:|:----------:|:----------:|
| amd64        | x86_64   | ✔ | ✔ |
| arm64        | aarch64  | ✔ | ✔ |
| armhf        | armv7l   | ✔ | ✔ |
| i386         | i686     | ✔ | ✔ |
| ppc64el      | ppc64le  | ✔ | ✔ |
| s390x        | s390x    | ✔ | ✔ |

**Note:** this repository uses branches differently from most repositories on GitHub. It follows the workflow recommended by Junio Hamano, the core maintainer of Git, for managing [permanent parallel branches](https://www.spinics.net/linux/lists/git/msg94767.html). The `snapcraft.yaml` build files are found only on the *candidate*, *beta*, and *edge* branches, named after the Snap channels where the builds are published. The files common to all branches are updated only on the *main* branch. Merges are done from the *main* branch to the three channel branches, never the other way.

## Schedule

The table below maps the most recent release schedule to the channels of the OpenJDK Snap package. The channel columns show the JDK release found on the channel during each phase of the schedule.

| Date       | Phase                     | Stable | Candidate | Beta | Edge |
| ---------- | ------------------------- |:------:|:---------:|:----:|:----:|
| 2022-03-22 | General Availability      | 18 | ←  | ←  | 19 |
| 2022-06-09 | Rampdown Phase One        | 18 | ←  | 19 | 20 |
| 2022-07-21 | Rampdown Phase Two        | 18 | ←  | 19 | 20 |
| 2022-08-11 | Initial Release Candidate | 18 | 19 | ←  | 20 |
| 2022-08-25 | Final Release Candidate   | 18 | 19 | ←  | 20 |
| 2022-09-20 | General Availability      | 19 | ←  | ←  | 20 |

The leftwards arrow symbol (←) indicates that the channel is closed. When a specific risk-level channel is closed, the Snap Store will select the package from the more conservative risk level to the left in the table. If the channel is re-opened, packages will once again be selected from the original channel.

## Status

I verify the Snap packages by compiling, packaging, testing, running, and linking some very simple Java console, Java Swing, and JavaFX applications on a variety of Linux distributions and architectures.

The following table shows the status of my tests on QEMU **virtual machines:**

|   | Arch    | Processor      | System                | Notes |
|:-:|:-------:| -------------- | --------------------- |:-----:|
| ✔ | amd64   | Intel Core     | Fedora 34 Workstation | 1     |
| ✔ | arm64   | ARM Cortex-A57 | Ubuntu 20.04 LTS      |       |
| ✔ | armhf   | ARM Cortex-A15 | Ubuntu 20.04 LTS      |       |
| ✔ | i386    | Intel Core     | Raspberry Pi Desktop  |       |
| ✔ | ppc64el | IBM POWER9     | Ubuntu 20.04 LTS      |       |
| ❌ | s390x   | IBM/S390 2964  | Ubuntu 20.04 LTS      | 2     |

1. The commands in Snap packages print the following message on Fedora 34 Workstation:<br>`WARNING: cgroup v2 is not fully supported yet, proceeding with partial confinement`.
2. Java crashes on QEMU virtual machines that use the *s390x* architecture. See [QEMU Issue #655](https://gitlab.com/qemu-project/qemu/-/issues/655).

The following table shows the status of my tests on **physical machines:**

|   | Arch    | Processor          | System           | Hardware                  | Notes |
|:-:|:-------:| ------------------ | ---------------- | ------------------------- |:-----:|
| ✔ | amd64   | Intel Xeon E3-1225 | Ubuntu 20.04 LTS | Dell Precision Tower 3420 |       |
| ✔ | arm64   | ARM Cortex-A53     | Ubuntu 20.04 LTS | Raspberry Pi 3 Model A+   | 1     |
| ✔ | armhf   | ARM Cortex-A7      | Raspberry Pi OS  | Raspberry Pi 2 Model B    | 2     |
| ✔ | i386    | Intel Atom N270    | Ubuntu 18.04 LTS | Dell Inspiron 1011        |       |
| ✔ | ppc64el | IBM POWER9         | Ubuntu 20.04 LTS | IBM Power System LC921    | 3     |
| ✔ | s390x   | IBM/S390 8561      | RHEL 8.4         | IBM LinuxONE III LT1      | 4, 5  |

1. With just 512 MiB of RAM on the Pi 3 Model A+, the `jlink` and `jpackage` tools are killed when they run out of memory using a 64-bit OS. The other JDK tools still work.
2. OpenJDK Snap revisions after 2021-10-13 [have the fix](https://github.com/jgneff/openjdk/commit/412ffe3) for the following message on Raspberry Pi OS:<br>`ERROR: ld.so: object '/usr/lib/arm-linux-gnueabihf/libarmmem-${PLATFORM}.so' from /etc/ld.so.preload cannot be preloaded (cannot open shared object file): ignored.`
3. I thank the Open Source Lab at Oregon State University for a node on their [IBM POWER9 cluster](https://osuosl.org/services/powerdev/).
4. I also thank Marist College for a virtual server on their massive [IBM LinuxONE mainframe](https://www.marist.edu/-/marist-first-linuxone-iii).
5. Java console and Swing applications work, but JavaFX applications fail to start on the IBM LinuxONE. The Prism ES2 pipeline fails in [`X11GLFactory.java`](https://github.com/openjdk/jfx/blob/master/modules/javafx.graphics/src/main/java/com/sun/prism/es2/X11GLFactory.java), perhaps because there is no graphics card. The software pipeline, chosen with `-Dprism.order=sw`, fails at [`ViewScene.java:78`](https://github.com/openjdk/jfx/blob/master/modules/javafx.graphics/src/main/java/com/sun/javafx/tk/quantum/ViewScene.java#L78) when it detects the machine's *big-endian* byte order.

## Install

Install the OpenJDK Snap package with the command:

```console
$ sudo snap install openjdk
```

The Snap package is [strictly confined](https://snapcraft.io/docs/snap-confinement) and adds only the following interfaces to its permissions:

* the [home interface](https://snapcraft.io/docs/home-interface) for the JDK tools to read and write files under your home directory,
* the [desktop interfaces](https://snapcraft.io/docs/desktop-interfaces) for the Java launcher to run Java desktop applications, and
* the [network interface](https://snapcraft.io/docs/network-interface) for the Java launcher to run remote Java desktop applications with X11 forwarding and other Java networking applications.

Install the OpenJDK Snap package from a channel other than the *stable* channel with one of the following commands:

```console
$ sudo snap install openjdk --candidate
$ sudo snap install openjdk --beta
$ sudo snap install openjdk --edge
```

## Trust

The steps in building the packages are open and transparent so that you can gain trust in the process that creates them instead of having to put all of your trust in their publisher.

| Channel   | Build          | Source              | Package                |
| --------- | -------------- | ------------------- | ---------------------- |
| candidate | [candidate][1] | [openjdk/jdk18u][4] | [openjdk-candidate][7] |
| beta      | [beta][2]      | [openjdk/jdk18][5]  | [openjdk-beta][8]      |
| edge      | [edge][3]      | [openjdk/jdk][6]    | [openjdk-edge][9]      |

[1]: https://github.com/jgneff/openjdk/blob/candidate/snap/snapcraft.yaml
[2]: https://github.com/jgneff/openjdk/blob/beta/snap/snapcraft.yaml
[3]: https://github.com/jgneff/openjdk/blob/edge/snap/snapcraft.yaml

[4]: https://github.com/openjdk/jdk18u/tags
[5]: https://github.com/openjdk/jdk18/tags
[6]: https://github.com/openjdk/jdk/tags

[7]: https://launchpad.net/~jgneff/openjdk-snap/+snap/openjdk-candidate
[8]: https://launchpad.net/~jgneff/openjdk-snap/+snap/openjdk-beta
[9]: https://launchpad.net/~jgneff/openjdk-snap/+snap/openjdk-edge

For each of the three channels, the table above links to:

* the Snapcraft build file that creates the Snap package,
* the release tags of the OpenJDK source code repository on GitHub, and
* the package information and latest builds on Launchpad.

General-availability releases published to the *candidate* channel are eventually promoted to the *stable* channel.

The [Launchpad build farm](https://launchpad.net/builders) runs each build in a transient container created from trusted images to ensure a clean and isolated build environment. Snap packages built on Launchpad include a manifest that lets you verify the build and identify its dependencies.

## Verify

Each OpenJDK package provides a software bill of materials (SBOM) and a link to its build logs. This information is contained in a file called `manifest.yaml` in the directory `/snap/openjdk/current/snap`. The section `image-info` provides a link to a page on Launchpad with the build status and details, including the log file from the machine where it ran. The log file lets you verify that the package was built from source using only the software in [Ubuntu 18.04 LTS](https://cloud-images.ubuntu.com/bionic/current/).

The `image-info` section is followed by other sections that provide the name and version of each package used during the build and any packages included in the run-time image.

Having a transparent build process is a good first step, but the only conclusive way to verify a software package is to reproduce it. That's the main recommendation in the article [Preventing Supply Chain Attacks like SolarWinds](https://www.linuxfoundation.org/en/blog/preventing-supply-chain-attacks-like-solarwinds) by David Wheeler, Director of Open Source Supply Chain Security at the Linux Foundation. "In the longer term," he writes, "I know of only one strong countermeasure for this kind of attack: verified reproducible builds." The OpenJDK project [is making progress](https://github.com/openjdk/jdk/pull/6481) on this goal. The Snapcraft build files in this repository set the *configure* option `--with-source-date` to enable the feature when it becomes fully functional.

## Usage

Once installed, the OpenJDK Snap package includes the following directories:

* `/snap/openjdk/current/jdk` - Java Platform location
* `/snap/openjdk/current/jdk/docs` - Javadoc API documentation
* `/snap/openjdk/current/jdk/man` - Tool reference manuals
* `/snap/openjdk/current/jdk/lib/src.zip` - Source file archive

On Fedora-based systems, these directories are found under the root directory `/var/lib/snapd` as a prefix to the locations shown above for Debian-based systems.

You can use the package in two ways:

1. as a set of self-contained programs that include all of their dependencies, or
2. as the suite of software and documentation forming a complete Java Platform.

The first method should work on any Linux system, but the programs can access only non-hidden files owned by the user in the user's home directory. See the **Self-contained** section below for details.

The second method runs with traditional file access, but the programs require a system with Linux kernel version 3.2.0 or later and GNU C library version 2.27 or later. Those versions of the kernel and C library are found, for example, in Ubuntu 18.04 LTS, Fedora 28, or later releases. See the **Java Platform** section below for details.

### Self-contained

When you run the OpenJDK commands with the prefix `openjdk`, the programs use only the supporting libraries contained in the Snap package. The package defines the following commands for each of the corresponding JDK tools:

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
openjdk 18.0.1 2022-04-19
OpenJDK Runtime Environment (build 18.0.1+10-snap)
OpenJDK 64-Bit Server VM (build 18.0.1+10-snap, mixed mode, sharing)
```

If you refer to locations outside of your home directory in the arguments to the Snap package commands or aliases, such as the JUnit libraries below, you'll see error messages like the following when compiling your program:

```console
$ openjdk.javac -d build/testing \
  --class-path /usr/share/java/junit4.jar:/usr/share/java/hamcrest-core.jar \
  org.status6.hello.world/src/main/java/org/status6/hello/world/Hello.java \
  org.status6.hello.world/src/test/java/org/status6/hello/world/HelloTest.java
org.status6.hello.world/src/test/java/org/status6/hello/world/HelloTest.java:19:
  error: package org.junit does not exist
import org.junit.Assert;
                ^
```

You'll also see error messages like the following when running your program:

```console
$ openjdk.java --class-path \
  dist/hello-tests-1.0.0.jar:/usr/share/java/junit4.jar:/usr/share/java/hamcrest-core.jar \
  org.junit.runner.JUnitCore \
  org.status6.hello.world.HelloTest \
  org.status6.hello.swing.HelloTest
Error: Could not find or load main class org.junit.runner.JUnitCore
Caused by: java.lang.ClassNotFoundException: org.junit.runner.JUnitCore
```

In this case, copy the external libraries into your home directory to allow access, as in the example shown below:

```console
$ openjdk.javac -d build/testing \
  --class-path $HOME/lib/java/junit4.jar:$HOME/lib/java/hamcrest-core.jar \
  org.status6.hello.world/src/main/java/org/status6/hello/world/Hello.java \
  org.status6.hello.world/src/test/java/org/status6/hello/world/HelloTest.java
```

### Java Platform

Build automation tools and integrated development environments (IDEs) usually require the location of a Java Platform, often with a corresponding `JAVA_HOME` environment variable. These tools invoke the JDK programs directly using their absolute paths on your system.

When the programs are launched directly, they run outside of their strictly-confined container and in your system's environment like any normal program. They have the same access to your system as the user account that runs them, and they depend on having their supporting libraries installed on your system. This is not how you're supposed to run Snap packages, but it still works when the correct dependencies are installed.

Specifically, when invoked directly from their absolute paths, the commands in the OpenJDK Snap package require Linux kernel version 3.2.0 or later and GNU C library (GLIBC) version 2.27 or later. The following commands will show the current versions of the kernel and GLIBC on your system:

```console
$ uname -r
$ ldd --version
```

With the required kernel and C library, you can set the `JAVA_HOME` environment variable and launch the programs directly. On Debian-based systems, define:

```console
$ export JAVA_HOME=/snap/openjdk/current/jdk
```

On Fedora-based systems, define:

```console
$ export JAVA_HOME=/var/lib/snapd/snap/openjdk/current/jdk
```

You can then launch the programs directly from their installed locations:

```console
$ $JAVA_HOME/bin/java --version
openjdk 18.0.1 2022-04-19
OpenJDK Runtime Environment (build 18.0.1+10-snap)
OpenJDK 64-Bit Server VM (build 18.0.1+10-snap, mixed mode, sharing)
```

If your system has a version of the GNU C library older than 2.27, you'll see error messages similar to those shown below. On Ubuntu 16.04 LTS with GLIBC 2.23, for example, you'll see:

```console
$ $JAVA_HOME/bin/java --version
Error: dl failure on line 534
Error: failed /snap/openjdk/x1/jdk/lib/server/libjvm.so, because
    /lib/x86_64-linux-gnu/libm.so.6: version `GLIBC_2.27' not found
    (required by /snap/openjdk/x1/jdk/lib/server/libjvm.so)
```

In this case, either upgrade your Linux system to a more recent version, or invoke the JDK tools using their Snap package commands or aliases as follows:

```console
$ openjdk.java --version
openjdk 18.0.1 2022-04-19
OpenJDK Runtime Environment (build 18.0.1+10-snap)
OpenJDK 64-Bit Server VM (build 18.0.1+10-snap, mixed mode, sharing)
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

### Distributions

The following two sections compare the support for running the JDK programs self-contained or as a Java Platform on the Ubuntu and Fedora Linux distributions.

#### Ubuntu

The table below shows the Snap package support for recent releases of Ubuntu:

| Ubuntu    | End of Updates | C Library | Self-contained | Java Platform |
| --------- |:--------------:|:---------:|:--------------:|:-------------:|
| 16.04 LTS | 2021-04-30     | 2.23      | ✔ |   |
| 18.04 LTS | 2023-04-26     | 2.27      | ✔ | ✔ |
| 20.04 LTS | 2025-04-23     | 2.31      | ✔ | ✔ |
| 20.10     | 2021-07-22     | 2.32      | ✔ | ✔ |
| 21.04     | 2022-01-20     | 2.33      | ✔ | ✔ |
| 21.10     | 2022-07-14     | 2.34      | ✔ | ✔ |
| 22.04 LTS | 2027-04-21     | 2.34      | ✔ | ✔ |

#### Fedora

The table below shows the Snap package support for recent releases of Fedora:

| Fedora | End of Updates | C Library | Self-contained | Java Platform |
|:------:|:--------------:|:---------:|:--------------:|:-------------:|
| 24     | 2017-08-08     | 2.23      | ✔ |   |
| 25     | 2017-12-12     | 2.24      | ✔ |   |
| 26     | 2018-05-29     | 2.25      | ✔ |   |
| 27     | 2018-11-30     | 2.26      | ✔ |   |
| 28     | 2019-05-28     | 2.27      | ✔ | ✔ |
| 29     | 2019-11-26     | 2.28      | ✔ | ✔ |
| 30     | 2020-05-26     | 2.29      | ✔ | ✔ |
| 31     | 2020-11-24     | 2.30      | ✔ | ✔ |
| 32     | 2021-05-25     | 2.31      | ✔ | ✔ |
| 33     | 2021-11-30     | 2.32      | ✔ | ✔ |
| 34     | 2022-05-17     | 2.33      | ✔ | ✔ |
| 35     | 2022-12-07     | 2.34      | ✔ | ✔ |
| 36     | 2023-05-24     | 2.35      | ✔ | ✔ |

## Bootstrapping

Building the JDK requires that you already have a JDK for your target operating system and architecture. The JDK used to build the JDK is called the *Boot JDK*. Furthermore, the minimum version required for the Boot JDK is either the previous version or, for an early-access build, the most recently released version. This requirement presents a challenge when you're just getting started and want to build OpenJDK using only trusted sources.

The most trusted source of software for Debian-based distributions is the set of system package repositories. Snap packages have access to the repositories of either Ubuntu 18.04 LTS, using the `core18` base, or Ubuntu 20.04 LTS, using the `core20` base. When the initial Snap package was built, the current release was JDK 15 but the latest release of the Ubuntu OpenJDK package was JDK 11 for `core18` and JDK 14 for `core20`.

That gave me two options to create a chain of trusted builds for OpenJDK 15. The first option was to use the `core20` base with Ubuntu OpenJDK 14 as the initial Boot JDK:

**Option 1**
```
Ubuntu 20.04 LTS with GLIBC 2.31 (core20 base)
Ubuntu OpenJDK 14 (openjdk-14-jdk-headless)
    ↳ Snap OpenJDK 15 (openjdk/latest/candidate)
        ↳ Snap OpenJDK 16 (openjdk/latest/beta)
        ↳ Snap OpenJDK 17 (openjdk/latest/edge)
```

The second option was to use the `core18` base with Ubuntu OpenJDK 11 as the initial Boot JDK:

**Option 2**
```
Ubuntu 18.04 LTS with GLIBC 2.27 (core18 base)
Ubuntu OpenJDK 11 (openjdk-11-jdk-headless)
    ↳ Snap OpenJDK 12 (bootjdk/latest/candidate)
        ↳ Snap OpenJDK 13 (bootjdk/latest/beta)
            ↳ Snap OpenJDK 14 (bootjdk/latest/edge)
                ↳ Snap OpenJDK 15 (openjdk/latest/candidate)
                    ↳ Snap OpenJDK 16 (openjdk/latest/beta)
                    ↳ Snap OpenJDK 17 (openjdk/latest/edge)
```

I started this project using the first option, but now all of the Snap packages are built on the older Ubuntu 18.04 LTS release and were bootstrapped using the second option.

The problem with the first option is that the programs end up requiring very recent versions of the Linux kernel and GNU C library. Building on the `core20` base creates Snap packages that require GLIBC version 2.29 or later. Building on the `core18` base, on the other hand, lowers the GLIBC requirement to version 2.27. The lower requirement lets the package fully support older systems such as Ubuntu 18.04 LTS and Fedora 28.

For comparison, the following table shows the minimum kernel and C library versions for various builds of OpenJDK 15, including the initial OpenJDK 15 Snap package:

| OpenJDK 15 Build      | Linux Kernel | C Library |
| --------------------- | ------------ | --------- |
| AdoptOpenJDK          | 2.6.18       | 2.9       |
| BellSoft Liberica JDK | 2.6.18       | 2.9       |
| Oracle OpenJDK        | 2.6.18       | 2.9       |
| Snap OpenJDK          | 3.2.0        | 2.27      |

The Snap package still requires more recent versions of the kernel and C library compared to the other builds, but the situation should improve over time. If the package can remain on the `core18` base, eventually the world's C libraries will pass it by, as they have for the other builds. Meanwhile, you can always run the JDK programs on older systems using the self-contained package commands or aliases.

## Building

On Linux systems, you can build the Snap package directly by installing [Snapcraft](https://snapcraft.io/snapcraft) on your development workstation. The bottom of the Snapcraft page shows how to enable Snaps for your Linux distribution.

Whether you're running Windows, macOS, or Linux, you can use [Multipass](https://multipass.run) to build this project in an Ubuntu virtual machine (VM). For example, the following command will launch the Multipass [primary instance](https://multipass.run/docs/primary-instance) with 2 CPUs, 4 GiB of RAM, and Ubuntu 20.04 LTS (Focal Fossa):

```console
$ multipass launch --name primary --cpus 2 --mem 4G focal
```

The `snap/snapcraft.yaml` files on the *candidate*, *beta*, and *edge* branches define the build of the Snap package. Run the following commands to install Snapcraft, clone this repository, and start building the package:

```console
$ sudo snap install snapcraft
$ git clone https://github.com/jgneff/openjdk.git
$ cd openjdk
$ snapcraft
```

Snapcraft launches a new Multipass VM to ensure a clean and isolated build environment. The VM is named `snapcraft-openjdk` and runs Ubuntu 18.04 LTS (Bionic Beaver). The project's directory on the host system is mounted as `/root/project` in the guest VM, so any changes you make on the host are seen immediately in the guest, and vice versa.

**Note:** If you run the initial `snapcraft` command itself inside a VM, your system will need *nested VM* functionality. See the [Build Options](https://snapcraft.io/docs/build-options) page for alternatives, such as running a remote build or using an LXD container.

If the build fails, you can run the command again with the `--debug` (or `-d`) option to remain in the VM after the error:

```console
$ snapcraft -d
```

From within the VM, you can then clean the Snapcraft part and try again:

```console
# snapcraft clean jdk
Cleaning pull step (and all subsequent steps) for jdk
  ...
# snapcraft
  ...
Finished building targets 'images docs' in configuration 'linux-x86_64-server-release'
  ...
Snapping...
Snapped openjdk_18.0.1+10_amd64.snap
```

When the build completes, you'll find the Snap package in the project's root directory, along with the log file if you ran the build remotely.

## License and Trademarks

This project is licensed under the GNU General Public License v2.0 with the Classpath exception, the same license used by Oracle for the OpenJDK project. See the files [LICENSE](LICENSE) and [ADDITIONAL_LICENSE_INFO](ADDITIONAL_LICENSE_INFO) for details.

Java and OpenJDK are trademarks or registered trademarks of Oracle and/or its affiliates. See the file [TRADEMARK](TRADEMARK) for details.
