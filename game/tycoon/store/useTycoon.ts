import { create } from 'zustand';
import type { TyIconName } from '../components/TyIcon';
import { ARCADE_ATTENTION_REASON } from '@ola/shared/constants';
import { vipIconUrl } from '@ola/shared/lib/vip';
import { bridge, type GameReactionType } from '../../src/sdk';
import { BOARD, cardById } from '../logic/board';
import { botMove } from '../logic/bot';
import { BOARD_SIZE, FESTIVAL_MULTIPLIER, JAIL_TILE, MAX_ROUNDS, TAX_RATE, TIME_LIMIT_MS, TURN_SECONDS, WIN_GROUPS } from '../logic/constants';
import { applyMove, endByTime, isOver, moveOnTimeout, newGame, quitPlayer, rankings, worth } from '../logic/engine';
import { RuleError, type GameState, type Move, type Step, type TileState } from '../logic/types';
import { formatMoney } from '../helpers/format';
import { avatarIconUrl } from '../helpers/player';
import { MOCK_PROFILE, type LobbyProfile } from '../helpers/profile';
import { levelLabel } from '../helpers/tiles';
import { playSound, setSoundEnabled } from '../audio';

export type BoardMode = 'idle' | 'playing';
export type Sheet = { kind: 'tile'; idx: number } | { kind: 'assets'; seat: number } | { kind: 'log' } | null;

export interface SeatInfo {
  id: string;
  name: string;
  avatar: string;
  bot: boolean;
}

export interface DiceFx {
  values: [number, number];
  rolling: boolean;
  double: boolean;
  seq: number;
}

export interface CardFx {
  deck: 'chance' | 'chest';
  id: string;
  seq: number;
}

export interface MoneyFloat {
  seat: number;
  amount: number;
  seq: number;
}

export interface ReactionFloat {
  seq: number;
  seat: number;
  type: GameReactionType;
}

export interface LogLine {
  seq: number;
  text: string;
  tone: 'up' | 'down' | 'neutral';
}

export interface RankRow {
  seat: number;
  place: number;
  name: string;
  worth: number;
  bankrupt: boolean;
}

export interface MatchResultState {
  matchId: string;
  rows: RankRow[];
  myPlace: number;
  reasonText: string;
}

export type NoticeKind = 'confirm' | 'notice';
export type NoticeTone = 'default' | 'danger' | 'info' | 'success' | 'warning' | 'error';

export interface NoticeState {
  kind: NoticeKind;
  tone?: NoticeTone;
  title: string;
  body: string;
  hint?: string;
  icon?: TyIconName;
  okLabel: string;
  cancelLabel?: string;
  dismissible?: boolean;
  onOk?: () => void | Promise<void>;
  onCancel?: () => void;
}

interface TycoonState {
  profile: LobbyProfile | null;
  soundOn: boolean;
  rulesOpen: boolean;
  setupOpen: boolean;
  playerCount: number;

  boardMode: BoardMode;
  players: SeatInfo[];
  you: number;
  view: GameState | null;
  positions: number[];
  cash: number[];
  tiles: TileState[];
  myTurn: boolean;
  deadline: number;
  timerLeftMs: number;
  turnExpired: boolean;
  turnAnnounce: string | null;
  movePending: boolean;
  replaying: boolean;
  matchSeq: number;
  startedAt: number;
  log: LogLine[];

  diceFx: DiceFx;
  cardFx: CardFx | null;
  landingTile: number;
  pathTiles: number[];
  moneyFloats: MoneyFloat[];
  jailFxSeat: number;
  sheet: Sheet;

  result: MatchResultState | null;
  toast: string | null;
  notice: NoticeState | null;
  noticeId: number;
  noticeQueue: NoticeState[];

  init(): void;
  dispose(): void;
  toggleSound(): void;
  exitGame(): void;
  setRulesOpen(open: boolean): void;
  setSetupOpen(open: boolean): void;
  startGame(playerCount: number): void;

  sendMove(move: Move): void;
  openSheet(sheet: Sheet): void;
  closeSheet(): void;
  forfeitMatch(): void;
  exitMatch(): void;

  closeResult(): void;
  playAgain(): void;

  showToast(text: string): void;
  clearToast(): void;
  showNotice(notice: NoticeState): void;
  closeNotice(notice: NoticeState): void;
}

const SOUND_KEY = 'ola:tycoon:sound';
const COUNT_KEY = 'ola:tycoon:players';
const TURN_ANNOUNCE_MS = 1200;
const TOAST_MS = 2400;
const RESULT_REVEAL_MS = 900;
const BOT_THINK_MS = 650;

const STEP_MS = {
  rollSpin: 720,
  rollSettle: 220,
  hop: 140,
  hopFast: 110,
  teleport: 420,
  land: 220,
  pay: 520,
  card: 420,
  jailIn: 700,
  jailOut: 200,
  build: 260,
  debt: 300,
  bankrupt: 900,
  round: 240,
};

const BOT_NAMES = ['Bác Tỷ', 'Cô Ngân', 'Anh Tèo'];

const RULE_TEXT: Record<string, string> = {
  wrong_phase: 'Chưa đến lúc làm việc này',
  not_your_turn: 'Chưa đến lượt bạn',
  not_active: 'Bạn không còn trong ván',
  finished: 'Ván đã kết thúc',
  no_cash: 'Không đủ tiền',
  not_takeover: 'Không mua lại được ô này',
  takeover_hotel: 'Ô đã lên Khách sạn, không mua lại được',
  no_jail_card: 'Bạn không có thẻ ra tù',
  not_street: 'Chỉ xây được trên ô đất',
  not_owner: 'Ô này không phải của bạn',
  not_group_owner: 'Cần sở hữu trọn nhóm mới được nâng cấp',
  max_houses: 'Đã đạt cấp tối đa',
  build_uneven: 'Phải nâng đều các ô trong nhóm',
  no_houses: 'Ô này đang là đất trống',
  sell_uneven: 'Phải hạ đều các ô trong nhóm',
  invalid_tile: 'Ô không hợp lệ',
  unknown_move: 'Thao tác không hợp lệ',
};

const sleep = (ms: number): Promise<void> => new Promise((resolve) => setTimeout(resolve, ms));
const reducedMotion = () => window.matchMedia?.('(prefers-reduced-motion: reduce)').matches ?? false;

function emptyDice(): DiceFx {
  return { values: [1, 1], rolling: false, double: false, seq: 0 };
}

function reasonLabel(reason: string | undefined, amount: number, tile?: number): string {
  const name = tile != null ? BOARD[tile]?.name : '';
  switch (reason) {
    case 'rent':
      return `tiền thuê ${name || ''}`.trim();
    case 'tax':
      return `thuế ${TAX_RATE * 100}% tài sản`;
    case 'card':
      return 'theo thẻ';
    case 'fine':
      return 'tiền phạt ra tù';
    case 'repair':
      return 'tiền sửa chữa';
    case 'birthday':
      return 'mừng sinh nhật';
    case 'buy':
      return `mua ${name}`;
    case 'build':
      return `nâng cấp ${name}`;
    case 'sell':
      return `hạ cấp ${name}`;
    case 'salary':
      return 'qua Xuất phát';
    case 'takeover':
      return `mua lại ${name}`;
    default:
      return formatMoney(amount);
  }
}

function readPlayerCount(): number {
  const stored = Number(localStorage.getItem(COUNT_KEY));
  return stored >= 2 && stored <= 4 ? stored : 4;
}

export const useTycoon = create<TycoonState>((set, get) => {
  const refs = {
    state: null as GameState | null,
    replayChain: Promise.resolve(),
    replayEpoch: 0,
    gameRun: 0,
    timer: 0 as ReturnType<typeof setInterval> | 0,
    botTimer: 0 as ReturnType<typeof setTimeout> | 0,
    announceTimer: 0 as ReturnType<typeof setTimeout> | 0,
    toastTimer: 0 as ReturnType<typeof setTimeout> | 0,
    transientTimers: new Set<ReturnType<typeof setTimeout>>(),
    seq: 0,
    lastTick: -1,
    timedOut: false,
  };

  const nextSeq = () => ++refs.seq;

  const stopTimer = () => {
    if (refs.timer) clearInterval(refs.timer);
    refs.timer = 0;
  };

  const cancelBot = () => {
    if (refs.botTimer) clearTimeout(refs.botTimer);
    refs.botTimer = 0;
  };

  const scheduleTransient = (handler: () => void, delay: number) => {
    const timer = setTimeout(() => {
      refs.transientTimers.delete(timer);
      handler();
    }, delay);
    refs.transientTimers.add(timer);
  };

  const clearTransientTimers = () => {
    refs.transientTimers.forEach((timer) => clearTimeout(timer));
    refs.transientTimers.clear();
  };

  const queueReplay = (fn: () => Promise<void>): void => {
    refs.replayChain = refs.replayChain.then(fn).catch(() => undefined);
  };

  const seatName = (seat: number): string => {
    if (seat < 0) return 'Ngân hàng';
    if (seat === get().you) return 'Bạn';
    return get().players[seat]?.name ?? '?';
  };

  const pushLog = (text: string, tone: LogLine['tone'] = 'neutral') => {
    set((state) => ({ log: [...state.log.slice(-79), { seq: nextSeq(), text, tone }] }));
  };

  const floatMoney = (seat: number, amount: number) => {
    if (seat < 0 || amount === 0) return;
    const float: MoneyFloat = { seat, amount, seq: nextSeq() };
    set((state) => ({ moneyFloats: [...state.moneyFloats.slice(-5), float] }));
    scheduleTransient(() => {
      set((state) => ({ moneyFloats: state.moneyFloats.filter((item) => item.seq !== float.seq) }));
    }, 1100);
  };

  const announce = (text: string) => {
    if (refs.announceTimer) clearTimeout(refs.announceTimer);
    set({ turnAnnounce: text });
    refs.announceTimer = setTimeout(() => set({ turnAnnounce: null }), TURN_ANNOUNCE_MS);
  };

  const startTimer = () => {
    stopTimer();
    refs.timer = setInterval(() => {
      const { deadline, boardMode, myTurn, replaying, result } = get();
      if (boardMode !== 'playing' || !deadline || result) return;
      const left = Math.max(0, deadline - Date.now());
      set({ timerLeftMs: left });
      const seconds = Math.ceil(left / 1000);
      if (myTurn && !replaying && seconds <= 10 && seconds > 0 && seconds !== refs.lastTick) {
        refs.lastTick = seconds;
        playSound('tick');
      }
      if (left === 0 && myTurn && !replaying && !refs.timedOut) {
        refs.timedOut = true;
        set({ turnExpired: true });
        const state = refs.state;
        const mv = state ? moveOnTimeout(state, state.turn) : null;
        if (state && mv) {
          get().showToast('Hết giờ — hệ thống đã làm thay bạn');
          applyLocal(state.turn, mv);
        }
      }
    }, 250);
  };

  const armDeadline = (seat: number) => {
    const human = !get().players[seat]?.bot;
    const deadline = human ? Date.now() + TURN_SECONDS * 1000 : 0;
    refs.timedOut = false;
    refs.lastTick = -1;
    set({ deadline, timerLeftMs: human ? TURN_SECONDS * 1000 : 0, turnExpired: false });
  };

  const snapState = (state: GameState, silent = false) => {
    const previousTurn = get().view?.turn;
    const myTurn = state.turn === get().you && !state.finished;
    set({
      view: state,
      positions: state.players.map((p) => p.pos),
      cash: state.players.map((p) => p.cash),
      tiles: state.tiles,
      movePending: false,
      replaying: false,
      myTurn,
      cardFx: state.phase === 'card' && state.card ? get().cardFx ?? { deck: state.card.deck, id: state.card.id, seq: nextSeq() } : null,
      diceFx: { ...get().diceFx, rolling: false },
    });
    armDeadline(state.turn);
    bridge.turnChanged({ yourTurn: myTurn, deadline: get().deadline });
    if (!silent && myTurn && previousTurn !== state.turn) {
      announce('ĐẾN LƯỢT BẠN');
      bridge.attention({ reason: ARCADE_ATTENTION_REASON.YourTurn });
    }
  };

  const replayStep = async (step: Step, epoch: number): Promise<void> => {
    const alive = () => refs.replayEpoch === epoch;
    const fast = reducedMotion();
    const you = get().you;
    switch (step.kind) {
      case 'roll': {
        const values = step.dice ?? [1, 1];
        set({ diceFx: { values, rolling: !fast, double: Boolean(step.double), seq: nextSeq() }, landingTile: -1, pathTiles: [] });
        playSound('dice');
        if (!fast) await sleep(STEP_MS.rollSpin);
        if (!alive()) return;
        set((state) => ({ diceFx: { ...state.diceFx, rolling: false } }));
        await sleep(fast ? 80 : STEP_MS.rollSettle);
        return;
      }
      case 'move': {
        const from = step.from ?? 0;
        const to = step.to ?? from;
        const distance = (to - from + BOARD_SIZE) % BOARD_SIZE;
        if (fast) {
          set((state) => {
            const positions = [...state.positions];
            positions[step.by] = to;
            return { positions, pathTiles: [] };
          });
          await sleep(120);
          return;
        }
        for (let i = 1; i <= distance; i++) {
          if (!alive()) return;
          const pos = (from + i) % BOARD_SIZE;
          set((state) => {
            const positions = [...state.positions];
            positions[step.by] = pos;
            return { positions, pathTiles: [...state.pathTiles.slice(-6), pos] };
          });
          playSound('step');
          await sleep(i > 8 ? STEP_MS.hopFast : STEP_MS.hop);
        }
        scheduleTransient(() => set({ pathTiles: [] }), 600);
        return;
      }
      case 'teleport': {
        set((state) => {
          const positions = [...state.positions];
          positions[step.by] = step.to ?? positions[step.by];
          return { positions };
        });
        await sleep(fast ? 120 : STEP_MS.teleport);
        return;
      }
      case 'land': {
        set({ landingTile: step.tile ?? -1 });
        await sleep(fast ? 60 : STEP_MS.land);
        return;
      }
      case 'pay': {
        const amount = step.amount ?? 0;
        const from = step.by;
        const to = step.target ?? -1;
        set((state) => {
          const cash = [...state.cash];
          if (from >= 0 && cash[from] != null) cash[from] -= amount;
          if (to >= 0 && cash[to] != null) cash[to] += amount;
          return { cash };
        });
        floatMoney(from, -amount);
        floatMoney(to, amount);
        if (from === you) playSound('cash-out');
        else if (to === you) playSound('cash-in');
        const label = reasonLabel(step.reason, amount, step.tile);
        if (from >= 0 && to >= 0) pushLog(`${seatName(from)} trả ${seatName(to)} ${formatMoney(amount)} ${label}`, from === you ? 'down' : to === you ? 'up' : 'neutral');
        else if (from >= 0) pushLog(`${seatName(from)} trả ${formatMoney(amount)} ${label}`, from === you ? 'down' : 'neutral');
        else if (to >= 0) pushLog(`${seatName(to)} nhận ${formatMoney(amount)} ${label}`, to === you ? 'up' : 'neutral');
        await sleep(fast ? 80 : STEP_MS.pay);
        return;
      }
      case 'buy': {
        const tile = step.tile ?? -1;
        if (tile >= 0) {
          set((state) => {
            const tiles = [...state.tiles];
            tiles[tile] = { ...tiles[tile], owner: step.by };
            return { tiles };
          });
          pushLog(`${seatName(step.by)} mua ${BOARD[tile].name}`, step.by === you ? 'up' : 'neutral');
        }
        await sleep(fast ? 60 : STEP_MS.build);
        return;
      }
      case 'card': {
        if (step.deck && step.card) {
          set({ cardFx: { deck: step.deck, id: step.card, seq: nextSeq() } });
          playSound('card');
          const card = cardById(step.card);
          pushLog(`${seatName(step.by)} rút ${step.deck === 'chance' ? 'Cơ hội' : 'Khí vận'}: ${card?.text ?? ''}`);
        }
        await sleep(fast ? 80 : STEP_MS.card);
        return;
      }
      case 'jail-in': {
        set((state) => {
          const positions = [...state.positions];
          positions[step.by] = JAIL_TILE;
          return { positions, jailFxSeat: step.by };
        });
        playSound('jail');
        pushLog(`${seatName(step.by)} vào tù`, step.by === you ? 'down' : 'neutral');
        await sleep(fast ? 100 : STEP_MS.jailIn);
        set({ jailFxSeat: -1 });
        return;
      }
      case 'jail-out': {
        pushLog(`${seatName(step.by)} ra tù`);
        await sleep(fast ? 40 : STEP_MS.jailOut);
        return;
      }
      case 'build':
      case 'sell': {
        const tile = step.tile ?? -1;
        if (tile >= 0) {
          set((state) => {
            const tiles = [...state.tiles];
            tiles[tile] = { ...tiles[tile], houses: step.houses ?? tiles[tile].houses };
            return { tiles };
          });
          if (step.kind === 'build') playSound('build');
          pushLog(`${seatName(step.by)} ${step.kind === 'build' ? 'nâng' : 'hạ'} ${BOARD[tile].name} lên ${levelLabel(step.houses ?? 0)}`.replace(' lên Đất trống', ' về đất trống'));
        }
        await sleep(fast ? 60 : STEP_MS.build);
        return;
      }
      case 'takeover': {
        const tile = step.tile ?? -1;
        if (tile >= 0) {
          set((state) => {
            const tiles = [...state.tiles];
            tiles[tile] = { ...tiles[tile], owner: step.by };
            return { tiles };
          });
          playSound('build');
          pushLog(`${seatName(step.by)} mua lại ${BOARD[tile].name} của ${seatName(step.target ?? -1)}`, step.by === you ? 'up' : step.target === you ? 'down' : 'neutral');
        }
        await sleep(fast ? 60 : STEP_MS.build);
        return;
      }
      case 'festival': {
        const tile = step.tile ?? -1;
        if (tile >= 0) {
          set((state) => (state.view ? { view: { ...state.view, festival: tile } } : {}));
          playSound('build');
          pushLog(`${seatName(step.by)} tổ chức Lễ hội ở ${BOARD[tile].name} — thuê ×${FESTIVAL_MULTIPLIER}`, step.by === you ? 'up' : 'neutral');
        }
        await sleep(fast ? 60 : STEP_MS.build);
        return;
      }
      case 'travel': {
        pushLog(`${seatName(step.by)} được đi Du lịch — lượt sau bay tới ô bất kỳ`, step.by === you ? 'up' : 'neutral');
        await sleep(fast ? 60 : STEP_MS.land);
        return;
      }
      case 'debt': {
        pushLog(`${seatName(step.by)} nợ ${formatMoney(step.amount ?? 0)} ${seatName(step.creditor ?? -1)}`, step.by === you ? 'down' : 'neutral');
        await sleep(fast ? 60 : STEP_MS.debt);
        return;
      }
      case 'bankrupt': {
        set((state) => {
          const tiles = state.tiles.map((t, idx) =>
            (step.tiles ?? []).includes(idx) ? { owner: step.creditor != null && step.creditor >= 0 ? step.creditor : -1, houses: 0 } : t,
          );
          const cash = [...state.cash];
          cash[step.by] = 0;
          return { tiles, cash };
        });
        playSound('bankrupt');
        pushLog(`${seatName(step.by)} phá sản`, step.by === you ? 'down' : 'neutral');
        await sleep(fast ? 120 : STEP_MS.bankrupt);
        return;
      }
      case 'round': {
        const round = step.round ?? 0;
        pushLog(round > MAX_ROUNDS ? 'Hết vòng cuối' : `Vòng ${round}/${MAX_ROUNDS} bắt đầu`);
        if (round === MAX_ROUNDS) announce('VÒNG CUỐI!');
        await sleep(fast ? 60 : STEP_MS.round);
        return;
      }
      default:
        return;
    }
  };

  const replaySteps = async (steps: Step[], epoch: number): Promise<void> => {
    set({ replaying: true });
    for (const step of steps) {
      if (refs.replayEpoch !== epoch) return;
      await replayStep(step, epoch);
    }
  };

  const finishGame = (state: GameState) => {
    const you = get().you;
    const players = get().players;
    const ranked = rankings(state);
    const rows: RankRow[] = ranked.map((seat, i) => ({
      seat,
      place: i + 1,
      name: players[seat]?.name ?? '?',
      worth: worth(state, seat),
      bankrupt: state.players[seat].bankrupt,
    }));
    const myPlace = rows.find((row) => row.seat === you)?.place ?? rows.length;
    const human = state.players[you];
    const winnerName = state.winner === you ? 'Bạn' : players[state.winner]?.name ?? '';
    const reasonText = human.quit
      ? 'Bạn đã bỏ cuộc'
      : state.endReason === 'groups'
        ? `${winnerName} sở hữu trọn ${WIN_GROUPS} nhóm màu — thắng ngay`
        : state.endReason === 'line'
          ? `${winnerName} sở hữu trọn thành phố một cạnh bàn — thắng ngay`
          : state.endReason === 'airports'
            ? `${winnerName} sở hữu cả 4 sân bay — thắng ngay`
          : human.bankrupt
            ? 'Bạn đã phá sản'
            : state.endReason === 'time'
              ? `Hết ${TIME_LIMIT_MS / 60000} phút — xếp hạng theo tổng tài sản`
              : state.endReason === 'rounds'
                ? `Hết ${MAX_ROUNDS} vòng — xếp hạng theo tổng tài sản`
                : 'Chỉ còn một tỷ phú trụ lại';
    const matchSeq = get().matchSeq;
    queueReplay(async () => {
      await sleep(RESULT_REVEAL_MS);
      if (get().matchSeq !== matchSeq || get().boardMode !== 'playing') return;
      playSound(myPlace === 1 ? 'win' : 'lose');
      bridge.gameOver({ matchId: `local-${matchSeq}`, winnerId: players[ranked[0]]?.id, reason: 'win', won: myPlace === 1 });
      bridge.attention({ reason: ARCADE_ATTENTION_REASON.GameOver });
      set({ result: { matchId: `local-${matchSeq}`, rows, myPlace, reasonText }, myTurn: false, sheet: null, cardFx: null, deadline: 0 });
    });
  };

  const scheduleNext = (state: GameState) => {
    cancelBot();
    if (isOver(state)) {
      finishGame(state);
      return;
    }
    const turnStart = state.phase === 'roll' || state.phase === 'jail' || state.phase === 'travel';
    if (turnStart && state.moveCount > 0 && Date.now() - get().startedAt >= TIME_LIMIT_MS) {
      const ended = endByTime(state);
      refs.state = ended;
      snapState(ended, true);
      finishGame(ended);
      return;
    }
    const seat = state.turn;
    if (!get().players[seat]?.bot) return;
    const run = refs.gameRun;
    refs.botTimer = setTimeout(() => {
      refs.botTimer = 0;
      if (run !== refs.gameRun || refs.state !== state) return;
      const mv = botMove(state, seat) ?? moveOnTimeout(state, seat);
      if (mv) applyLocal(seat, mv);
    }, BOT_THINK_MS);
  };

  function applyLocal(seat: number, mv: Move): void {
    const current = refs.state;
    if (!current || get().boardMode !== 'playing') return;
    let next: GameState;
    try {
      next = applyMove(current, seat, mv);
    } catch (error) {
      set({ movePending: false });
      if (seat === get().you) get().showToast(error instanceof RuleError ? RULE_TEXT[error.code] ?? 'Thao tác không hợp lệ' : 'Thao tác không hợp lệ');
      return;
    }
    refs.state = next;
    refs.replayEpoch += 1;
    const epoch = refs.replayEpoch;
    const run = refs.gameRun;
    set({ deadline: 0, timerLeftMs: 0, turnExpired: false, ...(mv.type === 'CARD_ACK' ? { cardFx: null } : {}) });
    queueReplay(async () => {
      if (refs.replayEpoch !== epoch || run !== refs.gameRun) return;
      await replaySteps(next.steps, epoch);
      if (refs.replayEpoch !== epoch || run !== refs.gameRun) return;
      snapState(next);
      scheduleNext(next);
    });
  }

  const leaveToLobby = () => {
    refs.gameRun += 1;
    refs.replayEpoch += 1;
    refs.state = null;
    cancelBot();
    stopTimer();
    clearTransientTimers();
    set({
      boardMode: 'idle',
      view: null,
      positions: [],
      cash: [],
      tiles: [],
      myTurn: false,
      deadline: 0,
      timerLeftMs: 0,
      turnExpired: false,
      turnAnnounce: null,
      movePending: false,
      replaying: false,
      log: [],
      diceFx: emptyDice(),
      cardFx: null,
      landingTile: -1,
      pathTiles: [],
      moneyFloats: [],
      jailFxSeat: -1,
      sheet: null,
      result: null,
      notice: null,
      noticeQueue: [],
    });
  };

  const beginGame = (playerCount: number) => {
    leaveToLobby();
    const count = Math.min(4, Math.max(2, playerCount));
    localStorage.setItem(COUNT_KEY, String(count));
    const players: SeatInfo[] = [{ id: 'you', name: 'Bạn', avatar: avatarIconUrl(null), bot: false }];
    for (let i = 1; i < count; i++) players.push({ id: `bot-${i}`, name: BOT_NAMES[i - 1] ?? `Máy ${i}`, avatar: vipIconUrl(i), bot: true });
    const seed = Math.floor(Math.random() * 2 ** 31) + 1;
    const state = newGame(seed, count);
    refs.state = state;
    set({
      boardMode: 'playing',
      setupOpen: false,
      playerCount: count,
      players,
      you: 0,
      matchSeq: get().matchSeq + 1,
      startedAt: Date.now(),
      log: [],
    });
    snapState(state, true);
    startTimer();
    announce('ĐẾN LƯỢT BẠN');
    playSound('click');
    bridge.attention({ reason: ARCADE_ATTENTION_REASON.MatchStarted, matchId: `local-${get().matchSeq}` });
    scheduleNext(state);
  };

  return {
    profile: MOCK_PROFILE,
    soundOn: localStorage.getItem(SOUND_KEY) !== '0',
    rulesOpen: false,
    setupOpen: false,
    playerCount: readPlayerCount(),

    boardMode: 'idle',
    players: [],
    you: 0,
    view: null,
    positions: [],
    cash: [],
    tiles: [],
    myTurn: false,
    deadline: 0,
    timerLeftMs: 0,
    turnExpired: false,
    turnAnnounce: null,
    movePending: false,
    replaying: false,
    matchSeq: 0,
    startedAt: 0,
    log: [],

    diceFx: emptyDice(),
    cardFx: null,
    landingTile: -1,
    pathTiles: [],
    moneyFloats: [],
    jailFxSeat: -1,
    sheet: null,

    result: null,
    toast: null,
    notice: null,
    noticeId: 0,
    noticeQueue: [],

    init() {
      setSoundEnabled(get().soundOn);
      bridge.ready();
    },

    dispose() {
      leaveToLobby();
      if (refs.announceTimer) clearTimeout(refs.announceTimer);
      if (refs.toastTimer) clearTimeout(refs.toastTimer);
      refs.announceTimer = 0;
      refs.toastTimer = 0;
      set({ toast: null, rulesOpen: false, setupOpen: false });
    },

    toggleSound() {
      const soundOn = !get().soundOn;
      localStorage.setItem(SOUND_KEY, soundOn ? '1' : '0');
      setSoundEnabled(soundOn);
      set({ soundOn });
      if (soundOn) playSound('click');
    },

    exitGame() {
      bridge.exit();
    },

    setRulesOpen(open: boolean) {
      set({ rulesOpen: open });
    },

    setSetupOpen(open: boolean) {
      if (open) playSound('click');
      set({ setupOpen: open });
    },

    startGame(playerCount: number) {
      beginGame(playerCount);
    },

    sendMove(move: Move) {
      const { boardMode, myTurn, movePending, replaying, result } = get();
      if (boardMode !== 'playing' || !myTurn || movePending || replaying || result) return;
      const state = refs.state;
      if (!state || state.turn !== get().you) return;
      playSound('click');
      set({ movePending: true });
      applyLocal(state.turn, move);
    },

    openSheet(sheet: Sheet) {
      if (get().result) return;
      set({ sheet });
    },

    closeSheet() {
      set({ sheet: null });
    },

    forfeitMatch() {
      const state = refs.state;
      if (!state || get().result) return;
      get().showNotice({
        kind: 'confirm',
        tone: 'danger',
        title: 'Bỏ cuộc',
        body: 'Bạn sẽ bị tính phá sản và xếp cuối. Kết thúc ván ngay?',
        okLabel: 'Bỏ cuộc',
        onOk: () => {
          cancelBot();
          refs.replayEpoch += 1;
          const next = quitPlayer(state, get().you);
          next.finished = true;
          refs.state = next;
          set({ view: next, positions: next.players.map((p) => p.pos), cash: next.players.map((p) => p.cash), tiles: next.tiles, replaying: false, movePending: false, myTurn: false, deadline: 0 });
          finishGame(next);
        },
      });
    },

    exitMatch() {
      if (get().result) {
        leaveToLobby();
        return;
      }
      get().showNotice({
        kind: 'confirm',
        tone: 'danger',
        title: 'Về sảnh',
        body: 'Ván đang chơi sẽ bị huỷ. Về sảnh chứ?',
        okLabel: 'Về sảnh',
        onOk: leaveToLobby,
      });
    },

    closeResult() {
      leaveToLobby();
    },

    playAgain() {
      beginGame(get().playerCount);
    },

    showToast(text: string) {
      if (refs.toastTimer) clearTimeout(refs.toastTimer);
      set({ toast: text });
      refs.toastTimer = setTimeout(() => set({ toast: null }), TOAST_MS);
    },

    clearToast() {
      if (refs.toastTimer) clearTimeout(refs.toastTimer);
      refs.toastTimer = 0;
      set({ toast: null });
    },

    showNotice(notice: NoticeState) {
      if (get().notice) {
        set({ noticeQueue: [...get().noticeQueue, notice] });
        return;
      }
      set({ notice, noticeId: get().noticeId + 1 });
    },

    closeNotice(notice: NoticeState) {
      if (get().notice !== notice) return;
      const [next = null, ...rest] = get().noticeQueue;
      set({ notice: next, noticeId: get().noticeId + 1, noticeQueue: rest });
    },
  };
});
