Official repository of the Bro Live! scripts.

Bro Live! is a Bro training system that is built upon [Jon Schipp](http://jonschipp.com)'s [Linux-based sandbox training system](https://github.com/jonschipp/islet).

# Installation

Must have at least Docker 1.2+ to run our [official Brolive Docker image](https://registry.hub.docker.com/u/broplatform/brolive/) because it requires adding extra capabilities(7)
to the container (NET_RAW).

If you're using a recent Ubuntu then the entire process is taken care of in the following example:
```shell
git clone https://github.com/jonschipp/islet
cd islet
make bro-training
```

## Manual

If you're not running Debian/Ubuntu then you will have to either
* Install latest Docker from source
* Install distribution's Docker package and build your own image

and then
```shell
git clone https://github.com/jonschipp/islet
cd islet
make install
make user-config
make security-config
```

If you're running Docker 1.2+ then use the following command to install the Brolive image with network capabilities for Bro.
```shell
cd islet
make install-brolive-config
```

# Exercises

Place exercises e.g. PCAP's, bro scripts, etc. in the /exercises directory on the host.
The /exercises directory is mounted read only in the container as /exercises and changes
to the files, or contents of the directory, are immediately available to all container users.

## Sample Exercises

To install the BroCon14 exercise set run the following command:
```shell
./sample-exercises.sh
```

# Administration

Referring you to the [documentation](https://github.com/jonschipp/islet/blob/master/README.md)

# Use

Give your students the host IP or domain to ssh to. Default password is demo.

```shell
ssh demo@islet.server.org
```

## Demo

Here's a brief demonstration:

```
        $ ssh demo@live.bro.org

        Welcome to Bro Live!
        ====================

            -----------
          /             \
         |  (   (0)   )  |
         |            // |
          \     <====// /
            -----------

        A place to try out Bro.

        Are you a new or existing user? [new/existing]: new

        A temporary account will be created so that you can resume your session. Account is valid for the length of the event.

        Choose a username [a-zA-Z0-9]: jon
        Your username is jon
        Choose a password:
        Verify your password:
        Your account will expire on Fri 29 Aug 2014 07:40:11 PM UTC

        Enjoy yourself!
        Training materials are located in /exercises.
        e.g. $ bro -r /exercises/beginner/http.pcap

        demo@bro:~$ pwd
        /home/demo
        demo@bro:~$ which bro
        /usr/local/bro/bin/bro
```

# BroLive! Image Usability Notes

* Bro is installed in /opt/bro
* /home/demo/exercises is a symlink to /exercises
* screen, tmux, gawk, nano, vim, and emacs are installed
* Bro helper shell functions are in the environment
* To use broctl, edit /opt/bro/etc/node.cfg with the correct interface. Probably lo since networking is disabled by default.
