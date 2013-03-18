#!/bin/bash
#set -x

HOST="sage"

AUTOSSH_PATH="/usr/bin/ssh"
export AUTOSSH_PATH

AUTOSSH_PIDFILE="/home/miam/bin/autossh.pid"
export AUTOSSH_PIDFILE

PIDFILE="$AUTOSSH_PIDFILE"
AUTOSSH_CMD="/usr/bin/autossh"

call_autossh ()
{
	"$AUTOSSH_CMD" -M 22023 -N -R 22022:localhost:22 -f "$HOST"	
}

self_check ()
{
	if [ -f "$PIDFILE" ]; then
		PID=`cat "$PIDFILE"`
		kill -0 $PID
		if [ $? -eq 1 ]; then
			return 1
		else
			return 0
		fi
	else
		return 1
	fi
}

self_check
if [ $? -eq 1 ]; then
	call_autossh
fi
