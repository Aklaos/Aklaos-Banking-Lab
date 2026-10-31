const http = require('http');
const os = require('os');

const PORT = process.env.PORT || 3000;
const pod = process.env.POD_NAME || os.hostname();
const node = process.env.NODE_NAME || 'inconnu';
const ip = process.env.POD_IP || 'inconnue';
const version = process.env.APP_VERSION || '0.1';

// Teinte stable dérivée du nom du pod : chaque instance a sa couleur
let h = 0;
for (const c of pod) h = (h * 31 + c.charCodeAt(0)) % 360;

const page = `<!doctype html>
<html lang="fr">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Aklaos Banking</title>
<style>
  :root { --accent: hsl(${h} 70% 55%); }
  * { box-sizing: border-box; }
  body { margin: 0; min-height: 100vh; display: grid; place-items: center; font-family: system-ui, sans-serif;
         color: #e8ecf4; background: radial-gradient(circle at 20% 10%, #1b2440, #0b0f1a 60%); }
  main { width: min(92vw, 480px); }
  h1 { margin: 0 0 .25rem; font-size: 2rem; letter-spacing: .02em; }
  h1 span { color: var(--accent); }
  p.sub { margin: 0 0 1.5rem; color: #9aa6c0; }
  .card { background: #131a2b; border: 1px solid #26314d; border-top: 4px solid var(--accent);
          border-radius: 14px; padding: 1.25rem 1.5rem; box-shadow: 0 10px 30px #0006; }
  .badge { display: inline-block; padding: .2rem .7rem; border-radius: 999px; font-size: .8rem;
           background: var(--accent); color: #0b0f1a; font-weight: 700; margin-bottom: .75rem; }
  dl { margin: 0; display: grid; grid-template-columns: auto 1fr; gap: .5rem 1rem; }
  dt { color: #9aa6c0; }
  dd { margin: 0; font-family: ui-monospace, monospace; word-break: break-all; }
  footer { margin-top: 1rem; font-size: .8rem; color: #6b7794; text-align: center; }
</style>
</head>
<body>
<main>
  <h1>Aklaos <span>Banking</span></h1>
  <p class="sub">Votre banque, vue depuis le cluster.</p>
  <div class="card">
    <div class="badge">Instance servie</div>
    <dl>
      <dt>Pod</dt><dd>${pod}</dd>
      <dt>IP du pod</dt><dd>${ip}</dd>
      <dt>Nœud</dt><dd>${node}</dd>
      <dt>Version</dt><dd>${version}</dd>
    </dl>
  </div>
  <footer>Rechargez la page : une autre instance peut répondre.</footer>
</main>
</body>
</html>`;

http.createServer((req, res) => {
  if (req.url === '/healthz') {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    return res.end('ok');
  }
  res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8', 'Cache-Control': 'no-store' });
  res.end(page);
}).listen(PORT, () => console.log(`bankapp ${pod} écoute sur :${PORT}`));
