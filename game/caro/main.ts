import { bridge, joinGame, type GameSession, type MatchFoundData, type PlayerInfo } from '../src/sdk';
import { createBotSession, type BotLevel } from './bot';
import { SIZE, type CaroMove, type CaroState } from './types';

const el = {
  status: document.getElementById('status')!,
  board: document.getElementById('board')!,
  overlay: document.getElementById('overlay')!,
  overlayTitle: document.getElementById('overlay-title')!,
  overlaySub: document.getElementById('overlay-sub')!,
  overlayActions: document.getElementById('overlay-actions')!,
  levelPicker: document.getElementById('level-picker')!,
  levelOptions: [...document.querySelectorAll<HTMLButtonElement>('#level-options button')],
  btnBot: document.getElementById('btn-bot') as HTMLButtonElement,
  btnOnline: document.getElementById('btn-online') as HTMLButtonElement,
  meName: document.querySelector('#player-me .name')!,
  opName: document.querySelector('#player-op .name')!,
  meMark: document.querySelector('#player-me .mark')!,
  opMark: document.querySelector('#player-op .mark')!,
  me: document.getElementById('player-me')!,
  op: document.getElementById('player-op')!,
  timer: document.getElementById('timer')!,
  timerVal: document.getElementById('timer-val')!,
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

let session: GameSession<CaroState, CaroMove> | null = null;
let onlineSession: GameSession<CaroState, CaroMove> | null = null;
let botSession: GameSession<CaroState, CaroMove> | null = null;
let botSessionLevel: BotLevel | null = null;
let botLevel: BotLevel = 'normal';
let match: MatchFoundData<CaroState> | null = null;
let myTurn = false;
let deadline = 0;
let timerHandle: number | undefined;

function showOverlay(title: string, sub: string, resultKind?: 'win' | 'lose' | 'draw'): void {
  el.overlay.classList.remove('hidden');
  el.overlayTitle.textContent = title;
  el.overlayTitle.className = resultKind === 'win' ? 'win' : resultKind === 'lose' ? 'lose' : '';
  el.overlaySub.textContent = sub;
  el.btnBot.disabled = false;
  el.btnOnline.disabled = false;
}

function hideOverlay(): void {
  el.overlay.classList.add('hidden');
}

function renderBoard(state: CaroState): void {
  state.board.forEach((mark, i) => {
    const cell = cells[i];
    cell.textContent = mark === 1 ? 'X' : mark === 2 ? 'O' : '';
    cell.className = 'cell' + (mark ? ` p${mark}` : '');
  });
  if (state.lastX >= 0) {
    cells[state.lastY * SIZE + state.lastX].classList.add('last');
  }
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
  bridge.turnChanged({ yourTurn: myTurn, deadline: deadlineMs });
  if (timerHandle) window.clearInterval(timerHandle);
  timerHandle = window.setInterval(() => {
    const left = Math.max(0, Math.ceil((deadline - Date.now()) / 1000));
    el.timerVal.textContent = `${left}s`;
    el.timer.classList.toggle('urgent', left <= 10);
    if (left === 0 && timerHandle) window.clearInterval(timerHandle);
  }, 250);
}

function clearMatchUi(): void {
  if (timerHandle) window.clearInterval(timerHandle);
  el.btnForfeit.disabled = true;
  el.board.classList.remove('playable');
  el.me.classList.remove('active');
  el.op.classList.remove('active');
  el.timer.classList.add('hidden');
  el.timer.classList.remove('urgent');
}

function opponentOf(players: PlayerInfo[], you: number): PlayerInfo {
  return players[1 - you];
}

function wireSession(target: GameSession<CaroState, CaroMove>): void {
  target.onConnectionChange((connected) => {
    if (session === target && !connected) {
      el.status.textContent = 'Mất kết nối, đang thử lại...';
    }
  });

  target.onQueueWaiting(() => {
    if (session !== target) return;
    showOverlay('Đang tìm trận...', 'Đợi người chơi khác vào hàng chờ');
    el.status.textContent = 'Đang tìm trận';
  });

  target.onMatchFound((data) => {
    if (session !== target) return;
    match = data;
    hideOverlay();
    el.meName.textContent = data.players[data.you].name;
    el.opName.textContent = opponentOf(data.players, data.you).name;
    el.meMark.textContent = data.you === 0 ? 'X' : 'O';
    el.meMark.className = data.you === 0 ? 'mark x' : 'mark o';
    el.opMark.textContent = data.you === 0 ? 'O' : 'X';
    el.opMark.className = data.you === 0 ? 'mark o' : 'mark x';
    el.btnForfeit.disabled = false;
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
    const reasonText =
      data.reason === 'timeout' ? 'Hết giờ' : data.reason === 'forfeit' ? 'Bỏ cuộc' : '';
    showOverlay(
      draw ? 'Hòa!' : won ? 'Bạn thắng!' : 'Bạn thua',
      reasonText,
      draw ? 'draw' : won ? 'win' : 'lose',
    );
    el.status.textContent = 'Chơi ván mới?';
    bridge.gameOver({ matchId: data.matchId, winnerId: data.winnerId, reason: data.reason, won });
    match = null;
  });

  target.onError((err) => {
    if (session === target) el.status.textContent = err.message;
  });
}

function selectLevel(level: BotLevel): void {
  botLevel = level;
  el.levelOptions.forEach((btn) => {
    const selected = btn.dataset.level === level;
    btn.classList.toggle('selected', selected);
    btn.setAttribute('aria-checked', String(selected));
  });
}

function startBotGame(): void {
  if (!botSession || botSessionLevel !== botLevel) {
    botSession?.disconnect();
    botSession = createBotSession(botLevel);
    botSessionLevel = botLevel;
    wireSession(botSession);
  }
  session = botSession;
  session.joinQueue();
}

const btnOnlineContent = el.btnOnline.innerHTML;

async function startOnlineGame(): Promise<void> {
  el.btnOnline.disabled = true;
  el.btnOnline.textContent = 'Đang kết nối...';
  try {
    if (!onlineSession) {
      onlineSession = await joinGame<CaroState, CaroMove>('caro');
      wireSession(onlineSession);
    }
    session = onlineSession;
    session.joinQueue();
  } finally {
    el.btnOnline.innerHTML = btnOnlineContent;
    el.btnOnline.disabled = false;
  }
}

el.levelOptions.forEach((btn) => {
  btn.addEventListener('click', () => selectLevel(btn.dataset.level as BotLevel));
});

el.btnBot.addEventListener('click', startBotGame);
el.btnOnline.addEventListener('click', () => void startOnlineGame());

el.btnForfeit.addEventListener('click', () => {
  if (match && window.confirm('Bỏ cuộc trận này?')) session?.forfeit();
});

el.btnExit.addEventListener('click', () => {
  if (match) session?.forfeit();
  bridge.exit();
});

el.board.addEventListener('click', (event) => {
  if (!match || !myTurn) return;
  const target = event.target as HTMLElement;
  if (!target.dataset.x) return;
  session?.sendMove({ x: Number(target.dataset.x), y: Number(target.dataset.y) });
});

bridge.ready();
showOverlay('Cờ Caro', '5 quân liên tiếp để thắng');
