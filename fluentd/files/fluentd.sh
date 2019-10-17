#!/bin/bash

PIDFILE=/run/fluentd/fluentd.pid
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

start () {
    fluentd -c /etc/fluent/fluent.conf -d $PIDFILE
}

stop () {
    if [ -e $PIDFILE ]
    then
        /usr/bin/pkill -F $PIDFILE
    else
        echo 'FluentD is not running'
    fi
}

reload () {
    if [ -e $PIDFILE ]
    then
        /usr/bin/pkill -SIGHUP -F $PIDFILE
    else
        echo 'FluentD is not running'
    fi
}

case $1 in
    start)
        start
        ;;
    stop)
        stop
        ;;
    reload)
        reload
        ;;
    restart)
        stop
        sleep 1
        start
        ;;
    *) exit 1
esac
