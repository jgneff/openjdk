## ![Duke, the Java mascot, with arms akimbo](images/icon.png) OpenJDK Snap

This project builds a [Snap package](https://snapcraft.io) of OpenJDK directly from its [official repository](https://github.com/openjdk/jdk). The resulting package provides everything you need to develop a Java application on Linux, including all of the latest development tools, class libraries, API documentation, and source code of the Java Development Kit (JDK). OpenJDK is the official reference implementation of the Java Platform, Standard Edition, since version 7.

### Installation

Install the OpenJDK Snap package with the command:

```console
$ sudo snap install openjdk
```

The Snap package is [strictly confined](https://snapcraft.io/docs/snap-confinement) and adds only the [home interface](https://snapcraft.io/docs/home-interface) to its permissions. Its manifest file, `manifest.yaml`, lets you audit the build. The file's `build_url` key links to a page on Launchpad with more details, including the log from the [build machine](https://launchpad.net/builders) where it ran. The log file lets you verify that the package was built from source using only the software in [Ubuntu 20.04 LTS](https://cloud-images.ubuntu.com/focal/current/).

You can fully confine the Snap by removing its *home* interface with the command:

```console
$ sudo snap disconnect openjdk:home :home
```

However, without the *home* interface, the OpenJDK Snap has access to only the files you place in the *user data* directories under `$HOME/snap/openjdk`. In this case, you should put your Java source code under the directory for user data that is common across revisions of the package:

```
$HOME/snap/openjdk/common
```

**Note:** The documentation on [Snapshots](https://snapcraft.io/docs/snapshots) states, "a snapshot is generated automatically when a snap is removed. These snapshots are retained for 31 days before being deleted automatically." Therefore, consider making your own backup copy of any files you put in the OpenJDK `common` user data directory before removing the Snap package.

### Usage

The installed package includes the following directories:

* `/snap/openjdk/current/jvm` - Java Platform location
* `/snap/openjdk/current/jvm/docs` - Javadoc API documentation
* `/snap/openjdk/current/jvm/lib/src.zip` - Source file archive

You can use the OpenJDK Snap in two ways:

1. as a set of self-contained programs that require no additional dependencies from your system, or
2. as the collection of development tools, class libraries, API documentation, and source code that represent a Java Platform.

#### Self-contained

When you run the OpenJDK commands with the prefix `openjdk`, the programs use only the supporting libraries in the Snap package itself. The package defines the following commands for the JDK tools:

- openjdk.java
- openjdk.javac
- openjdk.javadoc
- openjdk.jar
- openjdk.jlink
- openjdk.jpackage

For example, you can use the `openjdk` prefix when running the commands manually from the Terminal or invoking them from a Makefile:

```console
$ openjdk.java -version
NOTE: Picked up JDK_JAVA_OPTIONS: -Duser.home=/home/john/snap/openjdk/common
openjdk version "15.0.1" 2020-10-20
OpenJDK Runtime Environment (build 15.0.1+0-snap)
OpenJDK 64-Bit Server VM (build 15.0.1+0-snap, mixed mode, sharing)
```

#### Java Platform

Build automation tools and integrated development environments (IDEs) usually require the location of a Java Platform, often with a corresponding `JAVA_HOME` environment variable. These tools invoke the commands in OpenJDK directly without the `openjdk` prefix.

When the commands are launched directly, they run outside of the container and in your system's environment like any normal program. In this case, the programs depend on having their supporting libraries installed on your system. You can provide the dependencies by installing a recent version of the Java Runtime Environment (JRE) from your distribution's package repositories:

```console
$ sudo apt install openjdk-14-jre
```

You can then launch the programs directly from their installed location:

```console
$ /snap/openjdk/current/jvm/bin/java -version
openjdk version "15.0.1" 2020-10-20
OpenJDK Runtime Environment (build 15.0.1+0-snap)
OpenJDK 64-Bit Server VM (build 15.0.1+0-snap, mixed mode, sharing)
```

The `openjdk` command prints the location of the Java Platform as an `export` of the `JAVA_HOME` variable:

```console
$ openjdk
export JAVA_HOME=/snap/openjdk/x1/jvm
```

To export the environment variable in your current shell, run the Bash `eval` command on the output of the `openjdk` command:

```console
$ eval $(openjdk)
```

You can then verify that the variable is defined with:

```console
$ printenv | grep JAVA
JAVA_HOME=/snap/openjdk/x1/jvm
$ $JAVA_HOME/bin/java -version
openjdk version "15.0.1" 2020-10-20
OpenJDK Runtime Environment (build 15.0.1+0-snap)
OpenJDK 64-Bit Server VM (build 15.0.1+0-snap, mixed mode, sharing)
```

### Contributing

Ultimately, I would like to see the latest OpenJDK available from the package repositories of all Linux distributions. Then on Ubuntu 20.04 LTS, for example, you could install it with the command:

```console
$ sudo apt install openjdk-15-jdk
```

Until that time, this Snap package can be a temporary solution by providing the latest OpenJDK on as many Linux distributions and architectures as possible.

If you share in these goals, I welcome your help and support.

### Building

Whether you're running Windows, macOS, or Linux, you can use [Multipass](https://multipass.run) to build this project in an Ubuntu virtual machine (VM). For example, the following command will launch the Multipass [primary instance](https://multipass.run/docs/primary-instance) with 2 CPUs, 4 GiB of RAM, and Ubuntu 20.10 (Groovy Gorilla):

```console
$ multipass launch --name primary --cpus 2 --mem 4G groovy
```

The [snapcraft.yaml](snap/snapcraft.yaml) file defines the build of the Snap package. Run the following commands to install Snapcraft and start building the package:

```console
$ sudo snap install snapcraft
$ snapcraft
```

Snapcraft launches a new Multipass VM to ensure a clean and isolated build environment. The VM is named `snapcraft-openjdk` and runs Ubuntu 20.04 LTS (Focal Fossa). The project's directory on the host system is mounted as `/root/project` in the guest VM, so any changes you make on the host are seen immediately in the guest, and vice versa.

**Note:** If you run the initial `snapcraft` command itself inside a VM, your system will need *nested VM* functionality. In that case, see the [Build Options](https://snapcraft.io/docs/build-options) for alternatives, such as using an LXD container or running on a remote server using Launchpad.

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
Priming app
Priming jdk
Snapping
Snapped openjdk_15.0.1_amd64.snap
```

When the build completes, you'll find the Snap package in the project's root directory, along with the log file if you ran the build remotely.

### License

This project is licensed under the GNU General Public License v2.0 with the Classpath exception — the same license used by Oracle for the OpenJDK project.
