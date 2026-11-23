#!/bin/sh
# Starts the Godot dedicated server (restarted after a crash) and nginx in front of it on $PORT
# (Render sets PORT). nginx answers plain visits with a status line and passes WebSockets to Godot on 7777.
cd /app || exit 1
sed "s/__PORT__/${PORT:-10000}/" /app/nginx.conf > /tmp/nginx.conf
(
    while :; do
        echo "$(date -u '+%F %T') starting Kitties Mayhem server (bots $BOTS, frags $FRAGS, time $TIME)"
        ./KittiesMayhem.x86_64 --headless -- --server --port=7777 "--bots=$BOTS" "--frags=$FRAGS" "--time=$TIME"
        echo "$(date -u '+%F %T') server exited ($?); restarting in 5 s"
        sleep 5
    done
) &
exec nginx -c /tmp/nginx.conf -g 'daemon off;'
