## ![Duke, the Java mascot, with arms akimbo](images/icon.png) OpenJDK Snap

This project builds a [Snap package](https://snapcraft.io) of OpenJDK directly from its [GitHub repository](https://github.com/openjdk/jdk). OpenJDK is the official reference implementation of the Java Platform, Standard Edition, since version 7.

The resulting package provides everything you need to develop a Java application on Linux, including all of the latest development tools, class libraries, API documentation, and source code of the Java Development Kit (JDK).

### Installation

Install the OpenJDK Snap package with the command:

```console
$ sudo snap install openjdk
```

The Snap package is [strictly confined](https://snapcraft.io/docs/snap-confinement) and adds only two interfaces to its permissions:

* the [home interface](https://snapcraft.io/docs/home-interface) so that JDK tools like the Java compiler can read your Java source files and write Java class files under your home directory, and
* the [desktop interfaces](https://snapcraft.io/docs/desktop-interfaces) so that the `java` command can run Java desktop applications.

Its manifest file, `manifest.yaml`, lets you audit the build. The file's `build_url` key links to a page on Launchpad with more details, including the log from the [build machine](https://launchpad.net/builders) where it ran. The log file lets you verify that the package was built from source using only the software in [Ubuntu 20.04 LTS](https://cloud-images.ubuntu.com/focal/current/).

### Usage

The installed package includes the following directories:

* `/snap/openjdk/current/jvm` - Java Platform location
* `/snap/openjdk/current/jvm/docs` - Javadoc API documentation
* `/snap/openjdk/current/jvm/lib/src.zip` - Source file archive

You can use the OpenJDK Snap in two ways:

1. as a set of self-contained programs that include all of their dependencies, or
2. as the suite of software and documentation forming a complete Java Platform.

#### Self-contained

When you run the OpenJDK commands with the prefix `openjdk`, the programs use only the supporting libraries in the Snap package itself. The package defines the following commands for the corresponding JDK tools:

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
/var/snap/openjdk/common/openjdk.env
```

The file exports the `JAVA_HOME` environment variable and defines aliases for the JDK tools so that you can enter them without the package prefix:

```console
$ cat /var/snap/openjdk/common/openjdk.env
# Source this file for OpenJDK environment variables and aliases
export JAVA_HOME=/snap/openjdk/x1/jvm
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
JAVA_HOME=/snap/openjdk/x1/jvm
$ java -version
openjdk version "16" 2021-03-16
OpenJDK Runtime Environment (build 16+0-snap)
OpenJDK 64-Bit Server VM (build 16+0-snap, mixed mode, sharing)
```

#### Java Platform

Build automation tools and integrated development environments (IDEs) usually require the location of a Java Platform, often with a corresponding `JAVA_HOME` environment variable. These tools invoke the JDK programs directly using their absolute paths on your system.

When the commands are launched directly, they run outside of the container and in your system's environment like any normal program. In this case, the programs depend on having their supporting libraries installed on your system. You may already have the required dependencies, but if you encounter errors, simply install the most recent version of the Java Runtime Environment (JRE) that's available in your distribution's package repositories. On Ubuntu 20.04 LTS, for example, you can install the most recent JRE with:

```console
$ sudo apt install openjdk-14-jre
```

You can then set the `JAVA_HOME` environment variable and launch the programs directly from their installed locations:

```console
$ export JAVA_HOME=/snap/openjdk/current/jvm
$ $JAVA_HOME/bin/java -version
openjdk version "16" 2021-03-16
OpenJDK Runtime Environment (build 16+0-snap)
OpenJDK 64-Bit Server VM (build 16+0-snap, mixed mode, sharing)
```

### Contributing

Ultimately, I would like to see the latest OpenJDK available from the package repositories of all Linux distributions. Then on Ubuntu 20.04 LTS, for example, you could install it with the command:

```console
$ sudo apt install openjdk-15-jdk
```

Until that time, this Snap package can be a temporary solution by providing the latest OpenJDK on as many Linux distributions and architectures as possible. I welcome your help and support.

### Building

On Linux systems, you can build the Snap package directly by installing [Snapcraft](https://snapcraft.io/snapcraft) on your development workstation. The bottom of the Snapcraft page shows how to enable Snaps for your Linux distribution.

Whether you're running Windows, macOS, or Linux, you can use [Multipass](https://multipass.run) to build this project in an Ubuntu virtual machine (VM). For example, the following command will launch the Multipass [primary instance](https://multipass.run/docs/primary-instance) with 2 CPUs, 4 GiB of RAM, and Ubuntu 20.10 (Groovy Gorilla):

```console
$ multipass launch --name primary --cpus 2 --mem 4G groovy
```

The [snapcraft.yaml](snap/snapcraft.yaml) file defines the build of the Snap package. Run the following commands to install Snapcraft, clone this repository, and start building the package:

```console
$ sudo snap install snapcraft
$ git clone https://github.com/jgneff/openjdk.git
$ cd openjdk
$ snapcraft
```

Snapcraft launches a new Multipass VM to ensure a clean and isolated build environment. The VM is named `snapcraft-openjdk` and runs Ubuntu 20.04 LTS (Focal Fossa). The project's directory on the host system is mounted as `/root/project` in the guest VM, so any changes you make on the host are seen immediately in the guest, and vice versa.

**Note:** If you run the initial `snapcraft` command itself inside a VM, your system will need *nested VM* functionality. The [Build Options](https://snapcraft.io/docs/build-options) page lists alternatives, such as using an LXD container or running on a remote server using Launchpad.

If the build fails, you can run the command again with the `--debug` option to remain in the VM after the error:

```console
$ snapcraft -d
```

From within the VM, you can then clean the Snapcraft part and try again:

```console
# snapcraft clean jdk
Cleaning pull step (and all subsequent steps) for jdk
# snapcraft
  ...
Staging app
Staging jdk
Pulling del
Skipping build app (already ran)
Skipping build jdk (already ran)
Building del
Skipping stage app (already ran)
Skipping stage jdk (already ran)
Staging del
Priming app
Priming jdk
Priming del
Snapping
Snapped openjdk_16+27_amd64.snap
```

When the build completes, you'll find the Snap package in the project's root directory, along with the log file if you ran the build remotely.

### License and Trademarks

This project is licensed under the GNU General Public License v2.0 with the Classpath exception — the same license used by Oracle for the OpenJDK project. See the files [LICENSE](LICENSE) and [ADDITIONAL_LICENSE_INFO](ADDITIONAL_LICENSE_INFO) for details.

Java and OpenJDK are trademarks or registered trademarks of Oracle and/or its affiliates. See the [TRADEMARK](TRADEMARK) file for details.
