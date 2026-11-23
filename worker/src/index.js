// Kitties Mayhem: kitties.bercail.online -> the Render free web service.
// fetch: passes every request through, including the game's WebSocket upgrade.
// scheduled: pings the server every 10 minutes so the free Render instance never spins down
// (it sleeps after 15 minutes without inbound traffic, and the game gives up joining after 10 s).
export default {
	async fetch(request, env) {
		const url = new URL(request.url);
		url.protocol = "https:";
		url.hostname = env.RENDER_HOST;
		url.port = "";
		return fetch(new Request(url, request));
	},

	async scheduled(event, env, ctx) {
		ctx.waitUntil(
			fetch(`https://${env.RENDER_HOST}/`, { headers: { "user-agent": "kitties-keepalive" } })
				.then((r) => console.log(`keepalive ${r.status}`))
				.catch((e) => console.log(`keepalive failed: ${e}`)),
		);
	},
};
