// Smoke UI Tiến Lên: mở Chrome headless vào bàn cùng 3 bot, chụp màn hình lobby/phòng chờ/bàn chơi.
// Cần: vite dev :5174, game server :8082, JWT_SECRET + TL_USERS (4 user: 3 bot + 1 browser).
import { spawn } from 'node:child_process';
import { mkdirSync, writeFileSync } from 'node:fs';
import crypto from 'node:crypto';
import WebSocket from 'ws';
import { io } from 'socket.io-client';

const SECRET = process.env.JWT_SECRET;
const USERS = JSON.parse(process.env.TL_USERS);
const OUT_DIR = process.env.TL_SHOT_DIR ?? '/tmp/thirteen-shots';
const CHROME = '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome';
const DEBUG_PORT = 9223;

const b64url = (buf) => Buffer.from(buf).toString('base64url');
function mintJwt(userId) {
  const header = b64url(JSON.stringify({ alg: 'HS256', typ: 'JWT' }));
  const now = Math.floor(Date.now() / 1000);
  const payload = b64url(JSON.stringify({ data: { id: userId }, exp: now + 3600, iat: now }));
  const sig = crypto.createHmac('sha256', SECRET).update(`${header}.${payload}`).digest('base64url');
  return `${header}.${payload}.${sig}`;
}

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

const botUsers = USERS.slice(0, 3);
const browserUser = USERS[3];
let roomId = null;
const bots = [];

function makeBot(user, idx) {
  const socket = io('http://localhost:8082', {
    auth: { token: mintJwt(user.id), gameId: 'thirteen', name: user.name },
    transports: ['websocket'],
  });
  const ctx = { socket, user, idx, ready: false, joined: false, matchId: null, you: -1 };
  bots.push(ctx);
  const send = (type, data) => socket.emit('message', { type, data });
  socket.on('message', ({ type, data }) => {
    if (type === 'ERROR' && data.code === 'ROOM_BUSY' && roomId && !ctx.joined && idx !== 0) {
      setTimeout(() => send('ROOM_JOIN', { roomId }), 300 + idx * 150);
      return;
    }
    if (type === 'ROOM_WAITING' && idx === 0 && !roomId) {
      roomId = data.roomId;
      console.log('bot room created:', roomId);
      bots.slice(1).forEach((other, i) => {
        setTimeout(() => other.socket.emit('message', { type: 'ROOM_JOIN', data: { roomId } }), 400 + i * 400);
      });
      return;
    }
    if (type === 'ROOM_STATE') {
      if (data.members.some((m) => m.id === user.id)) ctx.joined = true;
      if (idx !== 0 && !ctx.ready && ctx.joined) {
        ctx.ready = true;
        send('ROOM_READY', { roomId: data.roomId, ready: true });
      }
      if (idx === 0) {
        const guests = data.members.filter((m) => !m.owner);
        if (guests.length === 3 && guests.every((m) => m.ready)) {
          console.log('starting room with browser player...');
          send('ROOM_START', { roomId: data.roomId });
        }
      }
      return;
    }
    if (type === 'MATCH_FOUND') {
      ctx.matchId = data.matchId;
      ctx.you = data.you;
      if (data.turn === data.you && !data.state.instantWin) {
        setTimeout(() => send('MOVE', { matchId: ctx.matchId, move: pickMove(data.state) }), 400);
      }
      return;
    }
    if (type === 'STATE' && data.matchId === ctx.matchId && data.turn === ctx.you) {
      setTimeout(() => send('MOVE', { matchId: ctx.matchId, move: pickMove(data.state) }), 700);
    }
  });
  socket.on('connect', () => {
    if (idx === 0) {
      setTimeout(() => send('ROOM_CREATE', { bet: 0, password: '', maxPlayers: 4 }), 400);
      return;
    }
    const tryJoin = () => {
      if (ctx.joined) return;
      if (roomId) send('ROOM_JOIN', { roomId });
      setTimeout(tryJoin, 700 + idx * 250);
    };
    setTimeout(tryJoin, 500 + idx * 400);
  });
}

const rankOf = (c) => Math.floor(c / 4);
function pickMove(state) {
  const hand = [...state.yourHand].sort((a, b) => a - b);
  if (state.require3s) return { type: 'play', cards: [0] };
  const prevTop = state.table ? Math.max(...state.table.cards) : -1;
  const prevLen = state.table ? state.table.cards.length : 0;
  if (!state.table) return { type: 'play', cards: [hand[0]] };
  if (prevLen === 1) {
    const higher = hand.find((c) => c > prevTop);
    if (higher != null) return { type: 'play', cards: [higher] };
  }
  if (prevLen === 2) {
    const byRank = {};
    for (const c of hand) (byRank[rankOf(c)] ??= []).push(c);
    for (const cards of Object.values(byRank)) {
      if (cards.length >= 2 && cards[1] > prevTop) return { type: 'play', cards: cards.slice(0, 2) };
    }
  }
  return { type: 'pass' };
}

class Cdp {
  constructor(ws) {
    this.ws = ws;
    this.id = 0;
    this.pending = new Map();
    ws.on('message', (raw) => {
      const msg = JSON.parse(raw.toString());
      if (msg.id && this.pending.has(msg.id)) {
        this.pending.get(msg.id)(msg);
        this.pending.delete(msg.id);
      }
    });
  }
  send(method, params = {}) {
    const id = ++this.id;
    return new Promise((resolve) => {
      this.pending.set(id, resolve);
      this.ws.send(JSON.stringify({ id, method, params }));
    });
  }
  async eval(expression) {
    const res = await this.send('Runtime.evaluate', { expression, returnByValue: true, awaitPromise: true });
    return res.result?.result?.value;
  }
  async shot(name) {
    const res = await this.send('Page.captureScreenshot', { format: 'png' });
    writeFileSync(`${OUT_DIR}/${name}.png`, Buffer.from(res.result.data, 'base64'));
    console.log(`screenshot: ${OUT_DIR}/${name}.png`);
  }
}

async function main() {
  mkdirSync(OUT_DIR, { recursive: true });
  const url = `http://localhost:5174/thirteen/?token=${mintJwt(browserUser.id)}&name=${browserUser.name}`;
  const chrome = spawn(CHROME, [
    '--headless=new',
    `--remote-debugging-port=${DEBUG_PORT}`,
    '--window-size=520,920',
    '--user-data-dir=/tmp/thirteen-chrome-profile',
    '--no-first-run',
    url,
  ], { stdio: 'ignore' });
  process.on('exit', () => chrome.kill());

  await sleep(4000);
  const list = await fetch(`http://localhost:${DEBUG_PORT}/json/list`).then((r) => r.json());
  const page = list.find((t) => t.type === 'page' && t.url.includes('thirteen'));
  if (!page) throw new Error('page target not found');
  const cdp = new Cdp(new WebSocket(page.webSocketDebuggerUrl));
  await sleep(500);
  await cdp.send('Page.enable');
  await cdp.send('Runtime.enable');

  await sleep(2500);
  const phase1 = await cdp.eval(`document.querySelector('.tl-lobby') ? 'lobby' : document.body.className`);
  console.log('browser phase:', phase1);
  await cdp.shot('01-lobby');

  makeBot(botUsers[0], 0);
  await sleep(1500);
  makeBot(botUsers[1], 1);
  makeBot(botUsers[2], 2);
  await sleep(2500);

  const joined = await cdp.eval(`(() => {
    const rows = [...document.querySelectorAll('.tl-room-row')];
    const row = rows.find((r) => r.textContent.includes('${botUsers[0].name}'));
    if (!row) return 'room-row-not-found';
    const btn = row.querySelector('button.tl-btn-gold');
    if (!btn) return 'join-btn-not-found';
    btn.click();
    return 'clicked-join';
  })()`);
  console.log('join:', joined);
  await sleep(2000);
  await cdp.shot('02-room');
  const readyClicked = await cdp.eval(`(() => {
    const btn = [...document.querySelectorAll('.tl-room-actions button')].find((b) => b.textContent.trim() === 'Sẵn sàng');
    if (!btn) return 'ready-btn-not-found';
    btn.click();
    return 'clicked-ready';
  })()`);
  console.log('ready:', readyClicked);

  await sleep(6000);
  const tableInfo = await cdp.eval(`JSON.stringify({
    onTable: !!document.querySelector('.tl-table-screen'),
    handCards: document.querySelectorAll('.tl-hand-card').length,
    opponents: document.querySelectorAll('.tl-opponent').length,
  })`);
  console.log('table:', tableInfo);
  await cdp.shot('03-table-deal');

  await sleep(9000);
  await cdp.shot('04-table-midgame');

  const played = await cdp.eval(`(async () => {
    const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
    for (let attempt = 0; attempt < 60; attempt += 1) {
      const myTurn = !!document.querySelector('.tl-my-row .tl-turn-ring.active');
      if (myTurn) {
        const cards = [...document.querySelectorAll('.tl-hand-card')];
        const playBtn = [...document.querySelectorAll('.tl-action-bar button')].find((b) => b.textContent.trim() === 'Đánh');
        const passBtn = [...document.querySelectorAll('.tl-action-bar button')].find((b) => b.textContent.trim() === 'Bỏ lượt');
        for (const card of [...cards].reverse()) {
          card.click();
          await sleep(160);
          if (playBtn && !playBtn.disabled) {
            playBtn.click();
            return 'played-card';
          }
          card.click();
          await sleep(60);
        }
        if (passBtn && !passBtn.disabled) {
          passBtn.click();
          return 'passed';
        }
      }
      await sleep(600);
    }
    return 'never-my-turn';
  })()`);
  console.log('browser move:', played);
  await sleep(1500);
  await cdp.shot('05-after-my-move');
  const midInfo = await cdp.eval(`JSON.stringify({
    trickCards: document.querySelectorAll('.tl-trick-card').length,
    handCards: document.querySelectorAll('.tl-hand-card').length,
  })`);
  console.log('midgame:', midInfo);

  const finalInfo = JSON.parse(await cdp.eval(`JSON.stringify({
    onTable: !!document.querySelector('.tl-table-screen'),
    handCards: document.querySelectorAll('.tl-hand-card').length,
    opponents: document.querySelectorAll('.tl-opponent').length,
  })`) ?? '{}');
  const pass = finalInfo.onTable && finalInfo.handCards > 0 && finalInfo.opponents === 3 && played !== 'never-my-turn';
  console.log(pass ? 'UI_SMOKE_PASS' : 'UI_SMOKE_FAIL');
  chrome.kill();
  for (const b of bots) b.socket.disconnect();
  process.exit(pass ? 0 : 1);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
