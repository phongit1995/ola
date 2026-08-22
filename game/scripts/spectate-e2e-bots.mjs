import { io } from 'socket.io-client';
import crypto from 'node:crypto';

const SECRET = process.env.JWT_SECRET;
const USERS = JSON.parse(process.env.TL_USERS);
const SERVER = process.env.GAME_SERVER ?? 'http://localhost:8082';
const GAME_ID = 'caro';

if (!SECRET || !Array.isArray(USERS) || USERS.length < 3) {
  console.error('Need JWT_SECRET and TL_USERS (JSON array of >= 3 {id,name})');
  process.exit(2);
}

const b64url = (buf) => Buffer.from(buf).toString('base64url');
function mintJwt(userId) {
  const header = b64url(JSON.stringify({ alg: 'HS256', typ: 'JWT' }));
  const now = Math.floor(Date.now() / 1000);
  const payload = b64url(JSON.stringify({ data: { id: userId }, exp: now + 3600, iat: now }));
  const sig = crypto.createHmac('sha256', SECRET).update(`${header}.${payload}`).digest('base64url');
  return `${header}.${payload}.${sig}`;
}

const log = (...args) => console.log(new Date().toISOString().slice(11, 23), ...args);
const fail = (msg) => {
  console.error('FAIL:', msg);
  process.exitCode = 1;
};

function connect(user) {
  const socket = io(SERVER, {
    auth: { token: mintJwt(user.id), gameId: GAME_ID, name: user.name },
    transports: ['websocket'],
  });
  const send = (type, data) => socket.emit('message', { type, data });
  const waitFor = (type, timeoutMs = 8000, predicate = () => true) =>
    new Promise((resolve, reject) => {
      const timer = setTimeout(() => {
        socket.off('message', handler);
        reject(new Error(`${user.name}: timeout waiting ${type}`));
      }, timeoutMs);
      const handler = (msg) => {
        if (msg.type === type && predicate(msg.data)) {
          clearTimeout(timer);
          socket.off('message', handler);
          resolve(msg.data);
        }
      };
      socket.on('message', handler);
    });
  socket.on('message', ({ type, data }) => {
    if (type === 'ERROR') log(`${user.name} ERROR`, data.code, data.message);
  });
  return { socket, user, send, waitFor };
}

const [a, b, w] = USERS.slice(0, 3).map(connect);
await Promise.all([a, b, w].map((c) => c.waitFor('USER_INFO')));
log('all connected');

a.send('ROOM_CREATE', { bet: 0, password: '' });
const waiting = await a.waitFor('ROOM_WAITING');
log('room', waiting.roomId);
b.send('ROOM_JOIN', { roomId: waiting.roomId, password: '' });
await b.waitFor('ROOM_STATE');
b.send('ROOM_READY', { roomId: waiting.roomId, ready: true });
await a.waitFor('ROOM_STATE', 8000, (d) => d.members.every((m) => m.owner || m.ready));
a.send('ROOM_START', { roomId: waiting.roomId });
const [foundA, foundB] = await Promise.all([a.waitFor('MATCH_FOUND'), b.waitFor('MATCH_FOUND')]);
const matchId = foundA.matchId;
log('match', matchId);

w.send('SPECTATE_LIST');
const list = await w.waitFor('SPECTATE_LIST');
if (!list.matches.some((m) => m.matchId === matchId)) fail(`SPECTATE_LIST missing ${matchId}: ${JSON.stringify(list)}`);
else log('SPECTATE_LIST ok', list.matches.length);

w.send('SPECTATE_JOIN', { matchId });
const joined = await w.waitFor('SPECTATE_JOINED');
if (joined.matchId !== matchId || joined.players.length !== 2 || joined.spectators !== 1) {
  fail(`bad SPECTATE_JOINED ${JSON.stringify(joined)}`);
} else log('SPECTATE_JOINED ok, turn', joined.turn);

w.send('MOVE', { matchId, move: { x: 9, y: 9 } });
const moveErr = await w.waitFor('ERROR');
if (moveErr.code !== 'NO_MATCH') fail(`spectator MOVE expected NO_MATCH got ${moveErr.code}`);
else log('spectator MOVE rejected ok');

w.send('SPECTATE_JOIN', { matchId: 'does-not-exist' });
const switchErr = await w.waitFor('ERROR');
if (switchErr.code !== 'MATCH_NOT_FOUND') fail(`switch to missing match expected MATCH_NOT_FOUND got ${switchErr.code}`);
else log('failed switch keeps current match ok');

const players = [a, b];
const playerByIdx = (idx) => players.find((p) => p.user.id === foundA.players[idx].id);
let turn = foundA.turn;
let stateCount = 0;
const filler = [[10, 15], [11, 15], [12, 15], [13, 15]];
const winLine = [[2, 2], [3, 2], [4, 2], [5, 2], [6, 2]];
const firstIdx = turn;
for (let i = 0; i < 9; i++) {
  const mover = playerByIdx(turn);
  const isFirst = turn === firstIdx;
  const n = Math.floor(i / 2);
  const [x, y] = isFirst ? winLine[n] : filler[n];
  if (i === 8) {
    mover.send('MOVE', { matchId, move: { x, y } });
    break;
  }
  const expectState = w.waitFor('STATE', 8000, (d) => d.matchId === matchId);
  mover.send('MOVE', { matchId, move: { x, y } });
  const st = await expectState;
  stateCount++;
  turn = st.turn;
}
log('spectator received STATE x', stateCount);
if (stateCount !== 8) fail(`expected 8 STATE got ${stateCount}`);

const over = await w.waitFor('MATCH_OVER', 8000, (d) => d.matchId === matchId);
if (over.kenDelta !== 0 || (over.payout ?? 0) !== 0) fail(`spectator MATCH_OVER leaks money: ${JSON.stringify(over)}`);
else log('spectator MATCH_OVER ok winner', over.winnerId, over.reason);
const left = await w.waitFor('SPECTATE_LEFT');
if (left.reason !== 'match_over') fail(`expected SPECTATE_LEFT match_over got ${left.reason}`);
else log('SPECTATE_LEFT match_over ok');

for (const c of [a, b, w]) c.socket.disconnect();
log(process.exitCode ? 'DONE WITH FAILURES' : 'ALL OK');
