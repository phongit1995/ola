// Harness dev-only: dựng mọi màn của Tiến Lên bằng dữ liệu giả, không cần
// server game. Store thật được dùng nguyên vẹn, chỉ ghi đè init/dispose để
// không mở socket.
//
//   /thirteen/mock-ui.html?screen=<tên>
//
// Xem SCENES bên dưới để biết đủ tên màn.
import { useEffect } from 'react';
import { createRoot } from 'react-dom/client';
import type { ChatMessageData, PlayerInfo, RoomInfo, RoomStateData } from '../src/sdk';
import { App } from './App';
import { CHAT_BUBBLE_MS, receiveMatchChat } from './store/matchChat';
import { useThirteen } from './store/useThirteen';

const ME = { id: 'u-me', username: 'test1', ken: 9_957_000, vipDays: 30, vipType: '3' };

const PLAYERS_4: PlayerInfo[] = [
  { id: ME.id, name: 'test1', vipType: ME.vipType },
  { id: 'u-2', name: 'hoangminh', vipType: '12' },
  { id: 'u-3', name: 'lananh' },
  { id: 'u-4', name: 'quocbao', vipType: '27' },
];

const ROOMS: RoomInfo[] = [
  { id: 'r1', owner: 'hoangminh', ownerVipType: '12', bet: 0, locked: false, players: 2, maxPlayers: 4, status: 'waiting' },
  { id: 'r2', owner: 'lananh', bet: 0, locked: true, players: 1, maxPlayers: 3, status: 'waiting' },
  { id: 'r3', owner: 'quocbao', ownerVipType: '27', bet: 0, locked: false, players: 4, maxPlayers: 4, status: 'playing' },
  { id: 'r4', owner: 'thuha', ownerVipType: '5', bet: 0, locked: false, players: 2, maxPlayers: 2, status: 'waiting' },
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
    vipType: player.vipType,
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

function resultScene(order: string[], extra: { instantWin?: string; reason?: string } = {}) {
  return {
    ...table(PLAYERS_4),
    result: {
      rankings: order.map((userId, i) => ({ userId, place: i + 1 })),
      expGains: order.map((userId, i) => ({ userId, exp: [65, 40, 30, 25][i] ?? 25 })),
      winnerId: order[0],
      reason: extra.reason ?? 'win',
      instantWin: extra.instantWin,
    },
  };
}

const SCENES: Record<string, () => Partial<ReturnType<typeof useThirteen.getState>>> = {
  connecting: () => ({ phase: 'connecting' }),
  lobby: () => ({ phase: 'lobby', rooms: ROOMS }),
  'lobby-empty': () => ({ phase: 'lobby', rooms: [] }),
  'lobby-queueing': () => ({ phase: 'lobby', rooms: ROOMS, queueing: true }),
  'create-room': () => ({ phase: 'lobby', rooms: ROOMS }),
  'password-room': () => ({ phase: 'lobby', rooms: ROOMS }),
  'room-host': () => ({ phase: 'room', room: room(0, 4, 3), roomChat: ROOM_CHAT }),
  'room-guest': () => ({ phase: 'room', room: room(1, 4, 4), roomChat: ROOM_CHAT }),
  'room-2p': () => ({ phase: 'room', room: room(0, 2, 2), roomChat: [] }),
  table: () => table(PLAYERS_4),
  'table-2p': () => table(PLAYERS_4.slice(0, 2)),
  'table-3p': () => table(PLAYERS_4.slice(0, 3)),
  'table-selected': () => ({ ...table(PLAYERS_4), hand: MY_HAND.map((card) => (card === 27 ? 23 : card)), selected: [22, 23] }),
  'table-beat-single': () => ({ ...table(PLAYERS_4), table: { cards: [14], by: 2 } }),
  'table-turn': () => ({ ...table(PLAYERS_4), turn: 1 }),
  'table-urgent': () => ({ ...table(PLAYERS_4), turn: 1, deadlineAt: performance.now() + 4_500 }),
  'table-urgent-me': () => ({ ...table(PLAYERS_4), deadlineAt: performance.now() + 4_500 }),
  'table-lead': () => ({ ...table(PLAYERS_4), table: null, lastPlaySeat: -1, passed: PLAYERS_4.map(() => false), turn: 3 }),
  'table-lead-me': () => ({ ...table(PLAYERS_4), table: null, lastPlaySeat: -1, passed: PLAYERS_4.map(() => false) }),
  'table-dealing': () => ({ ...table(PLAYERS_4), dealing: true, table: null }),
  'table-chat': () => ({ ...table(PLAYERS_4), chatOpen: true, matchChat: MATCH_CHAT, roomOwnerId: 'u-2' }),
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
  result: () => resultScene(['u-3', ME.id, 'u-2', 'u-4']),
  'result-win': () => resultScene([ME.id, 'u-3', 'u-2', 'u-4']),
  'result-lose': () => resultScene(['u-2', 'u-3', 'u-4', ME.id]),
  'result-2p': () => ({ ...resultScene(['u-2', ME.id]), players: PLAYERS_4.slice(0, 2) }),
  'result-room': () => ({ ...resultScene(['u-3', ME.id, 'u-2', 'u-4']), room: room(0, 4, 4) }),
  'result-instant': () => resultScene([ME.id, 'u-2', 'u-3', 'u-4'], { instantWin: 'fourTwos' }),
  'result-forfeit': () => resultScene(['u-3', 'u-2', ME.id, 'u-4'], { reason: 'forfeit' }),
};

const screen = new URLSearchParams(location.search).get('screen') ?? 'lobby';
const scene = SCENES[screen] ?? SCENES.lobby;

useThirteen.setState({ init: () => {}, dispose: () => {}, user: ME, ...scene() });

// Giả lập một lượt đánh như store thật (bài của mình đi đường nhanh, của đối
// thủ phát lại rồi mới chuyển lượt) để xem hiệu ứng bài bay và dòng thông báo:
// mockPlay(1, [40, 42, 43]), mockPlay(2, [48, 49], true) (chặt), mockPass(2),
// mockDeadline(7) (đặt lại đồng hồ lượt), mockReact(1, 'HAHA'), mockChat(1, 'chặt đó nha').
function mockPlay(by: number, cards: number[], chop = false): void {
  const s = useThirteen.getState();
  const next = (by + 1) % s.players.length;
  const play = {
    table: { cards, by },
    lastPlaySeat: by,
    tableEvent: { kind: 'play' as const, seat: by, at: Date.now() },
    ...(chop ? { chopFx: Date.now() } : {}),
  };
  if (by === s.you) {
    useThirteen.setState({
      ...play,
      hand: s.hand.filter((card) => !cards.includes(card)),
      selected: [],
      turn: next,
      deadlineAt: performance.now() + 25_000,
    });
    return;
  }
  useThirteen.setState({
    ...play,
    animating: true,
    handCounts: s.handCounts.map((count, i) => (i === by ? count - cards.length : count)),
  });
  window.setTimeout(() => useThirteen.setState({ animating: false, turn: next, deadlineAt: performance.now() + 25_000 }), 450);
}

function mockPass(by: number): void {
  const s = useThirteen.getState();
  useThirteen.setState({
    animating: true,
    passFxSeat: by,
    passed: s.passed.map((passed, i) => passed || i === by),
    tableEvent: { kind: 'pass', seat: by, at: Date.now() },
  });
  window.setTimeout(
    () =>
      useThirteen.setState({
        animating: false,
        passFxSeat: -1,
        turn: (by + 1) % s.players.length,
        deadlineAt: performance.now() + 25_000,
      }),
    350,
  );
}

function mockDeadline(seconds: number): void {
  useThirteen.setState({ deadlineAt: performance.now() + seconds * 1000 });
}

function mockReact(seat: number, type: string): void {
  const key = Date.now() + Math.random();
  useThirteen.setState((s) => ({ reactions: [...s.reactions, { seat, type, key }] }));
  window.setTimeout(() => useThirteen.setState((s) => ({ reactions: s.reactions.filter((r) => r.key !== key) })), 2600);
}

function mockChat(seat: number, text: string): void {
  const s = useThirteen.getState();
  const player = s.players[seat];
  if (!player) return;
  const key = Date.now() + Math.random();
  useThirteen.setState(receiveMatchChat(s, { matchId: s.matchId, userId: player.id, name: player.name, text, sentAt: Date.now() }, key));
  window.setTimeout(
    () => useThirteen.setState((state) => ({ chatBubbles: state.chatBubbles.filter((bubble) => bubble.key !== key) })),
    CHAT_BUBBLE_MS,
  );
}

Object.assign(window, { mockPlay, mockPass, mockDeadline, mockReact, mockChat });

function MockApp() {
  useEffect(() => {
    if (screen !== 'create-room' && screen !== 'password-room') return;
    const timer = window.setTimeout(() => {
      if (screen === 'create-room') {
        document.querySelector<HTMLButtonElement>('.tl-secondary-btn')?.click();
        return;
      }
      const roomButtons = document.querySelectorAll<HTMLButtonElement>('.tl-room-row > .tl-btn');
      roomButtons[1]?.click();
    });
    return () => window.clearTimeout(timer);
  }, []);

  return <App />;
}

createRoot(document.getElementById('root')!).render(<MockApp />);
