// Harness dev-only: dựng mọi màn Cờ Tướng bằng dữ liệu giả, không cần server
// game. Store thật được dùng nguyên vẹn, chỉ ghi đè init để không mở socket.
//
//   /xiangqi/mock-ui.html?screen=<tên>
//
// Xem SCENES bên dưới để biết đủ tên màn.
import { useEffect } from 'react';
import { createRoot } from 'react-dom/client';
import { GAME_REACTION_TYPE } from '../src/sdk';
import type { ChatMessageData, LeaderboardEntry, MatchHistoryEntry, RoomInfo, RoomStateData } from '../src/sdk';
import { App } from './App';
import { EMPTY, parseBoardRows } from './logic/board';
import { legalMovesFrom } from './logic/moves';
import { useXiangqi, type PieceView } from './store/useXiangqi';

type Scene = Partial<ReturnType<typeof useXiangqi.getState>>;

const ME = { id: 'u-me', username: 'thanhlong', ken: 1_284_500, vipDays: 30, vipType: '4', maxBet: 500_000 };
const OP_NAME = 'kiemvuong';

const NAMES = [
  'thanhlong',
  'kiemvuong',
  'huyenthoai',
  'bangchu',
  'ducanh97',
  'chienthan',
  'saobang',
  'linhmiu',
  'quyvuong',
  'baolong',
];

// Cột x=4 bị Mã đỏ (4,1) chắn nên hai Tướng không lộ mặt; Đỏ chưa bị chiếu.
const MID_BOARD = parseBoardRows([
  'R..AKA..R',
  '....H....',
  '.C.....C.',
  '.PP.P.P.P',
  '.p.......',
  '....p....',
  '..p...p.p',
  '.c.....c.',
  '....h....',
  'r..akae.r',
]);

// Xe đỏ vừa từ (4,3) nhảy tới (4,8) — Tướng đen bị chiếu.
const CHECK_BOARD = parseBoardRows([
  'R..AKA...',
  '....H....',
  '.C.....C.',
  '.PP...P.P',
  '.p.......',
  '......p..',
  '..p.....p',
  '.c.....c.',
  '....R....',
  'r..akae.r',
]);

const MID_LAST_FROM = 58;
const MID_LAST_TO = 49;
const CHECK_LAST_FROM = 31;
const CHECK_LAST_TO = 76;
const SELECTED_IDX = 19;

function pieces(board: number[]): PieceView[] {
  const out: PieceView[] = [];
  for (let idx = 0; idx < board.length; idx++) {
    if (board[idx] !== EMPTY) out.push({ key: `p${idx}-${board[idx]}`, piece: board[idx], idx });
  }
  return out;
}

function rooms(count: number): RoomInfo[] {
  return Array.from({ length: count }, (_, i) => {
    const full = i % 5 === 2;
    return {
      id: `room-${i + 1}`,
      owner: NAMES[(i + 1) % NAMES.length],
      bet: [0, 100, 500, 1_000, 5_000][i % 5],
      locked: i % 3 === 1,
      players: full ? 2 : 1,
      maxPlayers: 2,
      full,
    };
  });
}

function history(count: number): MatchHistoryEntry[] {
  const outcomes: MatchHistoryEntry['outcome'][] = ['win', 'lose', 'draw'];
  const now = Date.now();
  return Array.from({ length: count }, (_, i) => {
    const bet = [1_000, 500, 5_000, 0, 100][i % 5];
    const outcome = outcomes[i % 3];
    return {
      id: `m${i + 1}`,
      playedAt: now - (i + 1) * 5_400_000,
      opponentId: `u${i + 1}`,
      opponentName: NAMES[(i + 2) % NAMES.length],
      bet,
      outcome,
      // Hoa hồng 5%: thắng cược 1.000 chỉ thực nhận +950.
      kenDelta: outcome === 'win' ? bet - Math.round(bet * 0.05) : outcome === 'lose' ? -bet : 0,
    };
  });
}

function leaderboard(count: number, top: number): LeaderboardEntry[] {
  return Array.from({ length: count }, (_, i) => ({
    rank: i + 1,
    userId: `u${i + 1}`,
    username: NAMES[i % NAMES.length],
    ken: Math.round(top * Math.pow(0.82, i)),
    wins: 38 - i * 2,
    losses: 3 + i,
  }));
}

function room(opts: { asGuest?: boolean; alone?: boolean; guestReady?: boolean }): RoomStateData {
  const members = [{ id: 'u-owner', name: 'thanhlong', owner: true, ready: true }];
  if (!opts.alone) {
    members.push({ id: 'u-guest', name: OP_NAME, owner: false, ready: !!opts.guestReady });
  }
  return {
    roomId: 'room-mock',
    ownerId: 'u-owner',
    youId: opts.asGuest ? 'u-guest' : 'u-owner',
    bet: 1_000,
    locked: true,
    maxPlayers: 2,
    members,
  };
}

const CHAT: ChatMessageData[] = [
  { matchId: 'm-mock', userId: 'u-op', name: OP_NAME, text: 'Nước pháo đó hay đấy 😎', sentAt: Date.now() - 96_000 },
  { matchId: 'm-mock', userId: ME.id, name: ME.username, text: 'Xem nước này của tôi', sentAt: Date.now() - 54_000 },
  { matchId: 'm-mock', userId: 'u-op', name: OP_NAME, text: 'Coi chừng mã của tôi nhé', sentAt: Date.now() - 12_000 },
];

function match(over: Partial<Scene> = {}): Scene {
  return {
    boardMode: 'playing',
    lobbyVisible: false,
    board: MID_BOARD,
    pieces: pieces(MID_BOARD),
    lastFrom: MID_LAST_FROM,
    lastTo: MID_LAST_TO,
    selected: null,
    hints: [],
    me: { id: ME.id, name: ME.username, side: 0 },
    op: { id: 'u-op', name: OP_NAME, side: 1 },
    myTurn: true,
    movePending: false,
    deadline: Date.now() + 22_000,
    timerLeftMs: 22_000,
    bet: 1_000,
    matchSeq: 1,
    messages: CHAT,
    ...over,
  };
}

function checkMatch(over: Partial<Scene> = {}): Scene {
  return match({
    board: CHECK_BOARD,
    pieces: pieces(CHECK_BOARD),
    lastFrom: CHECK_LAST_FROM,
    lastTo: CHECK_LAST_TO,
    myTurn: false,
    deadline: Date.now() + 27_000,
    timerLeftMs: 27_000,
    ...over,
  });
}

function botMatch(over: Partial<Scene> = {}): Scene {
  return match({
    gameMode: 'bot',
    botDifficulty: 'medium',
    botPlayerSide: 0,
    botThinking: false,
    me: { id: ME.id, name: ME.username, side: 0 },
    op: { id: 'local-bot', name: 'Máy · Vừa', side: 1 },
    deadline: 0,
    timerLeftMs: 0,
    bet: 0,
    messages: [],
    ...over,
  });
}

const noop = (): void => {};

const SCENES: Record<string, () => Scene> = {
  lobby: () => ({ lobbyPhase: 'ready' }),
  'lobby-connecting': () => ({ lobbyPhase: 'connecting', userInfo: null, ken: 0 }),
  'lobby-error': () => ({ lobbyPhase: 'error', lobbyError: 'Không kết nối được máy chủ', userInfo: null, ken: 0 }),
  'bot-setup': () => ({ lobbyPhase: 'ready', botSetupVisible: true }),

  rooms: () => ({ lobbyPhase: 'ready', rankedVisible: true, rooms: rooms(7) }),
  'rooms-empty': () => ({ lobbyPhase: 'ready', rankedVisible: true, rooms: [] }),
  'rooms-create': () => ({ lobbyPhase: 'ready', rankedVisible: true, rooms: rooms(7) }),
  'rooms-password': () => ({ lobbyPhase: 'ready', rankedVisible: true, rooms: rooms(7) }),

  'pregame-alone': () => ({ boardMode: 'pregame', lobbyVisible: false, roomWaiting: room({ alone: true }) }),
  'pregame-ready': () => ({ boardMode: 'pregame', lobbyVisible: false, roomWaiting: room({ guestReady: true }) }),
  'pregame-guest': () => ({ boardMode: 'pregame', lobbyVisible: false, roomWaiting: room({ asGuest: true }) }),

  board: () => match(),
  'board-opp-turn': () => match({ myTurn: false, turnAnnounce: 'ĐẾN LƯỢT ĐỐI THỦ' }),
  'board-selected': () => match({ selected: SELECTED_IDX, hints: legalMovesFrom(MID_BOARD, SELECTED_IDX) }),
  'board-move-pending': () => match({ movePending: true }),
  'board-check': () => checkMatch({ checkSeq: 1 }),
  'board-urgent': () => match({ deadline: Date.now() + 7_000, timerLeftMs: 7_000 }),
  'board-expired': () => match({ deadline: Date.now() - 1_000, timerLeftMs: 0, turnExpired: true }),
  'board-oppaway': () => match({ myTurn: false, oppAway: Date.now() + 24_000 }),
  'board-announce': () => match({ turnAnnounce: 'ĐẾN LƯỢT BẠN' }),
  'board-chat': () => match({ chatOpen: true }),
  'board-chat-restore': () => match({ chatOpen: true, chatRestore: 'Nước này bạn tính sao?', toast: 'Gửi tin quá nhanh' }),
  'board-reactions': () =>
    match({
      reactionFloats: [
        { seq: 1, type: GAME_REACTION_TYPE.Haha, mine: false },
        { seq: 2, type: GAME_REACTION_TYPE.Love, mine: true },
      ],
    }),
  'board-toast': () => match({ toast: 'Nước đi không hợp lệ' }),
  'bot-board': () => botMatch(),
  'bot-thinking': () => botMatch({ myTurn: false, botThinking: true }),
  'bot-live-turn': () => ({ lobbyPhase: 'ready' }),
  'bot-live-black': () => ({ lobbyPhase: 'ready' }),

  'confirm-forfeit': () =>
    match({
      notice: {
        title: 'Bỏ cuộc',
        body: 'Bạn sẽ bị xử thua ván này. Cả hai vẫn ở lại bàn. Tiếp tục?',
        okLabel: 'Bỏ cuộc',
        danger: true,
        onOk: noop,
      },
    }),
  'confirm-exit': () =>
    match({
      notice: { title: 'Thoát bàn', body: 'Thoát sẽ bị xử thua và rời bàn.', okLabel: 'Thoát', danger: true, onOk: noop },
    }),

  'result-win': () =>
    checkMatch({
      roomWaiting: room({ guestReady: true }),
      result: { matchId: 'm-mock', outcome: 'win', kenDelta: 950, reasonText: 'Chiếu bí! Bạn thắng' },
    }),
  'result-lose': () =>
    checkMatch({
      roomWaiting: room({ guestReady: true }),
      result: { matchId: 'm-mock', outcome: 'lose', kenDelta: -1_000, reasonText: 'Bạn hết giờ suy nghĩ' },
    }),
  'result-draw': () =>
    match({
      roomWaiting: room({ guestReady: true }),
      result: { matchId: 'm-mock', outcome: 'draw', kenDelta: null, reasonText: 'Ván hòa — lặp thế 3 lần' },
    }),
  'result-friendly': () =>
    match({
      bet: 0,
      result: { matchId: 'm-mock', outcome: 'win', kenDelta: 0, reasonText: 'Đối thủ đầu hàng' },
    }),
  'bot-result': () =>
    botMatch({
      myTurn: false,
      result: { matchId: 'bot-mock', outcome: 'win', kenDelta: 0, reasonText: 'Chiếu bí! Bạn thắng máy' },
    }),

  history: () => ({ lobbyPhase: 'ready', historyVisible: true, historyItems: history(9) }),
  'history-empty': () => ({ lobbyPhase: 'ready', historyVisible: true, historyItems: [] }),
  'history-loading': () => ({ lobbyPhase: 'ready', historyVisible: true, historyLoading: true }),

  leaderboard: () => ({ lobbyPhase: 'ready', leaderboardVisible: true, leaderboardItems: leaderboard(9, 1_284_500) }),
  'leaderboard-week': () => ({
    lobbyPhase: 'ready',
    leaderboardVisible: true,
    leaderboardPeriod: 'week',
    leaderboardItems: leaderboard(9, 8_640_000),
  }),
  'leaderboard-empty': () => ({ lobbyPhase: 'ready', leaderboardVisible: true, leaderboardItems: [] }),
  'leaderboard-loading': () => ({ lobbyPhase: 'ready', leaderboardVisible: true, leaderboardLoading: true }),

  toast: () => ({ lobbyPhase: 'ready', rankedVisible: true, rooms: rooms(7), toast: 'Bạn không đủ Ken để tạo bàn' }),
};

const MOCK_SCREENS = Object.keys(SCENES);

// Các state chỉ sống trong component (modal tạo/vào bàn, reaction picker) nên
// harness bấm hộ đúng nút thay vì nhân bản lại markup.
const CLICK_AFTER_MOUNT: Record<string, () => void> = {
  'rooms-create': () => {
    const buttons = [...document.querySelectorAll<HTMLButtonElement>('.xq-ranked-footer .xq-btn')];
    buttons.find((button) => button.textContent?.trim() === 'Tạo bàn')?.click();
  },
  'rooms-password': () => {
    const rows = [...document.querySelectorAll<HTMLDivElement>('.xq-room-row')];
    const locked = rows.find((row) => row.querySelector('[aria-label="Có mật khẩu"]'));
    locked?.querySelector<HTMLButtonElement>('.xq-room-join .xq-btn')?.click();
  },
  'board-reactions': () => {
    const buttons = [...document.querySelectorAll<HTMLButtonElement>('.xq-actionbar .xq-action')];
    buttons.find((button) => button.textContent?.includes('Cảm xúc'))?.click();
  },
  'bot-live-turn': () => {
    useXiangqi.getState().startBotGame('easy', 0);
    window.setTimeout(() => {
      useXiangqi.getState().tapSquare(19);
      useXiangqi.getState().tapSquare(22);
    }, 50);
  },
  'bot-live-black': () => {
    useXiangqi.getState().startBotGame('easy', 1);
  },
};

const screen = new URLSearchParams(location.search).get('screen') ?? 'lobby';
const scene = SCENES[screen] ?? SCENES.lobby;

useXiangqi.setState({
  init: async () => {},
  retryConnect: noop,
  lobbyVisible: true,
  lobbyPhase: 'ready',
  userInfo: ME,
  ken: ME.ken,
  ...scene(),
});

function MockApp() {
  const checking = useXiangqi((s) => s.checkSeq !== 0);

  // CheckBanner tự tắt sau 1,4 s; bơm lại để ảnh chụp luôn bắt được nó.
  useEffect(() => {
    if (!checking) return;
    const timer = window.setInterval(() => useXiangqi.setState((s) => ({ checkSeq: s.checkSeq + 1 })), 1_000);
    return () => window.clearInterval(timer);
  }, [checking]);

  useEffect(() => {
    const click = CLICK_AFTER_MOUNT[screen];
    if (!click) return;
    const timer = window.setTimeout(click, 0);
    return () => window.clearTimeout(timer);
  }, []);

  return <App />;
}

createRoot(document.getElementById('root')!).render(<MockApp />);

// scripts/xiangqi-shots.mjs đọc hai giá trị này để biết cần chụp những màn nào.
Object.defineProperty(window, '__mockScreens', { value: MOCK_SCREENS });
Object.defineProperty(window, '__mockScreen', { value: screen });
requestAnimationFrame(() => {
  requestAnimationFrame(() => Object.defineProperty(window, '__mockReady', { value: true }));
});
