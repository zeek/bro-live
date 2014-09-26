Official repository of the Bro Live! scripts.

Bro Live! is a Bro training system that is built upon [Jon Schipp](http://jonschipp.com)'s [Linux-based sandbox training scripts](https://github.com/jonschipp/zookeeper).

# Installation

Must have Docker 1.2.0 to run our [official Brolive Docker image](https://registry.hub.docker.com/u/broplatform/brolive/) because it requires adding extra capabilities(7)
to the container (NET_RAW, NET_ADMIN).

If you're using a recent Ubuntu then the entire process is taken care of in the following example:
```shell
git clone https://github.com/jonschipp/zookeeper
cd zookeeper
make install
make install-docker
make user-config
make security-config
make install-sample-config
```

## Manual

If you're not running Ubuntu then you will have to either
* Install Docker 1.2.0+ from source
* Install distribution's Docker package (presuming older than 1.2.0) and build your own image w/o extra capabilities(7) (see *dockerfiles/bro-sudo.conf*)

```shell
git clone https://github.com/jonschipp/zookeeper
cd zookeeper
make install
make user-config
make security-config
```

The following commands will install a Docker image configured with sudo for bro and broctl.
Use this image if you're using a version of Docker prior to 1.2.0
```shell
cp bro-live/dockerfiles/bro-sudo
cp bro-live/configs/bro-sudo.conf /etc/zookeeper/brolive.conf
docker build -t brolive - < bro-sudo
```

If you're running Docker 1.2.0+ then use the following command to install the Brolive image with network capabilities for Bro.
```shell
make install-sample-config
```

Alternatively,
```shell
docker pull broplatform/brolive
docker tag broplatform/brolive brolive
cp bro-live/configs/bro-cap.conf /etc/zookeeper/brolive.conf
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

Referring you to the [documentation](https://github.com/jonschipp/zookeeper/blob/master/README.md)

# Use

Give your students the host IP to ssh to. Default password is demo.

```shell
ssh demo@<ip>
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

* /usr/local/bro is a symlink to /home/demo/bro (owned by demo user)
* /home/demo/exercises is a symlink to /exercises 
* gawk, nano, vim, and emacs are installed
* To use broctl, edit /usr/local/bro/etc/node.cfg (/home/demo/bro/etc/node.cfg) with the correct interface. Probably lo since networking is disabled by default.
