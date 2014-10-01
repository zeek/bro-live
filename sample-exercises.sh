#!/bin/bash
# Author: Jon Schipp <jonschipp@gmail.com>

## Variables
HOME=/root

# Installation notification
COWSAY=/usr/games/cowsay
IRCSAY=/usr/local/bin/ircsay
IRC_CHAN="#replace_me"
HOST=$(hostname -s)
EMAIL=user@company.com

# Must run as root
if [ $UID -ne 0 ]; then
	echo "Script must be run as root user, exiting..."a
	exit 1
fi

cd $HOME

function die {
    if [ -f ${COWSAY:-none} ]; then
        $COWSAY -d "$*"
    else
        echo "$*"
    fi
    if [ -f $IRCSAY ]; then
        ( set +e; $IRCSAY "$IRC_CHAN" "$*" 2>/dev/null || true )
    fi
    echo "$*" | mail -s "[vagrant] Bro Sandbox install information on $HOST" $EMAIL
    exit 1
}

function hi {
    if [ -f ${COWSAY:-none} ]; then
        $COWSAY "$*"
    else
        echo "$*"
    fi
    if [ -f $IRCSAY ]; then
        ( set +e; $IRCSAY "$IRC_CHAN" "$*" 2>/dev/null || true )
    fi
    echo "$*" | mail -s "[vagrant] Bro Sandbox install information on $HOST" $EMAIL
}

function logo {
cat <<"EOF"
===========================================

		Bro
	    -----------
	  /             \
	 |  (   (0)   )  |
	 |            // |
	  \     <====// /
	    -----------

	Web: http://bro.org

===========================================

EOF
}

sample_exercises() {
local DIR=/exercises
echo -e "Installing sample exercises!\n"
if [ ! -d $DIR ]; then
	mkdir /exercises
fi

cd $DIR

url="http://www.bro.org/static/BroCon14/BroCon14.tar.gz"
if [ ! -d $DIR/BroCon14 ]
then
	wget $url 2>/dev/null
	if [ $? -ne 0 ]; then
		echo "$COUNT - Download for $url failed!"
	else
		echo "$COUNT - Success! for $url"
	fi
	tar zxf BroCon14.tar.gz
	rm -f BroCon14.tar.gz
fi
}

logo

sample_exercises "1.)"
