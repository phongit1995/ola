import { io } from 'socket.io-client';
import crypto from 'node:crypto';

const SECRET = process.env.JWT_SECRET;
const USERS = JSON.parse(process.env.TL_USERS);
const SERVER = 'http://localhost:8082';

const b64url = (buf) => Buffer.from(buf).toString('base64url');
function mintJwt(userId) {
  const header = b64url(JSON.stringify({ alg: 'HS256', typ: 'JWT' }));
  const now = Math.floor(Date.now() / 1000);
  const payload = b64url(JSON.stringify({ data: { id: userId }, exp: now + 3600, iat: now }));
  const sig = crypto.createHmac('sha256', SECRET).update(`${header}.${payload}`).digest('base64url');
  return `${header}.${payload}.${sig}`;
}

const rankOf = (c) => Math.floor(c / 4);
function detect(cards) {
  const s = [...cards].sort((a, b) => a - b);
  const n = s.length;
  if (n === 0) return null;
  const sameRank = s.every((c) => rankOf(c) === rankOf(s[0]));
  if (sameRank && n <= 4) return { kind: ['single', 'pair', 'triple', 'quad'][n - 1], length: n, key: s[n - 1] };
  const straight = n >= 3 && s.every((c, i) => rankOf(c) !== 12 && (i === 0 || rankOf(c) === rankOf(s[i - 1]) + 1));
  if (straight) return { kind: 'straight', length: n, key: s[n - 1] };
  return null;
}
function beats(next, prev) {
  if (!prev) return true;
  if (next.kind === prev.kind && next.length === prev.length) return next.key > prev.key;
  if (prev.kind === 'single' && rankOf(prev.key) === 12) return next.kind === 'quad';
  return false;
}
function pickMove(state) {
  const hand = [...state.yourHand].sort((a, b) => a - b);
  const prev = state.table ? detect(state.table.cards) : null;
  if (state.require3s) {
    return { type: 'play', cards: [0] };
  }
  for (const c of hand) {
    const combo = detect([c]);
    if (combo && beats(combo, prev)) return { type: 'play', cards: [c] };
  }
  const byRank = {};
  for (const c of hand) (byRank[rankOf(c)] ??= []).push(c);
  for (const cards of Object.values(byRank)) {
    for (const len of [2, 3, 4]) {
      if (cards.length >= len) {
        const combo = detect(cards.slice(0, len));
        if (combo && beats(combo, prev)) return { type: 'play', cards: cards.slice(0, len) };
      }
    }
  }
  if (!prev) return { type: 'play', cards: [hand[0]] };
  return { type: 'pass' };
}

const results = { matchOver: null, errors: [], leaks: [], stateCount: 0 };
let roomId = null;
const clients = [];

function makeClient(user, idx) {
  const socket = io(SERVER, {
    auth: { token: mintJwt(user.id), gameId: 'thirteen', name: user.name },
    transports: ['websocket'],
  });
  const ctx = { socket, user, idx, matchId: null, you: -1, ready: false, joined: false };
  clients.push(ctx);

  const send = (type, data) => socket.emit('message', { type, data });

  socket.on('message', ({ type, data }) => {
    if (type === 'ERROR') {
      if (data.code === 'ROOM_BUSY' && roomId && !ctx.joined && idx !== 0) {
        setTimeout(() => send('ROOM_JOIN', { roomId }), 250 + idx * 150);
        return;
      }
      results.errors.push(`${user.name}: ${data.code} ${data.message}`);
      return;
    }
    if (type === 'ROOM_WAITING' && idx === 0 && !roomId) {
      roomId = data.roomId;
      console.log(`room created: ${roomId} maxPlayers=${data.maxPlayers}`);
      clients.slice(1).forEach((other, i) => {
        setTimeout(() => other.socket.emit('message', { type: 'ROOM_JOIN', data: { roomId } }), i * 350);
      });
      return;
    }
    if (type === 'ROOM_STATE') {
      if (data.members.some((m) => m.id === user.id)) ctx.joined = true;
      if (idx !== 0 && !ctx.ready && data.members.some((m) => m.id === user.id)) {
        ctx.ready = true;
        send('ROOM_READY', { roomId: data.roomId, ready: true });
      }
      if (idx === 0) {
        const guests = data.members.filter((m) => !m.owner);
        if (guests.length === 3 && guests.every((m) => m.ready)) {
          console.log('all ready, starting...');
          send('ROOM_START', { roomId: data.roomId });
        }
      }
      return;
    }
    if (type === 'MATCH_FOUND') {
      ctx.matchId = data.matchId;
      ctx.you = data.you;
      const state = data.state;
      if (state.hands) results.leaks.push(`${user.name}: MATCH_FOUND leaks hands`);
      if (!Array.isArray(state.yourHand) || state.yourHand.length !== 13) {
        results.errors.push(`${user.name}: bad yourHand`);
      }
      if (state.instantWin) console.log(`instant win: ${state.instantWin}`);
      if (data.turn === data.you && !state.instantWin) {
        setTimeout(() => send('MOVE', { matchId: ctx.matchId, move: pickMove(state) }), 100);
      }
      return;
    }
    if (type === 'STATE') {
      results.stateCount += 1;
      const state = data.state;
      if (state.hands) results.leaks.push(`${user.name}: STATE leaks hands`);
      if (data.matchId === ctx.matchId && data.turn === ctx.you) {
        setTimeout(() => send('MOVE', { matchId: ctx.matchId, move: pickMove(state) }), 60);
      }
      return;
    }
    if (type === 'MATCH_OVER' && !results.matchOver) {
      results.matchOver = data;
      console.log('MATCH_OVER:', JSON.stringify({ winnerId: data.winnerId, reason: data.reason, rankings: data.rankings }));
      const finalState = data.state;
      if (!finalState.hands) results.errors.push('final state missing full hands reveal');
      finish();
    }
  });
  socket.on('connect', () => {
    if (idx === 0) {
      setTimeout(() => send('ROOM_CREATE', { bet: 0, password: '', maxPlayers: 4 }), 400);
    }
  });
  socket.on('connect_error', (err) => results.errors.push(`${user.name} connect_error: ${err.message}`));
}

function finish() {
  setTimeout(() => {
    console.log(`states broadcast: ${results.stateCount}`);
    console.log(`leaks: ${results.leaks.length === 0 ? 'NONE' : results.leaks.join('; ')}`);
    console.log(`errors: ${results.errors.length === 0 ? 'NONE' : results.errors.slice(0, 5).join('; ')}`);
    console.log(results.matchOver && results.leaks.length === 0 ? 'E2E_PASS' : 'E2E_FAIL');
    for (const c of clients) c.socket.disconnect();
    process.exit(results.matchOver && results.leaks.length === 0 ? 0 : 1);
  }, 800);
}

setTimeout(() => {
  console.log('TIMEOUT waiting for match to finish');
  console.log(`errors: ${results.errors.slice(0, 8).join('; ')}`);
  process.exit(1);
}, 90_000);

USERS.forEach((user, idx) => makeClient(user, idx));
