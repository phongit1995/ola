// Harness dev-only: dựng mọi màn của Tiến Lên bằng dữ liệu giả, không cần
// server game. Store thật được dùng nguyên vẹn, chỉ ghi đè init/dispose để
// không mở socket.
//
//   /thirteen/mock-ui.html?screen=<tên>
//
// Xem SCENES bên dưới để biết đủ tên màn.
import { createRoot } from 'react-dom/client';
import type { ChatMessageData, PlayerInfo, RoomInfo, RoomStateData } from '../src/sdk';
import { App } from './App';
import { useThirteen } from './store/useThirteen';

const ME = { id: 'u-me', username: 'test1', ken: 9_957_000, vipDays: 30, vipType: '3' };

const PLAYERS_4: PlayerInfo[] = [
  { id: ME.id, name: 'test1' },
  { id: 'u-2', name: 'hoangminh' },
  { id: 'u-3', name: 'lananh' },
  { id: 'u-4', name: 'quocbao' },
];

const ROOMS: RoomInfo[] = [
  { id: 'r1', owner: 'hoangminh', bet: 0, locked: false, players: 2, maxPlayers: 4, status: 'waiting' },
  { id: 'r2', owner: 'lananh', bet: 0, locked: true, players: 1, maxPlayers: 3, status: 'waiting' },
  { id: 'r3', owner: 'quocbao', bet: 0, locked: false, players: 4, maxPlayers: 4, status: 'playing' },
  { id: 'r4', owner: 'thuha', bet: 0, locked: false, players: 2, maxPlayers: 2, status: 'waiting' },
];

const ROOM_CHAT: ChatMessageData[] = [
  { roomId: 'r0', userId: 'u-2', name: 'hoangminh', text: 'vào nhanh nào ae', sentAt: Date.now() - 60_000 },
  { roomId: 'r0', userId: ME.id, name: 'test1', text: 'ok chờ 1 người nữa', sentAt: Date.now() - 30_000 },
  { roomId: 'r0', userId: 'u-3', name: 'lananh', text: 'sẵn sàng rồi nha chủ bàn', sentAt: Date.now() - 5_000 },
];

const MATCH_CHAT: ChatMessageData[] = [
  { matchId: 'm1', userId: 'u-2', name: 'hoangminh', text: 'chặt đó nha', sentAt: Date.now() - 20_000 },
  { matchId: 'm1', userId: ME.id, name: 'test1', text: 'tới luôn', sentAt: Date.now() - 8_000 },
];

function room(ownerIdx: number, maxPlayers: number, memberCount: number): RoomStateData {
  const members = PLAYERS_4.slice(0, memberCount).map((player, i) => ({
    id: player.id,
    name: player.name,
    owner: i === ownerIdx,
    ready: i !== ownerIdx && i !== memberCount - 1,
  }));
  return {
    roomId: 'r0',
    ownerId: PLAYERS_4[ownerIdx].id,
    youId: ME.id,
    bet: 0,
    locked: false,
    maxPlayers,
    members,
  };
}

const MY_HAND = [0, 5, 8, 9, 13, 18, 22, 27, 31, 36, 41, 45, 50];

function table(players: PlayerInfo[]) {
  return {
    phase: 'table' as const,
    matchId: 'm1',
    players,
    you: 0,
    hand: MY_HAND,
    handCounts: players.map((_, i) => (i === 0 ? MY_HAND.length : [0, 9, 11, 7][i] ?? 9)),
    table: { cards: [16, 17], by: players.length > 2 ? 2 : 1 },
    lastPlaySeat: players.length > 2 ? 2 : 1,
    passed: players.map((_, i) => i === 1),
    quit: players.map(() => false),
    finishOrder: [],
    turn: 0,
    deadlineAt: performance.now() + 22_000,
    require3s: false,
  };
}

const SCENES: Record<string, () => Partial<ReturnType<typeof useThirteen.getState>>> = {
  connecting: () => ({ phase: 'connecting' }),
  lobby: () => ({ phase: 'lobby', rooms: ROOMS }),
  'lobby-empty': () => ({ phase: 'lobby', rooms: [] }),
  'lobby-queueing': () => ({ phase: 'lobby', rooms: ROOMS, queueing: true }),
  'room-host': () => ({ phase: 'room', room: room(0, 4, 3), roomChat: ROOM_CHAT }),
  'room-guest': () => ({ phase: 'room', room: room(1, 4, 4), roomChat: [] }),
  'room-2p': () => ({ phase: 'room', room: room(0, 2, 2), roomChat: [] }),
  table: () => table(PLAYERS_4),
  'table-2p': () => table(PLAYERS_4.slice(0, 2)),
  'table-3p': () => table(PLAYERS_4.slice(0, 3)),
  'table-selected': () => ({ ...table(PLAYERS_4), selected: [18, 19] }),
  'table-dealing': () => ({ ...table(PLAYERS_4), dealing: true, table: null }),
  'table-chat': () => ({ ...table(PLAYERS_4), chatOpen: true, matchChat: MATCH_CHAT }),
  'table-fx': () => ({
    ...table(PLAYERS_4),
    finishFx: { seat: 2, place: 1 },
    finishOrder: [2],
    reactions: [{ seat: 1, type: 'HAHA', key: 1 }],
    awaySeats: { 3: performance.now() + 25_000 },
  }),
  'table-chop': () => ({ ...table(PLAYERS_4), chopFx: Date.now() }),
  'table-disconnected': () => ({ ...table(PLAYERS_4), selfDisconnected: true }),
  'confirm-exit': () => ({ ...table(PLAYERS_4), confirmExit: true }),
  notice: () => ({ phase: 'lobby', rooms: ROOMS, notice: 'Bàn đã bị chủ bàn đóng' }),
  toast: () => ({ phase: 'lobby', rooms: ROOMS, toast: 'Bộ bài không hợp lệ' }),
  result: () => ({
    ...table(PLAYERS_4),
    finishOrder: [2, 0, 1, 3],
    result: {
      rankings: [
        { userId: 'u-3', place: 1 },
        { userId: ME.id, place: 2 },
        { userId: 'u-2', place: 3 },
        { userId: 'u-4', place: 4 },
      ],
      winnerId: 'u-3',
      reason: 'win',
    },
  }),
  'result-room': () => ({
    ...table(PLAYERS_4),
    room: room(0, 4, 4),
    finishOrder: [2, 0, 1, 3],
    result: {
      rankings: [
        { userId: 'u-3', place: 1 },
        { userId: ME.id, place: 2 },
        { userId: 'u-2', place: 3 },
        { userId: 'u-4', place: 4 },
      ],
      winnerId: 'u-3',
      reason: 'win',
    },
  }),
  'result-instant': () => ({
    ...table(PLAYERS_4),
    result: {
      rankings: [{ userId: ME.id, place: 1 }],
      winnerId: ME.id,
      reason: 'win',
      instantWin: 'fourTwos',
    },
  }),
};

const screen = new URLSearchParams(location.search).get('screen') ?? 'lobby';
const scene = SCENES[screen] ?? SCENES.lobby;

useThirteen.setState({ init: () => {}, dispose: () => {}, user: ME, ...scene() });

createRoot(document.getElementById('root')!).render(<App />);
