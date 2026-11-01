// Harness dev-only: dựng mọi màn của Tiến Lên bằng dữ liệu giả, không cần
// server game. Store thật được dùng nguyên vẹn, chỉ ghi đè init/dispose để
// không mở socket.
//
//   /thirteen/mock-ui.html?screen=<tên>
//
// Xem SCENES bên dưới để biết đủ tên màn.
import { useEffect } from 'react';
import { createRoot } from 'react-dom/client';
import type {
  ChatMessageData,
  LeaderboardEntry,
  LeaderboardPeriod,
  MatchHistoryEntry,
  MatchHistoryPlayer,
  PlayerInfo,
  RoomInfo,
  RoomStateData,
} from '../src/sdk';
import { App } from './App';
import type { BotLevel } from './logic/bot';
import { BOT_VIP_TYPES } from './helpers/practice';
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
  { id: 'r3', owner: 'quocbao', ownerVipType: '27', bet: 0, locked: false, players: 4, maxPlayers: 4, status: 'playing', matchId: 'm-watch' },
  { id: 'r4', owner: 'thuha', ownerVipType: '5', bet: 0, locked: false, players: 2, maxPlayers: 2, status: 'waiting' },
  { id: 'r5', owner: 'minhthu', bet: 5_000, locked: true, players: 3, maxPlayers: 3, status: 'playing', matchId: 'm-private' },
];

const WATCH_PLAYERS: PlayerInfo[] = [
  { id: 'u-4', name: 'quocbao', vipType: '27' },
  { id: 'u-2', name: 'hoangminh', vipType: '12' },
  { id: 'u-3', name: 'lananh' },
  { id: 'u-5', name: 'thuha', vipType: '5' },
];

const WATCH_CHAT: ChatMessageData[] = [
  { matchId: 'm-watch', userId: 'u-2', name: 'hoangminh', text: 'đôi 2 đây, ai chặt nổi', sentAt: Date.now() - 25_000 },
  { matchId: 'm-watch', userId: 'u-4', name: 'quocbao', text: 'để tui', sentAt: Date.now() - 12_000 },
  { matchId: 'm-watch', userId: 'u-5', name: 'thuha', text: 'bỏ lượt thôi', sentAt: Date.now() - 4_000 },
];

const VIEWERS: PlayerInfo[] = [
  { id: 'u-6', name: 'ngoclinh', vipType: '8' },
  { id: 'u-7', name: 'tuananh' },
  { id: 'u-8', name: 'baotran', vipType: '21' },
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

const MINUTE = 60_000;
const DAY = 24 * 60 * MINUTE;

function historyEntry(
  id: string,
  agoMs: number,
  bet: number,
  kenDelta: number,
  ranking: Array<[string, string, string?]>,
): MatchHistoryEntry {
  const players: MatchHistoryPlayer[] = ranking.map(([userId, username, vipType], i) => ({ userId, username, vipType, place: i + 1 }));
  const place = players.findIndex((player) => player.userId === ME.id) + 1;
  const opponent = players.find((player) => player.userId !== ME.id)!;
  return {
    id,
    playedAt: Date.now() - agoMs,
    opponentId: opponent.userId,
    opponentName: opponent.username,
    opponentVipType: opponent.vipType,
    bet,
    outcome: place === 1 ? 'win' : 'lose',
    kenDelta,
    playerCount: players.length,
    place,
    players,
  };
}

const MOCK_HISTORY: MatchHistoryEntry[] = [
  historyEntry('h1', 25 * MINUTE, 10_000, 29_500, [[ME.id, 'test1', ME.vipType], ['u-2', 'hoangminh', '12'], ['u-3', 'lananh'], ['u-4', 'quocbao', '27']]),
  historyEntry('h2', 2 * 60 * MINUTE, 0, 0, [['u-3', 'lananh'], [ME.id, 'test1', ME.vipType], ['u-4', 'quocbao', '27'], ['u-2', 'hoangminh', '12']]),
  historyEntry('h3', DAY, 5_000, -5_000, [['u-4', 'quocbao', '27'], ['u-9', 'nguyenvanthanhlongdai_99', '5'], [ME.id, 'test1', ME.vipType]]),
  historyEntry('h4', 3 * DAY, 0, 0, [[ME.id, 'test1', ME.vipType], ['u-5', 'thuha', '5']]),
  historyEntry('h5', 5 * DAY, 20_000, -20_000, [['u-6', 'tranquanghuy_chuyen_bai', '45'], [ME.id, 'test1', ME.vipType]]),
  historyEntry('h6', 9 * DAY, 0, 0, [['u-2', 'hoangminh', '12'], ['u-3', 'lananh'], [ME.id, 'test1', ME.vipType], ['u-4', 'quocbao', '27']]),
];

const BOARD_NAMES = ['vuabai_tienlen', 'hoangminh', 'lananh', 'quocbao', 'thuha', 'tranquanghuy_chuyen_bai', 'minhthu', 'baolong', 'ngocanh', 'ducthinh'];
const BOARD_VIPS = ['45', '12', undefined, '27', '5', '3', undefined, '12', undefined, '27'];

function mockBoard(count: number, myRank: number): LeaderboardEntry[] {
  return Array.from({ length: count }, (_, i) => {
    const rank = i + 1;
    const self = rank === myRank;
    const wins = Math.max(1, count * 2 - i * 2 + (i % 3));
    return {
      rank,
      userId: self ? ME.id : `lb-${rank}`,
      username: self ? ME.username : `${BOARD_NAMES[i % BOARD_NAMES.length]}${i >= BOARD_NAMES.length ? i : ''}`,
      vipType: self ? ME.vipType : BOARD_VIPS[i % BOARD_VIPS.length],
      ken: i % 4 === 0 ? (count - i) * 12_500 : 0,
      wins,
      losses: wins + (i % 5) * 2,
      level: Math.max(1, 14 - Math.floor(i / 2)),
    };
  });
}

const MOCK_BOARDS: Record<LeaderboardPeriod, LeaderboardEntry[]> = {
  day: mockBoard(5, 3),
  week: mockBoard(12, 7),
  month: mockBoard(30, 17),
};

function periodStart(period: LeaderboardPeriod): number {
  const local = new Date(Date.now() + 7 * 60 * MINUTE);
  let date = local.getUTCDate();
  if (period === 'week') date -= (local.getUTCDay() + 6) % 7;
  if (period === 'month') date = 1;
  return Date.UTC(local.getUTCFullYear(), local.getUTCMonth(), date) - 7 * 60 * MINUTE;
}

const recordMode = /-(empty|error|loading)$/.exec(new URLSearchParams(location.search).get('screen') ?? '')?.[1] ?? 'data';
const later = (fn: () => void): void => {
  if (recordMode !== 'loading') window.setTimeout(fn, 350);
};

function mockLoadHistory(): void {
  useThirteen.setState({ history: { items: [], loading: true, error: null } });
  later(() =>
    useThirteen.setState({
      history: {
        items: recordMode === 'data' ? MOCK_HISTORY : [],
        loading: false,
        error: recordMode === 'error' ? 'Máy chủ chưa trả lời, hãy thử lại.' : null,
      },
    }),
  );
}

function mockLoadBoard(period: LeaderboardPeriod): void {
  useThirteen.setState({ leaderboard: { period, from: 0, items: [], loading: true, error: null } });
  later(() =>
    useThirteen.setState({
      leaderboard: {
        period,
        from: periodStart(period),
        items: recordMode === 'data' ? MOCK_BOARDS[period] : [],
        loading: false,
        error: recordMode === 'error' ? 'Máy chủ chưa trả lời, hãy thử lại.' : null,
      },
    }),
  );
}

const MOCK_RECORD_ACTIONS = {
  openHistory: () => {
    useThirteen.setState({ overlay: 'history' });
    mockLoadHistory();
  },
  retryHistory: mockLoadHistory,
  openLeaderboard: () => {
    useThirteen.setState({ overlay: 'leaderboard' });
    mockLoadBoard(useThirteen.getState().leaderboard.period);
  },
  setLeaderboardPeriod: mockLoadBoard,
};

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

function watchTable(players: PlayerInfo[]) {
  return {
    phase: 'table' as const,
    spectating: true,
    matchId: 'm-watch',
    roomOwnerId: players[0].id,
    players,
    you: -1,
    hand: [],
    handCounts: players.map((_, i) => [9, 11, 6, 8][i] ?? 9),
    table: { cards: [44, 45], by: 1 },
    lastPlaySeat: 1,
    passed: players.map((_, i) => i === players.length - 1 && players.length > 2),
    quit: players.map(() => false),
    finishOrder: [],
    turn: players.length > 2 ? 2 : 0,
    deadlineAt: performance.now() + 18_000,
    require3s: false,
    spectators: { matchId: 'm-watch', spectators: [VIEWERS[0], { id: ME.id, name: ME.username, vipType: ME.vipType }, VIEWERS[2]] },
  };
}

function watchedRoom(memberCount: number): RoomStateData {
  return {
    roomId: 'r3',
    ownerId: WATCH_PLAYERS[0].id,
    youId: '',
    bet: 0,
    locked: false,
    maxPlayers: 4,
    watcher: true,
    afterMatchId: 'm-watch',
    members: WATCH_PLAYERS.slice(0, memberCount).map((player, i) => ({
      id: player.id,
      name: player.name,
      vipType: player.vipType,
      owner: i === 0,
      ready: i === 1,
    })),
  };
}

const WATCH_ROOM_CHAT: ChatMessageData[] = [
  { roomId: 'r3', userId: 'u-2', name: 'hoangminh', text: 'ván nữa không ae', sentAt: Date.now() - 20_000 },
  { roomId: 'r3', userId: 'u-4', name: 'quocbao', text: 'chơi tiếp, sẵn sàng đi', sentAt: Date.now() - 8_000 },
];

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
  'create-room': () => ({ phase: 'lobby', rooms: ROOMS }),
  'practice-setup': () => ({ phase: 'lobby', rooms: ROOMS }),
  practice: () => ({ phase: 'lobby', rooms: ROOMS }),
  'password-room': () => ({ phase: 'lobby', rooms: ROOMS }),
  history: () => ({ phase: 'lobby', rooms: ROOMS }),
  'history-empty': () => ({ phase: 'lobby', rooms: ROOMS }),
  'history-error': () => ({ phase: 'lobby', rooms: ROOMS }),
  'history-loading': () => ({ phase: 'lobby', rooms: ROOMS }),
  leaderboard: () => ({ phase: 'lobby', rooms: ROOMS }),
  'leaderboard-empty': () => ({ phase: 'lobby', rooms: ROOMS }),
  'leaderboard-error': () => ({ phase: 'lobby', rooms: ROOMS }),
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
  'table-viewers': () => ({ ...table(PLAYERS_4), spectators: { matchId: 'm1', spectators: VIEWERS } }),
  'table-viewers-open': () => ({ ...table(PLAYERS_4), spectators: { matchId: 'm1', spectators: VIEWERS } }),
  'table-viewers-2p': () => ({ ...table(PLAYERS_4.slice(0, 2)), spectators: { matchId: 'm1', spectators: VIEWERS.slice(0, 1) } }),
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
  watch: () => watchTable(WATCH_PLAYERS),
  'watch-3p': () => watchTable(WATCH_PLAYERS.slice(0, 3)),
  'watch-2p': () => watchTable(WATCH_PLAYERS.slice(0, 2)),
  'watch-finished': () => ({ ...watchTable(WATCH_PLAYERS), finishOrder: [0], handCounts: [0, 11, 6, 8], turn: 1 }),
  'watch-chat': () => ({ ...watchTable(WATCH_PLAYERS), chatOpen: true, matchChat: WATCH_CHAT }),
  'watch-viewers-open': () => watchTable(WATCH_PLAYERS),
  'watch-room': () => ({
    phase: 'room',
    rooms: ROOMS,
    watchingRoomId: 'r3',
    watchedRoom: watchedRoom(3),
    roomChat: WATCH_ROOM_CHAT,
  }),
  'watch-room-full': () => ({
    phase: 'room',
    rooms: ROOMS,
    watchingRoomId: 'r3',
    watchedRoom: { ...watchedRoom(4), members: watchedRoom(4).members.map((m) => ({ ...m, ready: true })) },
    roomChat: WATCH_ROOM_CHAT,
  }),
  'watch-ended': () => ({ phase: 'lobby', rooms: ROOMS, toast: 'Ván đấu bạn đang xem đã kết thúc.' }),
};

const screen = new URLSearchParams(location.search).get('screen') ?? 'lobby';
const scene = SCENES[screen] ?? SCENES.lobby;

useThirteen.setState({ init: () => {}, dispose: () => {}, user: ME, ...MOCK_RECORD_ACTIONS, ...scene() });

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

Object.assign(window, { mockPlay, mockPass, mockDeadline, mockReact, mockChat, useThirteen });

// ?screen=practice chơi thật với máy (không cần server); ?bots=easy,hard chọn số máy và mức.
function practiceBots() {
  const levels = (new URLSearchParams(location.search).get('bots') ?? 'normal,normal,normal').split(',') as BotLevel[];
  return levels.slice(0, 3).map((level, i) => ({ id: `bot-${i + 1}`, vipType: BOT_VIP_TYPES[i], level }));
}

function MockApp() {
  useEffect(() => {
    if (screen === 'practice') {
      useThirteen.getState().startPractice(practiceBots());
      return;
    }
    if (screen.startsWith('history')) {
      useThirteen.getState().openHistory();
      return;
    }
    if (screen.startsWith('leaderboard')) {
      useThirteen.getState().openLeaderboard();
      return;
    }
    if (screen.endsWith('viewers-open')) {
      const timer = window.setTimeout(() => document.querySelector<HTMLButtonElement>('.tl-viewers-tab')?.click(), 300);
      return () => window.clearTimeout(timer);
    }
    if (screen !== 'create-room' && screen !== 'password-room' && screen !== 'practice-setup') return;
    const timer = window.setInterval(() => {
      const target =
        screen === 'create-room'
          ? document.querySelector<HTMLButtonElement>('.tl-play-now')
          : screen === 'practice-setup'
            ? document.querySelector<HTMLButtonElement>('.tl-practice-btn')
            : document.querySelectorAll<HTMLButtonElement>('.tl-room-row > .tl-btn')[1];
      if (!target || target.disabled) return;
      target.click();
      window.clearInterval(timer);
    }, 100);
    return () => window.clearInterval(timer);
  }, []);

  return <App />;
}

createRoot(document.getElementById('root')!).render(<MockApp />);
