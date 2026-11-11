import { flushSync } from 'react-dom';
import { create } from 'zustand';
import type { TyIconName } from '../components/TyIcon';
import { ARCADE_ATTENTION_REASON } from '@ola/shared/constants';
import { vipIconUrl } from '@ola/shared/lib/vip';
import { bridge, type GameReactionType } from '../../src/sdk';
import { BOARD, cardById, GROUP_LABEL, tilesOfGroup } from '../logic/board';
import { botMove } from '../logic/bot';
import { BOARD_SIZE, FESTIVAL_MULTIPLIER, JAIL_TILE, MAX_ROUNDS, TAX_RATE, TIME_LIMIT_MS, TURN_SECONDS, WIN_GROUPS } from '../logic/constants';
import { applyMove, endByTime, isNewTurn, isOver, moveOnTimeout, newGame, quitPlayer, rankings, worth } from '../logic/engine';
import { RuleError, type BotLevel, type GameState, type Move, type Step, type TileState } from '../logic/types';
import { MAX_BOTS, botName, type BotSetupItem } from '../helpers/bot';
import { formatMoney } from '../helpers/format';
import { botHistoryEntry, saveBotHistory } from '../helpers/history';
import { avatarIconUrl } from '../helpers/player';
import { MOCK_PROFILE, type LobbyProfile } from '../helpers/profile';
import { playSound, setSoundEnabled } from '../audio';
import * as fx from '../fx/boardFx';
import { setTempo, sleep } from '../fx/runtime';

export type BoardMode = 'idle' | 'playing';
export type Sheet = { kind: 'tile'; idx: number } | { kind: 'assets'; seat: number } | { kind: 'log' } | null;

export interface SeatInfo {
  id: string;
  name: string;
  avatar: string;
  bot: boolean;
  level?: BotLevel;
}

export interface DiceFx {
  values: [number, number];
  rolling: boolean;
  double: boolean;
  showTotal: boolean;
  seq: number;
}

export interface FeedLine {
  seq: number;
  text: string;
  tone: LogLine['tone'];
  seat: number;
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
  speed: 1 | 2;
  autoEnd: boolean;
  rulesOpen: boolean;
  setupOpen: boolean;
  roomsOpen: boolean;
  leaderboardOpen: boolean;
  historyOpen: boolean;
  lobbyFocus: string | null;
  lastBots: BotSetupItem[];

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
  movePending: boolean;
  replaying: boolean;
  matchSeq: number;
  startedAt: number;
  log: LogLine[];

  feed: FeedLine | null;
  diceFx: DiceFx;
  cardFx: CardFx | null;
  moneyFloats: MoneyFloat[];
  barsOn: boolean;
  sheet: Sheet;

  result: MatchResultState | null;
  toast: string | null;
  notice: NoticeState | null;
  noticeId: number;
  noticeQueue: NoticeState[];

  init(): void;
  dispose(): void;
  toggleSound(): void;
  setSpeed(speed: 1 | 2): void;
  setAutoEnd(on: boolean): void;
  skipReplay(): void;
  exitGame(): void;
  setRulesOpen(open: boolean): void;
  setSetupOpen(open: boolean): void;
  setRoomsOpen(open: boolean): void;
  setLeaderboardOpen(open: boolean): void;
  setHistoryOpen(open: boolean): void;
  clearLobbyFocus(): void;
  startGame(bots: BotSetupItem[]): void;

  sendMove(move: Move): void;
  sendMoves(moves: Move[]): void;
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
const SPEED_KEY = 'ola:tycoon:speed';
const AUTO_END_KEY = 'ola:tycoon:auto-end';
const BOT_TEMPO = 1.8;
const SKIP_TEMPO = 8;
const TOAST_MS = 2400;
const RESULT_REVEAL_MS = 900;
const SCREEN_IN_MS = 260;
const BOT_DELAY_MS = { card: 950, quick: 150, think: 360 };
const STEP_MS = { land: 300, debt: 320, round: 240 };
const SILENT_PAY_REASONS = new Set(['buy', 'takeover', 'build', 'sell']);

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

function emptyDice(): DiceFx {
  return { values: [1, 1], rolling: false, double: false, showTotal: false, seq: 0 };
}

function readSound(): boolean {
  try {
    return localStorage.getItem(SOUND_KEY) !== '0';
  } catch {
    return true;
  }
}

function readPref(key: string): string | null {
  try {
    return localStorage.getItem(key);
  } catch {
    return null;
  }
}

function writePref(key: string, value: string): void {
  try {
    localStorage.setItem(key, value);
  } catch {
    // WebView chặn storage thì chỉ không nhớ được lựa chọn.
  }
}

function writeSound(on: boolean): void {
  writePref(SOUND_KEY, on ? '1' : '0');
}

function barsFor(state: GameState): boolean {
  return state.players.some((p) => p.inJail && !p.bankrupt);
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

interface LevelUp {
  from: number;
  to: number;
}

export const useTycoon = create<TycoonState>((set, get) => {
  const refs = {
    state: null as GameState | null,
    replayChain: Promise.resolve(),
    replayEpoch: 0,
    gameRun: 0,
    timer: 0 as ReturnType<typeof setInterval> | 0,
    botTimer: 0 as ReturnType<typeof setTimeout> | 0,
    toastTimer: 0 as ReturnType<typeof setTimeout> | 0,
    transientTimers: new Set<ReturnType<typeof setTimeout>>(),
    seq: 0,
    lastTick: -1,
    timedOut: false,
    feedSeat: -1,
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
    const seq = nextSeq();
    set((state) => ({ log: [...state.log.slice(-79), { seq, text, tone }], feed: { seq, text, tone, seat: refs.feedSeat } }));
  };

  const floatMoney = (seat: number, amount: number) => {
    if (seat < 0 || amount === 0) return;
    const float: MoneyFloat = { seat, amount, seq: nextSeq() };
    set((state) => ({ moneyFloats: [...state.moneyFloats.slice(-5), float] }));
    scheduleTransient(() => {
      set((state) => ({ moneyFloats: state.moneyFloats.filter((item) => item.seq !== float.seq) }));
    }, 1100);
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

  const announceTurn = (state: GameState, attention: boolean) => {
    const myTurn = state.turn === get().you && !state.finished;
    armDeadline(state.turn);
    bridge.turnChanged({ yourTurn: myTurn, deadline: get().deadline });
    if (attention && myTurn) bridge.attention({ reason: ARCADE_ATTENTION_REASON.YourTurn });
  };

  // hold giữ bàn ở trạng thái bận và chưa chạy đồng hồ, để băng đổi lượt diễn xong mới cho bấm.
  const snapState = (state: GameState, hold = false) => {
    const previousTurn = get().view?.turn;
    const myTurn = state.turn === get().you && !state.finished;
    flushSync(() =>
      set({
        view: state,
        positions: state.players.map((p) => p.pos),
        cash: state.players.map((p) => p.cash),
        tiles: state.tiles,
        movePending: false,
        replaying: hold,
        myTurn,
        barsOn: barsFor(state),
        cardFx: state.phase === 'card' && state.card ? get().cardFx ?? { deck: state.card.deck, id: state.card.id, seq: nextSeq() } : null,
        diceFx: { ...get().diceFx, rolling: false, showTotal: previousTurn === state.turn && get().diceFx.showTotal },
      }),
    );
    if (hold) set({ deadline: 0, timerLeftMs: 0, turnExpired: false });
    else announceTurn(state, false);
  };

  const turnTip = (state: GameState): string => {
    if (state.phase === 'jail') return 'Bạn đang ở tù, chọn cách ra';
    if (state.phase === 'travel') return 'Chọn ô để bay tới';
    return 'Gieo xúc xắc để đi';
  };

  const playTurnBanner = (state: GameState): Promise<void> => {
    const { you, players } = get();
    if (state.turn !== you) return Promise.resolve();
    return fx.showTurnBanner({ seat: state.turn, mine: state.turn === you, name: seatName(state.turn), avatar: players[state.turn]?.avatar, tip: turnTip(state) });
  };

  const commitPosition = (seat: number, pos: number) => {
    flushSync(() =>
      set((state) => {
        const positions = [...state.positions];
        positions[seat] = pos;
        return { positions };
      }),
    );
  };

  const commitTiles = (update: (tiles: TileState[]) => TileState[]) => {
    flushSync(() => set((state) => ({ tiles: update(state.tiles) })));
  };

  const addCash = (seat: number, amount: number) => {
    if (seat < 0) return;
    set((state) => {
      const cash = [...state.cash];
      if (cash[seat] != null) cash[seat] += amount;
      return { cash };
    });
    floatMoney(seat, amount);
  };

  const withOwner = (tile: number, owner: number) => (tiles: TileState[]) => tiles.map((item, idx) => (idx === tile ? { ...item, owner } : item));

  const stampTile = (tile: number, by: number): Promise<void> => {
    const group = BOARD[tile].kind === 'street' ? BOARD[tile].group : undefined;
    const members = group ? tilesOfGroup(group) : [];
    const complete = group ? members.every((idx) => idx === tile || get().tiles[idx]?.owner === by) : false;
    if (complete && group) pushLog(`${seatName(by)} gom trọn nhóm ${GROUP_LABEL[group]}, thuê ×2`, by === get().you ? 'up' : 'neutral');
    return fx.stampDeed(tile, by, () => commitTiles(withOwner(tile, by)), complete ? members : null);
  };

  const replayStep = async (step: Step, epoch: number, levelUp?: LevelUp): Promise<void> => {
    const alive = () => refs.replayEpoch === epoch;
    const you = get().you;
    switch (step.kind) {
      case 'roll': {
        const values = step.dice ?? [1, 1];
        const double = Boolean(step.double);
        pushLog(`${seatName(step.by)} gieo ${values[0]} + ${values[1]}${double ? ' (đôi!)' : ''}`);
        flushSync(() => set({ diceFx: { values, rolling: true, double, showTotal: false, seq: nextSeq() } }));
        await fx.rollDice(values);
        if (!alive()) return;
        flushSync(() => set((state) => ({ diceFx: { ...state.diceFx, rolling: false, showTotal: true } })));
        await fx.revealDiceTotal(double);
        return;
      }
      case 'move': {
        const from = step.from ?? 0;
        const to = step.to ?? from;
        const { positions, view } = get();
        await fx.walkPawn({
          seat: step.by,
          from,
          count: (to - from + BOARD_SIZE) % BOARD_SIZE,
          positions,
          bankrupt: view?.players.map((p) => p.bankrupt) ?? [],
          turn: view?.turn ?? -1,
          commit: () => commitPosition(step.by, to),
          alive,
        });
        return;
      }
      case 'teleport': {
        const to = step.to ?? get().positions[step.by];
        const toJail = to === JAIL_TILE && step.from !== JAIL_TILE;
        if (toJail) fx.policeWhistle(step.by);
        await fx.flyPawn(step.by, toJail ? '#E4573D' : '#F2B807', () => commitPosition(step.by, to));
        return;
      }
      case 'land': {
        const tile = step.tile ?? 0;
        fx.landOnTile(tile, step.by, get().tiles[tile]?.owner ?? -1);
        await sleep(STEP_MS.land);
        return;
      }
      case 'pay': {
        const amount = step.amount ?? 0;
        const from = step.by;
        const to = step.target ?? -1;
        const label = reasonLabel(step.reason, amount, step.tile);
        if (SILENT_PAY_REASONS.has(step.reason ?? '')) {
          // Bước mua/nâng ngay sau đã tự ghi diễn biến, không ghi trùng.
        } else if (from >= 0 && to >= 0) pushLog(`${seatName(from)} trả ${seatName(to)} ${formatMoney(amount)} ${label}`, from === you ? 'down' : to === you ? 'up' : 'neutral');
        else if (from >= 0) pushLog(`${seatName(from)} trả ${formatMoney(amount)} ${label}`, from === you ? 'down' : 'neutral');
        else if (to >= 0) pushLog(`${seatName(to)} nhận ${formatMoney(amount)} ${label}`, to === you ? 'up' : 'neutral');
        await fx.payMoney({ from, to, amount, reason: step.reason, tile: step.tile, debit: () => addCash(from, -amount), credit: () => addCash(to, amount) });
        return;
      }
      case 'buy': {
        const tile = step.tile ?? -1;
        if (tile < 0) return;
        pushLog(`${seatName(step.by)} mua ${BOARD[tile].name}`, step.by === you ? 'up' : 'neutral');
        await stampTile(tile, step.by);
        return;
      }
      case 'takeover': {
        const tile = step.tile ?? -1;
        if (tile < 0) return;
        pushLog(`${seatName(step.by)} mua lại ${BOARD[tile].name} của ${seatName(step.target ?? -1)}`, step.by === you ? 'up' : step.target === you ? 'down' : 'neutral');
        await stampTile(tile, step.by);
        return;
      }
      case 'card': {
        if (!step.deck || !step.card) return;
        const { deck, card } = step;
        pushLog(`${seatName(step.by)} rút ${deck === 'chance' ? 'Cơ hội' : 'Khí vận'}: ${cardById(card)?.text ?? ''}`);
        await fx.shakeDeck(deck);
        if (!alive()) return;
        flushSync(() => set({ cardFx: { deck, id: card, seq: nextSeq() } }));
        await fx.flyCardIn(deck);
        return;
      }
      case 'jail-in': {
        commitPosition(step.by, JAIL_TILE);
        flushSync(() => set({ barsOn: true }));
        pushLog(`${seatName(step.by)} vào tù`, step.by === you ? 'down' : 'neutral');
        await fx.jailDoorClose(step.by);
        return;
      }
      case 'jail-out': {
        pushLog(`${seatName(step.by)} ra tù`);
        await fx.jailDoorOpen();
        const stillJailed = get().view?.players.some((p, seat) => seat !== step.by && p.inJail && !p.bankrupt) ?? false;
        set({ barsOn: stillJailed });
        return;
      }
      case 'build': {
        const tile = step.tile ?? -1;
        if (tile < 0) return;
        const houses = step.houses ?? 0;
        if (levelUp) pushLog(`${seatName(step.by)} nâng cấp ${BOARD[tile].name}: Lv${levelUp.from} → Lv${levelUp.to}`);
        commitTiles((tiles) => tiles.map((item, idx) => (idx === tile ? { ...item, houses } : item)));
        await fx.buildHouse(tile, houses, step.by, levelUp);
        return;
      }
      case 'sell': {
        const tile = step.tile ?? -1;
        if (tile < 0) return;
        const houses = step.houses ?? 0;
        pushLog(`${seatName(step.by)} hạ cấp ${BOARD[tile].name}: Lv${houses + 1} → Lv${houses}`);
        await fx.sellHouse(tile, step.by, houses);
        commitTiles((tiles) => tiles.map((item, idx) => (idx === tile ? { ...item, houses } : item)));
        return;
      }
      case 'festival': {
        const tile = step.tile ?? -1;
        if (tile < 0) return;
        flushSync(() => set((state) => (state.view ? { view: { ...state.view, festival: tile } } : {})));
        pushLog(`${seatName(step.by)} tổ chức Lễ hội ở ${BOARD[tile].name} — thuê ×${FESTIVAL_MULTIPLIER}`, step.by === you ? 'up' : 'neutral');
        await fx.celebrateFestival(tile);
        return;
      }
      case 'travel': {
        pushLog(`${seatName(step.by)} được đi Du lịch — lượt sau bay tới ô bất kỳ`, step.by === you ? 'up' : 'neutral');
        await fx.travelWiggle();
        return;
      }
      case 'debt': {
        pushLog(`${seatName(step.by)} nợ ${formatMoney(step.amount ?? 0)} ${seatName(step.creditor ?? -1)}`, step.by === you ? 'down' : 'neutral');
        fx.debtAlarm(step.by);
        await sleep(STEP_MS.debt);
        return;
      }
      case 'bankrupt': {
        const lost = step.tiles ?? [];
        pushLog(`${seatName(step.by)} phá sản`, step.by === you ? 'down' : 'neutral');
        await fx.bankruptSeat(step.by, seatName(step.by), lost);
        if (!alive()) return;
        flushSync(() =>
          set((state) => {
            const cash = [...state.cash];
            cash[step.by] = 0;
            return {
              cash,
              tiles: state.tiles.map((t, idx) => (lost.includes(idx) ? { owner: step.creditor != null && step.creditor >= 0 ? step.creditor : -1, houses: 0 } : t)),
            };
          }),
        );
        return;
      }
      case 'round': {
        const round = step.round ?? 0;
        set((state) => ({
          log: [...state.log.slice(-79), { seq: nextSeq(), text: round > MAX_ROUNDS ? 'Hết vòng cuối' : `Vòng ${round}/${MAX_ROUNDS} bắt đầu`, tone: 'neutral' }],
          view: state.view ? { ...state.view, round } : state.view,
        }));
        fx.flipRound(round === MAX_ROUNDS);
        await sleep(STEP_MS.round);
        return;
      }
      default:
        return;
    }
  };

  const replaySteps = async (steps: Step[], epoch: number): Promise<void> => {
    flushSync(() => set({ replaying: true }));
    const levelUps = new Map<number, LevelUp>();
    const firstLevel = new Map<number, number>();
    const lastBuild = new Map<number, number>();
    steps.forEach((step, i) => {
      if (step.kind !== 'build' || step.tile == null) return;
      const to = step.houses ?? 0;
      if (!firstLevel.has(step.tile)) firstLevel.set(step.tile, to - 1);
      const previous = lastBuild.get(step.tile);
      if (previous != null) levelUps.delete(previous);
      levelUps.set(i, { from: firstLevel.get(step.tile) ?? to - 1, to });
      lastBuild.set(step.tile, i);
    });
    for (const [i, step] of steps.entries()) {
      if (refs.replayEpoch !== epoch) return;
      refs.feedSeat = step.kind === 'pay' && step.by < 0 ? step.target ?? -1 : step.by ?? -1;
      await replayStep(step, epoch, levelUps.get(i));
    }
    fx.clearMovingPawns();
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
    const profile = get().profile;
    if (profile) saveBotHistory(profile.id, botHistoryEntry(state, ranked, you, profile, get().lastBots, Date.now()));
    queueReplay(async () => {
      await sleep(RESULT_REVEAL_MS);
      if (get().matchSeq !== matchSeq || get().boardMode !== 'playing') return;
      playSound(myPlace === 1 ? 'win' : 'lose');
      fx.celebrateResult(myPlace === 1, ranked[0]);
      bridge.gameOver({ matchId: `local-${matchSeq}`, winnerId: players[ranked[0]]?.id, reason: 'win', won: myPlace === 1 });
      bridge.attention({ reason: ARCADE_ATTENTION_REASON.GameOver });
      set({ result: { matchId: `local-${matchSeq}`, rows, myPlace, reasonText }, myTurn: false, sheet: null, cardFx: null, deadline: 0 });
    });
  };

  const scheduleNext = (state: GameState, newTurn = false) => {
    cancelBot();
    if (isOver(state)) {
      finishGame(state);
      return;
    }
    if (newTurn && Date.now() - get().startedAt >= TIME_LIMIT_MS) {
      const ended = endByTime(state);
      refs.state = ended;
      snapState(ended);
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
    }, (state.phase === 'card' ? BOT_DELAY_MS.card : state.phase === 'manage' || state.phase === 'roll' ? BOT_DELAY_MS.quick : BOT_DELAY_MS.think) / get().speed);
  };

  function applyLocal(seat: number, moves: Move | Move[]): void {
    const current = refs.state;
    if (!current || get().boardMode !== 'playing') return;
    const list = Array.isArray(moves) ? moves : [moves];
    const mv = list[0];
    if (!mv) return;
    let next: GameState = current;
    try {
      const steps: GameState['steps'] = [];
      for (const move of list) {
        next = applyMove(next, seat, move);
        steps.push(...next.steps);
      }
      next = { ...next, steps };
    } catch (error) {
      set({ movePending: false });
      if (seat === get().you) get().showToast(error instanceof RuleError ? RULE_TEXT[error.code] ?? 'Thao tác không hợp lệ' : 'Thao tác không hợp lệ');
      return;
    }
    refs.state = next;
    refs.replayEpoch += 1;
    const epoch = refs.replayEpoch;
    const run = refs.gameRun;
    const newTurn = isNewTurn(current, next);
    set({ deadline: 0, timerLeftMs: 0, turnExpired: false });
    queueReplay(async () => {
      const stale = () => refs.replayEpoch !== epoch || run !== refs.gameRun;
      if (stale()) return;
      setTempo((get().players[seat]?.bot ? BOT_TEMPO : 1) * get().speed);
      const openCard = mv.type === 'CARD_ACK' ? get().cardFx : null;
      if (openCard) {
        flushSync(() => set({ replaying: true }));
        await fx.flyCardBack(openCard.deck);
        if (stale()) return;
        flushSync(() => set({ cardFx: null }));
      }
      await replaySteps(next.steps, epoch);
      if (stale()) return;
      const turnChanged = newTurn && !isOver(next);
      snapState(next, turnChanged);
      if (turnChanged) {
        refs.feedSeat = -1;
        set({ feed: null });
        await playTurnBanner(next);
        if (stale()) return;
        flushSync(() => set({ replaying: false }));
        announceTurn(next, true);
      }
      scheduleNext(next, newTurn);
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
      movePending: false,
      replaying: false,
      log: [],
      feed: null,
      diceFx: emptyDice(),
      cardFx: null,
      moneyFloats: [],
      barsOn: false,
      sheet: null,
      result: null,
      notice: null,
      noticeQueue: [],
    });
  };

  const beginGame = (bots: BotSetupItem[]) => {
    if (bots.length === 0) return;
    leaveToLobby();
    const lineup = bots.slice(0, MAX_BOTS);
    const players: SeatInfo[] = [
      { id: 'you', name: 'Bạn', avatar: avatarIconUrl(null), bot: false },
      ...lineup.map((item, index) => ({ id: item.id, name: botName(index), avatar: vipIconUrl(item.vip), bot: true, level: item.level })),
    ];
    const count = players.length;
    const seed = Math.floor(Math.random() * 2 ** 31) + 1;
    const state = newGame(seed, count);
    refs.state = state;
    set({
      boardMode: 'playing',
      setupOpen: false,
      lastBots: lineup.map((item) => ({ ...item })),
      players,
      you: 0,
      matchSeq: get().matchSeq + 1,
      startedAt: Date.now(),
      log: [],
    });
    const run = refs.gameRun;
    snapState(state, true);
    startTimer();
    playSound('click');
    bridge.attention({ reason: ARCADE_ATTENTION_REASON.MatchStarted, matchId: `local-${get().matchSeq}` });
    queueReplay(async () => {
      await sleep(SCREEN_IN_MS);
      if (run !== refs.gameRun) return;
      await playTurnBanner(state);
      if (run !== refs.gameRun) return;
      flushSync(() => set({ replaying: false }));
      announceTurn(state, false);
      scheduleNext(state);
    });
  };

  return {
    profile: MOCK_PROFILE,
    soundOn: readSound(),
    speed: readPref(SPEED_KEY) === '2' ? 2 : 1,
    autoEnd: readPref(AUTO_END_KEY) !== '0',
    rulesOpen: false,
    setupOpen: false,
    roomsOpen: false,
    leaderboardOpen: false,
    historyOpen: false,
    lobbyFocus: null,
    lastBots: [],

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
    movePending: false,
    replaying: false,
    matchSeq: 0,
    startedAt: 0,
    log: [],

    feed: null,
    diceFx: emptyDice(),
    cardFx: null,
    moneyFloats: [],
    barsOn: false,
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
      if (refs.toastTimer) clearTimeout(refs.toastTimer);
      refs.toastTimer = 0;
      set({ toast: null, rulesOpen: false, setupOpen: false, roomsOpen: false, leaderboardOpen: false, historyOpen: false, lobbyFocus: null });
    },

    setSpeed(speed: 1 | 2) {
      writePref(SPEED_KEY, String(speed));
      set({ speed });
    },

    setAutoEnd(on: boolean) {
      writePref(AUTO_END_KEY, on ? '1' : '0');
      set({ autoEnd: on });
    },

    skipReplay() {
      if (get().replaying) setTempo(SKIP_TEMPO);
    },

    toggleSound() {
      const soundOn = !get().soundOn;
      writeSound(soundOn);
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

    setRoomsOpen(open: boolean) {
      if (open) playSound('click');
      set({ roomsOpen: open });
    },

    setLeaderboardOpen(open: boolean) {
      if (open) playSound('click');
      set({ leaderboardOpen: open, lobbyFocus: open ? null : 'leaderboard' });
    },

    setHistoryOpen(open: boolean) {
      if (open) playSound('click');
      set({ historyOpen: open, lobbyFocus: open ? null : 'history' });
    },

    clearLobbyFocus() {
      set({ lobbyFocus: null });
    },

    startGame(bots: BotSetupItem[]) {
      beginGame(bots);
    },

    sendMove(move: Move) {
      get().sendMoves([move]);
    },

    sendMoves(moves: Move[]) {
      const { boardMode, myTurn, movePending, replaying, result } = get();
      if (boardMode !== 'playing' || !myTurn || movePending || replaying || result || moves.length === 0) return;
      const state = refs.state;
      if (!state || state.turn !== get().you) return;
      playSound('click');
      set({ movePending: true });
      applyLocal(state.turn, moves);
    },

    openSheet(sheet: Sheet) {
      if (get().result) return;
      set({ sheet });
    },

    closeSheet() {
      set({ sheet: null });
    },

    forfeitMatch() {
      if (!refs.state || get().result) return;
      get().showNotice({
        kind: 'confirm',
        tone: 'danger',
        title: 'Bỏ cuộc',
        body: 'Bạn sẽ bị tính phá sản và xếp cuối. Kết thúc ván ngay?',
        okLabel: 'Bỏ cuộc',
        onOk: () => {
          const state = refs.state;
          if (!state || isOver(state) || get().result) return;
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
      beginGame(get().lastBots);
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
      if (get().notice !== notice) {
        set({ noticeQueue: get().noticeQueue.filter((queued) => queued !== notice) });
        return;
      }
      const [next = null, ...rest] = get().noticeQueue;
      set({ notice: next, noticeId: get().noticeId + 1, noticeQueue: rest });
    },
  };
});
