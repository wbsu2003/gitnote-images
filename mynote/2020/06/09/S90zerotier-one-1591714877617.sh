#! /bin/sh

case "$1" in
  start)
       if lsmod | grep -q tun ;
       then echo "mod tun ready" ;
       else
               modprobe tun;
               logger -t "zerotier" -c "modprobe tun started, zerotier-one should start in one minute" -p user.notice ;
       exit 0;
       fi
    if ( pidof zerotier-one )
    then echo "ZeroTier-One is already running."
    else
        echo "Starting ZeroTier-One" ;
        /opt/bin/zerotier-one -d ;
        echo "$(date) Started ZeroTier-One" >> /opt/var/log/zerotier-one.log ;
    fi
    ;;
  stop)
    if ( pidof zerotier-one )
    then
        echo "Stopping ZeroTier-One";
        killall zerotier-one
        echo "$(date) Stopped ZeroTier-One" >> /opt/var/log/zerotier-one.log
    else
        echo "ZeroTier-One was not running" ;
    fi
    ;;
  status)
    if ( pidof zerotier-one )
    then echo "ZeroTier-One is running."
    else echo "ZeroTier-One is NOT running"
    fi
    ;;
  *)
    echo "Usage: /etc/init.d/zerotier-one {start|stop|status}"
    exit 1
    ;;
esac

exit 0