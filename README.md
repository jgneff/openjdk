## ![Duke, the Java mascot, with arms akimbo](images/icon.png) OpenJDK Snap

**Update:** Now able to run as a Java Platform on older systems like Ubuntu 18.04 LTS and Fedora 28.

This project builds [Snap packages](https://snapcraft.io) of OpenJDK directly from its [GitHub repositories](https://github.com/openjdk). OpenJDK is the official reference implementation of the Java Platform, Standard Edition.

The resulting packages provide everything you need to develop a Java application on Linux, including all of the latest development tools, class libraries, API documentation, and source code of the Java Development Kit (JDK). Packages are available for the latest JDK 15 general-availability release and the JDK 16 and 17 early-access builds on each of following architectures:

| Release | amd64 | arm64 | armhf | i386 | ppc64el | s390x | Channel |
|:-------:|:-----:|:-----:|:-----:|:----:|:-------:|:-----:|:------- |
| JDK 15  | ✔️ | ✔️ | ✔️ | ✔️ | ✔️ | ✔️ | latest/candidate |
| JDK 16  | ✔️ | ✔️ | ✔️ | ✔️ | ✔️ | ✔️ | latest/beta |
| JDK 17  | ✔️ | ✔️ | ✔️ | ✔️ | ✔️ | ✔️ | latest/edge |

The OpenJDK 15 package will soon move to the *stable* channel once its packaging is unlikely to have any more major changes.

### Installation

Install the OpenJDK Snap package with the command:

```console
$ sudo snap install openjdk
```

The Snap package is [strictly confined](https://snapcraft.io/docs/snap-confinement) and adds only two interfaces to its permissions:

* the [home interface](https://snapcraft.io/docs/home-interface) so that JDK tools like the Java compiler can read your Java source files and write Java class files under your home directory, and
* the [desktop interfaces](https://snapcraft.io/docs/desktop-interfaces) so that the Java launcher can run Java desktop applications.

Its manifest file, `manifest.yaml`, lets you audit the build. The file's `build_url` key links to a page on Launchpad with more details, including the log from the [build machine](https://launchpad.net/builders) where it ran. The log file lets you verify that the package was built from source using only the software in [Ubuntu 18.04 LTS](https://cloud-images.ubuntu.com/bionic/current/).

### Usage

Once installed, the OpenJDK Snap package includes the following directories:

* `/snap/openjdk/current/jdk` - Java Platform location
* `/snap/openjdk/current/jdk/docs` - Javadoc API documentation
* `/snap/openjdk/current/jdk/lib/src.zip` - Source file archive

You can use the package in two ways:

1. as a set of self-contained programs that include all of their dependencies, or
2. as the suite of software and documentation forming a complete Java Platform.

These methods are explained in detail in the two sections that follow.

The first method should work on any Linux system, but the programs can access only non-hidden files owned by the user in the user's home directory. See the **Self-contained** section below for details.

The second method runs with traditional file permissions, but the programs require a system with Linux kernel version 3.2.0 or later and GNU C library version 2.27 or later. Those versions of the kernel and C library are found, for example, in Ubuntu 18.04 LTS, Fedora 28, or later releases. See the **Java Platform** section below for details.

#### Self-contained

When you run the OpenJDK commands with the prefix `openjdk`, the programs use only the supporting libraries contained in the Snap package. The package defines the following commands for each of the corresponding JDK tools:

- openjdk.java
- openjdk.javac
- openjdk.javadoc
- openjdk.jar
- openjdk.jarsigner
- openjdk.jlink
- openjdk.jpackage

The `openjdk` command itself prints the location of a file that defines environment variables and aliases which make it more convenient to use the OpenJDK Snap package:

```console
$ openjdk
/snap/openjdk/x1/bin/openjdk.env
```

The file exports the `JAVA_HOME` environment variable and defines aliases for the JDK tools so that you can enter them without the package prefix:

```console
$ cat $(openjdk)
# Source this file for OpenJDK environment variables and aliases
export JAVA_HOME=/snap/openjdk/current/jdk
alias java='openjdk.java'
alias javac='openjdk.javac'
alias javadoc='openjdk.javadoc'
alias jar='openjdk.jar'
alias jarsigner='openjdk.jarsigner'
alias jlink='openjdk.jlink'
alias jpackage='openjdk.jpackage'
```

To set the `JAVA_HOME` environment variable and aliases in your current shell, use the `source` or "dot" (`.`) command to read and execute the commands from the file:

```console
$ . $(openjdk)
```

You can then verify that `JAVA_HOME` and the aliases are defined with:

```console
$ printenv | grep JAVA
JAVA_HOME=/snap/openjdk/current/jdk
$ type java javac
java is aliased to `openjdk.java'
javac is aliased to `openjdk.javac'
$ java --version
openjdk 15.0.1 2020-10-20
OpenJDK Runtime Environment (build 15.0.1+9-snap)
OpenJDK 64-Bit Server VM (build 15.0.1+9-snap, mixed mode, sharing)
```

If you refer to locations outside of your home directory in the arguments to the Snap package commands or aliases, such as the JavaFX SDK directory below, you'll see an *Access Denied* error message:

```console
$ java -p /snap/openjfx/current/sdk/lib \
    --add-modules javafx.controls -jar dist/hello-javafx-1.0.0.jar
Error occurred during initialization of boot layer
java.lang.module.FindException: java.nio.file.AccessDeniedException:
    /snap/openjfx/current/sdk/lib
Caused by: java.nio.file.AccessDeniedException: /snap/openjfx/current/sdk/lib
```

In this case, either copy the external libraries into your home directory for access, or invoke the JDK tools directly from their Java Platform location as follows:

```console
$ $JAVA_HOME/bin/java -p /snap/openjfx/current/sdk/lib \
    --add-modules javafx.controls -jar dist/hello-javafx-1.0.0.jar
Hello World!
```

#### Java Platform

Build automation tools and integrated development environments (IDEs) usually require the location of a Java Platform, often with a corresponding `JAVA_HOME` environment variable. These tools invoke the JDK programs directly using their absolute paths on your system.

When the programs are launched directly, they run outside of their container and in your system's environment like any normal program. In this case, the programs depend on having their supporting libraries installed on your system. In particular, the Snap package build of OpenJDK requires Linux kernel version 3.2.0 or later and GNU C library (GLIBC) version 2.27 or later.

The commands below show the current Linux kernel and GLIBC versions on Ubuntu 20.04 LTS:

```console
$ uname -r
5.8.0-36-generic
$ ldd --version
ldd (Ubuntu GLIBC 2.31-0ubuntu9.1) 2.31
  ...
```

With the required kernel and C library, you can set the `JAVA_HOME` environment variable and launch the programs directly from their installed locations:

```console
$ export JAVA_HOME=/snap/openjdk/current/jdk
$ $JAVA_HOME/bin/java --version
openjdk 15.0.1 2020-10-20
OpenJDK Runtime Environment (build 15.0.1+9-snap)
OpenJDK 64-Bit Server VM (build 15.0.1+9-snap, mixed mode, sharing)
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
openjdk 15.0.1 2020-10-20
OpenJDK Runtime Environment (build 15.0.1+9-snap)
OpenJDK 64-Bit Server VM (build 15.0.1+9-snap, mixed mode, sharing)
```

Most desktop installations will already have the libraries required by the JDK tools, but the `jlink` and `jpackage` programs require two additional packages when they run outside of the Snap package container. They need the `objcopy` program from the `binutils` package to create the custom runtime image, and `jpackage` needs the `fakeroot` package to create a Debian package.

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

The following two sections compare the systems supported when running the JDK programs self-contained or as a Java Platform.

##### Ubuntu

The table below shows the Snap package support for recent releases of Ubuntu:

| Ubuntu | GNU C Library | Self-contained | Java Platform | End of Updates |
|:------:|:-------------:|:--------------:|:-------------:|:--------------:|
| 16.04 LTS | 2.23 | ✔️ |   | April 2021 |
| 18.04 LTS | 2.27 | ✔️ | ✔️ | April 2023 |
| 20.04 LTS | 2.31 | ✔️ | ✔️ | April 2025 |
| 20.10     | 2.32 | ✔️ | ✔️ | July 2021  |

##### Fedora

The table below shows the same information for the Fedora distribution:

| Fedora | GNU C Library | Self-contained | Java Platform | End of Updates |
|:------:|:-------------:|:--------------:|:-------------:|:--------------:|
| 24 | 2.23 | ✔️ |   | 2017-08-08 |
| 25 | 2.24 | ✔️ |   | 2017-12-12 |
| 26 | 2.25 | ✔️ |   | 2018-05-29 |
| 27 | 2.26 | ✔️ |   | 2018-11-30 |
| 28 | 2.27 | ✔️ | ✔️ | 2019-05-28 |
| 29 | 2.28 | ✔️ | ✔️ | 2019-11-26 |
| 30 | 2.29 | ✔️ | ✔️ | 2020-05-26 |
| 31 | 2.30 | ✔️ | ✔️ | 2020-11-24 |
| 32 | 2.31 | ✔️ | ✔️ | 2021-05-18 |
| 33 | 2.32 | ✔️ | ✔️ | Current    |

### Contributing

Ultimately, I would like to see the latest OpenJDK available from the package repositories of all Linux distributions. Then on Ubuntu 20.04 LTS, for example, you could install it with the command:

```console
$ sudo apt install openjdk-15-jdk
```

Until that time, this Snap package can be a temporary solution by providing the latest OpenJDK on as many Linux distributions and architectures as possible. I welcome your help and support.

### Bootstrapping

Building the JDK requires that you already have a JDK for your target operating system and architecture. The JDK used to build the JDK is called the *Boot JDK*. Furthermore, the minimum version required for the Boot JDK is either the previous version, or for an early-access build, the most recently released version. This presents a challenge when you're just getting started and want to build OpenJDK using only trusted sources.

The most trusted source of software for Debian-based distributions is the set of system package repositories. Snap packages have access to the repositories of either Ubuntu 18.04 LTS, using the `core18` base, or Ubuntu 20.04 LTS, using the `core20` base. The latest release of the Ubuntu OpenJDK package is JDK 11 for `core18` and JDK 14 for `core20`.

That gives us two options to create a chain of trusted builds that reaches the current OpenJDK 15 release. The first option is to use the `core20` base with Ubuntu OpenJDK 14 as the initial Boot JDK:

```
Ubuntu 20.04 LTS with GLIBC 2.31 (core20 base)
Ubuntu OpenJDK 14 (openjdk-14-jdk-headless)
    ↳ Snap OpenJDK 15 (openjdk/latest/candidate → stable)
        ↳ Snap OpenJDK 16 (openjdk/latest/beta)
        ↳ Snap OpenJDK 17 (openjdk/latest/edge)
```

The second option is to use the `core18` base with Ubuntu OpenJDK 11 as the initial Boot JDK:

```
Ubuntu 18.04 LTS with GLIBC 2.27 (core18 base)
Ubuntu OpenJDK 11 (openjdk-11-jdk-headless)
    ↳ Snap OpenJDK 12 (bootjdk/latest/candidate)
        ↳ Snap OpenJDK 13 (bootjdk/latest/beta)
            ↳ Snap OpenJDK 14 (bootjdk/latest/edge)
                ↳ Snap OpenJDK 15 (openjdk/latest/candidate → stable)
                    ↳ Snap OpenJDK 16 (openjdk/latest/beta)
                    ↳ Snap OpenJDK 17 (openjdk/latest/edge)
```

I started this project using the first option. The problem with building on such a recent release, though, is that the programs being built end up requiring recent versions of the Linux kernel and GNU C library. Building on the `core20` base creates a Snap package that requires GLIBC version 2.29 or later. Building on the `core18` base, on the other hand, reduces the requirement to GLIBC version 2.27. The lower GLIBC requirement lets the package fully support older systems such as Ubuntu 18.04 and Fedora 28.

The following table shows the minimum kernel and C library versions for various builds of OpenJDK 15, including this Snap package:

| OpenJDK 15 Build | Linux Kernel | GNU C Library |
| ---------------- |:------------:|:-------------:|
| AdoptOpenJDK          | 2.6.18    | 2.9      |
| BellSoft Liberica JDK | 2.6.18    | 2.9      |
| Oracle OpenJDK        | 2.6.18    | 2.9      |
| **Snap Package**      | **3.2.0** | **2.27** |
| Ubuntu 20.10 LTS      | 3.2.0     | 2.32     |

The Snap package still requires relatively recent versions, but the situation should improve over time. If the package can remain on the `core18` base, eventually the world's C libraries will pass it by, as they have for the other builds. Meanwhile, you can always run the JDK programs on older systems using the self-contained package commands or aliases.

### Building

On Linux systems, you can build the Snap package directly by installing [Snapcraft](https://snapcraft.io/snapcraft) on your development workstation. The bottom of the Snapcraft page shows how to enable Snaps for your Linux distribution.

Whether you're running Windows, macOS, or Linux, you can use [Multipass](https://multipass.run) to build this project in an Ubuntu virtual machine (VM). For example, the following command will launch the Multipass [primary instance](https://multipass.run/docs/primary-instance) with 2 CPUs, 4 GiB of RAM, and Ubuntu 20.10 (Groovy Gorilla):

```console
$ multipass launch --name primary --cpus 2 --mem 4G groovy
```

The `snap/snapcraft.yaml` files on the *candidate*, *beta*, and *edge* branches define the build of the Snap package. Run the following commands to install Snapcraft, clone this repository, switch to the *candidate* branch, and start building the package:

```console
$ sudo snap install snapcraft
$ git clone https://github.com/jgneff/openjdk.git
$ cd openjdk
$ git switch candidate
$ snapcraft
```

Snapcraft launches a new Multipass VM to ensure a clean and isolated build environment. The VM is named `snapcraft-openjdk` and runs Ubuntu 18.04 LTS (Bionic Beaver). The project's directory on the host system is mounted as `/root/project` in the guest VM, so any changes you make on the host are seen immediately in the guest, and vice versa.

**Note:** If you run the initial `snapcraft` command itself inside a VM, your system will need *nested VM* functionality. See the [Build Options](https://snapcraft.io/docs/build-options) page for alternatives, such as running a remote build or using an LXD container.

If the build fails, you can run the command again with the `--debug` option to remain in the VM after the error:

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
Priming bin
Priming jdk
Priming del
  ...
Snapping...
Snapped openjdk_15.0.1+9_amd64.snap
```

When the build completes, you'll find the Snap package in the project's root directory, along with the log file if you ran the build remotely.

### License and Trademarks

This project is licensed under the GNU General Public License v2.0 with the Classpath exception, the same license used by Oracle for the OpenJDK project. See the files [LICENSE](LICENSE) and [ADDITIONAL_LICENSE_INFO](ADDITIONAL_LICENSE_INFO) for details.

Java and OpenJDK are trademarks or registered trademarks of Oracle and/or its affiliates. See the file [TRADEMARK](TRADEMARK) for details.
