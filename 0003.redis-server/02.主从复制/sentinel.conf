port 26379
dir ./
protected-mode no
daemonize no
pidfile ./sentinel.pid
logfile ./sentinel.log
# sentinel monitor mymaster 127.0.0.1 6379 2
# sentinel auth-pass mymaster 123456
sentinel down-after-milliseconds mymaster 30000
sentinel parallel-syncs mymaster 1
sentinel failover-timeout mymaster 180000
sentinel deny-scripts-reconfig yes
# sentinel notification-script mymaster ./notify.sh
# sentinel client-reconfig-script mymaster ./reconfig.sh