'use strict';
// Serve the exported Cocos game, never the HTML implementation or workspace files.
const fs = require('node:fs');
const http = require('node:http');
const path = require('node:path');
const scene = 'Ola Farm';
const root = path.resolve(__dirname, '../build/farm-web-mobile');
const port = Number(process.env.COCOS_PORT || 4173);
if (!Number.isInteger(port) || port < 1024 || port > 65535) throw Error('COCOS_PORT must be 1024–65535');
if (!fs.existsSync(path.join(root, 'index.html'))) throw Error(`Build ${scene} Web Mobile first; see cocos/README.md`);
const types = { '.html':'text/html; charset=utf-8', '.js':'text/javascript', '.json':'application/json', '.css':'text/css', '.png':'image/png', '.wasm':'application/wasm', '.wav':'audio/wav', '.ttf':'font/ttf' };
const server = http.createServer((req, res) => {
  if (!['GET','HEAD'].includes(req.method)) {res.writeHead(405).end();return;}
  if (req.url === '/favicon.ico') {res.writeHead(204).end();return;}
  let file;
  try {file = path.resolve(root, '.' + decodeURIComponent(new URL(req.url, 'http://localhost').pathname));}
  catch {res.writeHead(400).end();return;}
  if (file === root) file = path.join(root, 'index.html');
  if (!file.startsWith(root + path.sep)) {res.writeHead(403).end();return;}
  fs.stat(file, (error, stat) => {
    if (error || !stat.isFile()) {res.writeHead(404).end();return;}
    res.writeHead(200, {'Content-Type':types[path.extname(file)] || 'application/octet-stream', 'Cache-Control':'no-cache'});
    if (req.method === 'HEAD') {res.end();return;}
    const stream = fs.createReadStream(file);stream.on('error', () => res.destroy());stream.pipe(res);
  });
});
server.on('error', error => {console.error(error.message);process.exitCode = 1;});
server.listen(port, '127.0.0.1', () => console.log(`${scene} Cocos: http://127.0.0.1:${port} (Ctrl+C to stop)`));
