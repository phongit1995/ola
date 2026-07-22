import { bridge, joinGame, type GameSession, type MatchFoundData, type PlayerInfo, type RoomInfo, type UserInfoData } from '../src/sdk';
import { BOARD_ASSETS, preloadAssets, VIP_DEFAULT_ICON } from './assets';
import { parseVipTypeId, vipIconUrl } from '@ola/shared/lib/vip';
import {
  buildRanked,
  rankedSetRooms,
  rankedSetVisible,
  rankedShowWaiting,
  rankedToast,
} from './ranked';
import { buildResult, showResult, hideResult } from './result';
import { createBotSession, type BotLevel } from './bot';
import {
  buildLobby,
  lobbyEnterAnimated,
  lobbySetConnecting,
  lobbySetError,
  lobbySetLoaded,
  lobbySetProgress,
  lobbySetReady,
  lobbySetVisible,
} from './lobby';
import { SIZE, type CaroMove, type CaroState } from './types';

const el = {
  status: document.getElementById('status')!,
  board: document.getElementById('board')!,
  overlay: document.getElementById('overlay')!,
  overlayTitle: document.getElementById('overlay-title')!,
  overlaySub: document.getElementById('overlay-sub')!,
  btnAgain: document.getElementById('btn-again') as HTMLButtonElement,
  btnCancel: document.getElementById('btn-cancel') as HTMLButtonElement,
  btnLobby: document.getElementById('btn-lobby') as HTMLButtonElement,
  meName: document.querySelector('#player-me .name')!,
  opName: document.querySelector('#player-op .name')!,
  meMark: document.querySelector('#player-me .mark')!,
  opMark: document.querySelector('#player-op .mark')!,
  meVip: document.querySelector('#player-me .p-vip') as HTMLImageElement,
  opVip: document.querySelector('#player-op .p-vip') as HTMLImageElement,
  me: document.getElementById('player-me')!,
  op: document.getElementById('player-op')!,
  timer: document.getElementById('timer')!,
  timerVal: document.getElementById('timer-val')!,
  turnArrow: document.getElementById('turn-arrow') as HTMLImageElement,
  btnReplay: document.getElementById('btn-replay') as HTMLButtonElement,
  btnForfeit: document.getElementById('btn-forfeit') as HTMLButtonElement,
  btnExit: document.getElementById('btn-exit')!,
};

const cells: HTMLDivElement[] = [];
for (let y = 0; y < SIZE; y++) {
  for (let x = 0; x < SIZE; x++) {
    const cell = document.createElement('div');
    cell.className = 'cell';
    cell.dataset.x = String(x);
    cell.dataset.y = String(y);
    el.board.appendChild(cell);
    cells.push(cell);
  }
}

type OverlayAction = 'again' | 'cancel' | 'lobby';

let session: GameSession<CaroState, CaroMove> | null = null;
let onlineSession: GameSession<CaroState, CaroMove> | null = null;
let botSession: GameSession<CaroState, CaroMove> | null = null;
let botSessionLevel: BotLevel | null = null;
let match: MatchFoundData<CaroState> | null = null;
let matchBet = 0;
let userInfo: UserInfoData | null = null;
let connecting = false;
let myTurn = false;
let deadline = 0;
let timerHandle: number | undefined;

function showOverlay(
  title: string,
  sub: string,
  resultKind?: 'win' | 'lose' | 'draw',
  actions: OverlayAction[] = [],
): void {
  el.overlay.classList.remove('hidden');
  el.overlayTitle.textContent = title;
  el.overlayTitle.className = resultKind === 'win' ? 'win' : resultKind === 'lose' ? 'lose' : '';
  el.overlaySub.textContent = sub;
  el.btnAgain.classList.toggle('hidden', !actions.includes('again'));
  el.btnCancel.classList.toggle('hidden', !actions.includes('cancel'));
  el.btnLobby.classList.toggle('hidden', !actions.includes('lobby'));
}

function hideOverlay(): void {
  el.overlay.classList.add('hidden');
}

function backToLobby(): void {
  hideOverlay();
  hideResult();
  lobbyEnterAnimated();
  if (!userInfo && !connecting) void connectToServer();
}

function renderBoard(state: CaroState): void {
  state.board.forEach((mark, i) => {
    cells[i].className = 'cell' + (mark ? ` p${mark}` : '');
  });
  if (state.lastX >= 0) {
    cells[state.lastY * SIZE + state.lastX].classList.add('last');
  }
}

function formatClock(seconds: number): string {
  const m = Math.floor(seconds / 60);
  const s = seconds % 60;
  return `${String(m).padStart(2, '0')}:${String(s).padStart(2, '0')}`;
}

function setTurn(turn: number, deadlineMs: number): void {
  if (!match) return;
  myTurn = turn === match.you;
  deadline = deadlineMs;
  el.status.textContent = myTurn ? 'Lượt của bạn' : 'Đợi đối thủ...';
  el.me.classList.toggle('active', myTurn);
  el.op.classList.toggle('active', !myTurn);
  el.board.classList.toggle('playable', myTurn);
  el.timer.classList.remove('hidden');
  el.turnArrow.src = myTurn ? BOARD_ASSETS.boardTurnLeft : BOARD_ASSETS.boardTurnRight;
  el.turnArrow.classList.remove('hidden');
  bridge.turnChanged({ yourTurn: myTurn, deadline: deadlineMs });
  if (timerHandle) window.clearInterval(timerHandle);
  const tick = (): void => {
    const left = Math.max(0, Math.ceil((deadline - Date.now()) / 1000));
    el.timerVal.textContent = formatClock(left);
    el.timer.classList.toggle('urgent', left <= 10);
    if (left === 0 && timerHandle) window.clearInterval(timerHandle);
  };
  tick();
  timerHandle = window.setInterval(tick, 250);
}

function clearMatchUi(): void {
  if (timerHandle) window.clearInterval(timerHandle);
  el.btnForfeit.disabled = true;
  el.board.classList.remove('playable');
  el.me.classList.remove('active');
  el.op.classList.remove('active');
  el.timer.classList.add('hidden');
  el.timer.classList.remove('urgent');
  el.turnArrow.classList.add('hidden');
}

function opponentOf(players: PlayerInfo[], you: number): PlayerInfo {
  return players[1 - you];
}

function avatarIconSrc(vipType?: string | null): string {
  const id = parseVipTypeId(vipType);
  return id != null ? vipIconUrl(id) : VIP_DEFAULT_ICON;
}

const BOT_VIP_ID: Record<BotLevel, number> = { easy: 1, normal: 2, hard: 3 };

function wireSession(target: GameSession<CaroState, CaroMove>): void {
  target.onUserInfo((info) => {
    userInfo = info;
    lobbySetReady(info);
  });

  target.onConnectionChange((connected) => {
    if (session === target && !connected) {
      el.status.textContent = 'Mất kết nối, đang thử lại...';
    }
  });

  target.onQueueWaiting(() => {
    if (session !== target) return;
    lobbySetVisible(false);
    showOverlay('Đang tìm trận...', 'Đợi người chơi khác vào hàng chờ', undefined, ['cancel']);
    el.status.textContent = 'Đang tìm trận';
  });

  target.onMatchFound((data) => {
    if (session !== target) return;
    match = data;
    lobbySetVisible(false);
    hideOverlay();
    el.meName.textContent = userInfo ? `@${userInfo.username}` : data.players[data.you].name;
    el.opName.textContent = opponentOf(data.players, data.you).name;
    el.meVip.src = userInfo ? avatarIconSrc(userInfo.vipType) : VIP_DEFAULT_ICON;
    const botVipId = target === botSession && botSessionLevel ? BOT_VIP_ID[botSessionLevel] : null;
    el.opVip.src = botVipId != null ? vipIconUrl(botVipId) : VIP_DEFAULT_ICON;
    el.meMark.className = data.you === 0 ? 'mark x' : 'mark o';
    el.opMark.className = data.you === 0 ? 'mark o' : 'mark x';
    el.btnForfeit.disabled = false;
    el.btnReplay.classList.toggle('hidden', target !== botSession);
    renderBoard(data.state);
    setTurn(data.turn, data.deadline);
    if (data.resumed) el.status.textContent = 'Đã vào lại trận đấu';
  });

  target.onState((data) => {
    if (session !== target) return;
    renderBoard(data.state);
    setTurn(data.turn, data.deadline);
  });

  target.onMatchOver((data) => {
    if (session !== target) return;
    clearMatchUi();
    renderBoard(data.state);
    const won = match != null && data.winnerId === match.players[match.you].id;
    const draw = data.winnerId == null || data.winnerId === '';
    if (draw) {
      showOverlay('Hòa!', '', 'draw', ['again', 'lobby']);
      el.status.textContent = 'Chơi ván mới?';
    } else {
      showResult(won, matchBet > 0 ? (won ? matchBet : -matchBet) : null);
    }
    bridge.gameOver({ matchId: data.matchId, winnerId: data.winnerId, reason: data.reason, won });
    match = null;
  });

  target.onError((err) => {
    if (session === target) el.status.textContent = err.message;
  });
}

function waitUserInfo(target: GameSession<CaroState, CaroMove>, timeoutMs: number): Promise<void> {
  return new Promise((resolve, reject) => {
    const cleanup = (): void => {
      offInfo();
      clearTimeout(timer);
    };
    const offInfo = target.onUserInfo(() => {
      cleanup();
      resolve();
    });
    const timer = setTimeout(() => {
      cleanup();
      reject(new Error('connect timeout'));
    }, timeoutMs);
  });
}

async function connectToServer(): Promise<void> {
  if (connecting) return;
  connecting = true;
  lobbySetConnecting();
  try {
    if (!onlineSession) {
      onlineSession = await joinGame<CaroState, CaroMove>('caro');
      wireSession(onlineSession);
    }
    await waitUserInfo(onlineSession, 8000);
  } catch {
    onlineSession?.disconnect();
    onlineSession = null;
    userInfo = null;
    lobbySetError();
  } finally {
    connecting = false;
  }
}

function startBotGame(level: BotLevel): void {
  if (!botSession || botSessionLevel !== level) {
    botSession?.disconnect();
    botSession = createBotSession(level);
    botSessionLevel = level;
    wireSession(botSession);
  }
  session = botSession;
  session.joinQueue();
}

const MOCK_ROOMS: RoomInfo[] = [
  { id: 'm1', owner: 'toilabot', bet: 1000, locked: false, players: 1 },
  { id: 'm2', owner: 'pain', bet: 5000, locked: true, players: 1 },
  { id: 'm3', owner: 'vua_caro', bet: 20000, locked: false, players: 2, full: true },
  { id: 'm4', owner: 'meomeo', bet: 0, locked: false, players: 1 },
  { id: 'm5', owner: 'songlong', bet: 12345, locked: true, players: 2, full: true },
  { id: 'm6', owner: 'caro_pro', bet: 500, locked: false, players: 1 },
  { id: 'm7', owner: 'hoa_mua_he', bet: 2000, locked: true, players: 1 },
  { id: 'm8', owner: 'bot_hunter', bet: 99999, locked: false, players: 1 },
  { id: 'm9', owner: 'kien_con', bet: 100, locked: false, players: 1 },
  { id: 'm10', owner: 'thach_dau', bet: 7777, locked: false, players: 1 },
  { id: 'm11', owner: 'tay_choi_moi', bet: 0, locked: false, players: 1 },
  { id: 'm12', owner: 'co_thu_lang', bet: 3000, locked: true, players: 1 },
];

function openRanked(): void {
  lobbySetVisible(false);
  rankedSetVisible(true);
  rankedSetRooms(MOCK_ROOMS);
}

el.btnAgain.addEventListener('click', () => session?.joinQueue());

el.btnReplay.addEventListener('click', () => {
  if (match && !window.confirm('Chơi lại ván mới?')) return;
  session?.joinQueue();
});

el.btnCancel.addEventListener('click', () => {
  session?.leaveQueue();
  backToLobby();
});

el.btnLobby.addEventListener('click', backToLobby);

el.btnForfeit.addEventListener('click', () => {
  if (match && window.confirm('Bỏ cuộc trận này?')) session?.forfeit();
});

el.btnExit.addEventListener('click', () => {
  if (match) {
    if (!window.confirm('Thoát sẽ bị xử thua trận này, thoát chứ?')) return;
    session?.forfeit();
  }
  match = null;
  clearMatchUi();
  backToLobby();
});

el.board.addEventListener('click', (event) => {
  if (!match || !myTurn) return;
  const target = event.target as HTMLElement;
  if (!target.dataset.x) return;
  session?.sendMove({ x: Number(target.dataset.x), y: Number(target.dataset.y) });
});

buildLobby({
  onPlayBot: startBotGame,
  onPlayRanked: openRanked,
  onRetry: () => void connectToServer(),
  onExit: () => bridge.exit(),
});

buildRanked({
  onJoin: (room, password) => {
    rankedToast(
      password != null
        ? `(mock) Vào bàn của ${room.owner} — mật khẩu "${password}"`
        : `(mock) Vào bàn của ${room.owner}`,
    );
  },
  onCreate: (bet, password) => {
    rankedShowWaiting(true, bet);
    rankedToast(password ? '(mock) Đã tạo bàn có khóa' : '(mock) Đã tạo bàn');
  },
  onCancelRoom: () => rankedToast('(mock) Đã hủy bàn'),
  onRefresh: () => {
    rankedSetRooms(MOCK_ROOMS);
    rankedToast('Đã làm mới danh sách');
  },
  onExit: () => {
    rankedSetVisible(false);
    lobbyEnterAnimated();
  },
});

buildResult({ onClose: backToLobby });

bridge.ready();

void (async () => {
  await preloadAssets(lobbySetProgress);
  lobbySetLoaded();
  await connectToServer();
})();
