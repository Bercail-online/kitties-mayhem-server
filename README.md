# Kitties Mayhem dedicated server

The online deathmatch server of Kitties Mayhem (Nini's Adventures), a kitten FPS made with Godot 4.7.2.
Players join from the game's PLAY ONLINE screen at `wss://kitties.bercail.online`.

- `Dockerfile`: Debian slim; downloads the exported Linux build from this repo's release `server-1.1.0`.
- `start.sh`: runs the game with `--headless -- --server` (restarted after a crash) and nginx on `$PORT`.
- `nginx.conf`: plain visits get a status line; WebSockets go to the game on 127.0.0.1:7777.
- `render.yaml`: Render free web service (Docker).
- `worker/`: Cloudflare Worker for `kitties.bercail.online`. It passes players through to Render and pings
  the server every 10 minutes so the free instance never sleeps.

Deploy on Render: https://render.com/deploy?repo=https://github.com/Bercail-online/kitties-mayhem-server

New game build: upload the new `KittiesMayhem-linux.tar.gz` to a new release, change `BUILD_URL` in the
`Dockerfile`, push. Render rebuilds on its own. Old clients can only join a server with the same network protocol.
