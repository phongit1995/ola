import { io } from 'socket.io-client';
import crypto from 'node:crypto';

const SECRET = process.env.JWT_SECRET;
const USERS = JSON.parse(process.env.TY_USERS ?? '[]');
const SERVER = process.env.GAME_SERVER ?? 'http://localhost:8082';
const PLAYERS = Number(process.env.TY_PLAYERS ?? USERS.length);
const JOIN_OWNER = process.env.TY_JOIN_OWNER ?? '';
const TIMEOUT_MS = Number(process.env.TY_TIMEOUT_MS ?? 30 * 60 * 1000);
const FORFEIT_AFTER = Number(process.env.TY_FORFEIT_AFTER ?? 0);
const MOVE_DELAY_MS = Number(process.env.TY_MOVE_DELAY_MS ?? 80);

if (!SECRET || USERS.length < 2) {
  console.error('Cần JWT_SECRET và TY_USERS (JSON [{id,name}], tối thiểu 2 người)');
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

function pickMove(state, you) {
  const me = state.players[you];
  switch (state.phase) {
    case 'roll':
    case 'travel':
      return { type: 'ROLL' };
    case 'jail':
      return me.cash > 400 ? { type: 'JAIL_PAY' } : { type: 'JAIL_ROLL' };
    case 'decide':
      return me.cash > 350 ? { type: 'BUY' } : { type: 'DECLINE' };
    case 'takeover':
    case 'festival':
      return { type: 'DECLINE' };
    case 'card':
      return { type: 'CARD_ACK' };
    case 'debt':
      return { type: 'SETTLE_DEBT' };
    default:
      return { type: 'END_TURN' };
  }
}

const FALLBACK = { BUY: 'DECLINE', JAIL_PAY: 'JAIL_ROLL' };

const results = { matchOver: null, errors: [], leaks: [], states: 0, startedAt: 0 };
const bots = USERS.slice(0, JOIN_OWNER ? USERS.length : PLAYERS);
let roomId = null;

function makeClient(user, idx) {
  const socket = io(SERVER, { auth: { token: mintJwt(user.id), gameId: 'tycoon', name: user.name }, transports: ['websocket'] });
  const ctx = { socket, user, idx, matchId: null, you: -1, ready: false, joining: false, forfeited: false, last: null };
  const send = (type, data) => socket.emit('message', { type, data });
  const owner = !JOIN_OWNER && idx === 0;
  const joinOwnerRoom = (id) => {
    ctx.joining = true;
    roomId = id;
    setTimeout(() => send('ROOM_JOIN', { roomId: id }), idx * 400);
  };

  const play = (state, turn) => {
    if (turn !== ctx.you || state.finished) return;
    const move = pickMove(state, ctx.you);
    ctx.last = move.type;
    setTimeout(() => send('MOVE', { matchId: ctx.matchId, move }), MOVE_DELAY_MS);
  };

  socket.on('message', ({ type, data }) => {
    if (type === 'ERROR') {
      if (data.code === 'ROOM_BUSY' && roomId) {
        setTimeout(() => send('ROOM_JOIN', { roomId }), 300 + idx * 150);
        return;
      }
      const fallback = FALLBACK[ctx.last];
      if ((data.code === 'INVALID_MOVE' && data.message === 'tycoon:wrong_phase') || data.code === 'NOT_YOUR_TURN') return;
      if (data.code === 'INVALID_MOVE' && fallback && ctx.matchId) {
        ctx.last = fallback;
        send('MOVE', { matchId: ctx.matchId, move: { type: fallback } });
        return;
      }
      results.errors.push(`${user.name}: ${data.code} ${data.message}`);
      return;
    }
    if (type === 'ROOM_LIST' && JOIN_OWNER && !ctx.joining) {
      const room = data.rooms.find((item) => item.owner === JOIN_OWNER);
      if (room) joinOwnerRoom(room.id);
      return;
    }
    if (type === 'ROOM_UPSERT' && JOIN_OWNER && !ctx.joining && data.room.owner === JOIN_OWNER) {
      joinOwnerRoom(data.room.id);
      return;
    }
    if (type === 'ROOM_WAITING' && owner && !roomId) {
      roomId = data.roomId;
      console.log(`bàn ${roomId} · ${data.maxPlayers} người`);
      clients.slice(1).forEach((other, i) => setTimeout(() => other.socket.emit('message', { type: 'ROOM_JOIN', data: { roomId } }), 300 + i * 350));
      return;
    }
    if (type === 'ROOM_STATE') {
      const mine = data.members.find((m) => m.id === user.id);
      if (mine && !mine.owner && !mine.ready && !ctx.ready) {
        ctx.ready = true;
        send('ROOM_READY', { roomId: data.roomId, ready: true });
      }
      if (owner) {
        const guests = data.members.filter((m) => !m.owner);
        if (guests.length === PLAYERS - 1 && guests.every((m) => m.ready)) send('ROOM_START', { roomId: data.roomId });
      }
      return;
    }
    if (type === 'MATCH_FOUND') {
      ctx.matchId = data.matchId;
      ctx.you = data.you;
      if (!results.startedAt) results.startedAt = Date.now();
      if ('rng' in data.state || 'chanceDeck' in data.state) results.leaks.push(`${user.name}: MATCH_FOUND lộ rng/bộ thẻ`);
      setTimeout(() => play(data.state, data.turn), 1600);
      if (process.env.TY_CHAT && idx === 0) {
        setTimeout(() => send('CHAT_SEND', { matchId: data.matchId, text: `Chào cả bàn, mình là ${user.name}!` }), 2500);
        setTimeout(() => send('REACTION_SEND', { matchId: data.matchId, type: 'HAHA' }), 4000);
      }
      return;
    }
    if (type === 'STATE') {
      results.states += 1;
      if ('rng' in data.state || 'chanceDeck' in data.state) results.leaks.push(`${user.name}: STATE lộ rng/bộ thẻ`);
      if (data.matchId !== ctx.matchId) return;
      if (FORFEIT_AFTER > 0 && idx === bots.length - 1 && results.states >= FORFEIT_AFTER && !ctx.forfeited) {
        ctx.forfeited = true;
        send('FORFEIT', { matchId: ctx.matchId, leaveAfter: false });
        return;
      }
      play(data.state, data.turn);
      return;
    }
    if (type === 'MATCH_OVER' && data.matchId === ctx.matchId && !results.matchOver) {
      results.matchOver = data;
      finish();
    }
  });
  socket.on('connect', () => {
    if (owner) setTimeout(() => send('ROOM_CREATE', { bet: Number(process.env.TY_BET ?? 0), password: '', maxPlayers: PLAYERS }), 400);
    if (JOIN_OWNER) send('ROOM_LIST', {});
  });
  socket.on('connect_error', (err) => results.errors.push(`${user.name} connect_error: ${err.message}`));
  return ctx;
}

const clients = bots.map((user, idx) => makeClient(user, idx));

let finished = false;
function finish() {
  if (finished) return;
  finished = true;
  const over = results.matchOver;
  const minutes = results.startedAt ? ((Date.now() - results.startedAt) / 60000).toFixed(1) : '?';
  if (over) {
    const view = over.state;
    console.log(`MATCH_OVER sau ${minutes} phút · vòng ${view.round} · lý do ${view.endReason} · ${results.states} STATE`);
    console.log(`xếp hạng: ${JSON.stringify(over.rankings)}`);
    if (!over.rankings || over.rankings.length !== view.players.length) results.errors.push('rankings thiếu người');
  } else results.errors.push('không nhận được MATCH_OVER');
  if (results.leaks.length) console.log('LỘ DỮ LIỆU:', results.leaks.slice(0, 3));
  if (results.errors.length) console.log('LỖI:', results.errors.slice(0, 10));
  clients.forEach((c) => c.socket.close());
  setTimeout(() => process.exit(results.errors.length || results.leaks.length ? 1 : 0), 200);
}

setTimeout(finish, TIMEOUT_MS);
