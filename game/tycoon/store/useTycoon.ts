import { flushSync } from 'react-dom';
import { create } from 'zustand';
import type { TyIconName } from '../components/TyIcon';
import { ARCADE_ATTENTION_REASON } from '@ola/shared/constants';
import { vipIconUrl } from '@ola/shared/lib/vip';
import { bridge, joinGame, SPECTATE_LEFT_REASON, type ChatMessageData, type ErrorData, type GameReactionType, type GameSession, type MatchFoundData, type MatchOverData, type PlayerInfo, type RoomStateData, type StateData } from '../../src/sdk';
import { BOARD, cardById, GROUP_LABEL, tilesOfGroup } from '../logic/board';
import { BOARD_SIZE, FESTIVAL_MULTIPLIER, GAME_ID, JAIL_TILE, MAX_ROUNDS, TAX_RATE, TIME_LIMIT_MS, WIN_GROUPS } from '../logic/constants';
import { worth } from '../logic/engine';
import { currentRent, winningTiles } from '../logic/rules-hint';
import type { BotLevel, Move, Step, TileState, TycoonView } from '../logic/types';
import { MAX_BOTS, botName, type BotSetupItem } from '../helpers/bot';
import { errorText, roomClosedText } from '../helpers/errorText';
import { formatMoney } from '../helpers/format';
import { botHistoryEntry, saveBotHistory } from '../helpers/history';
import { avatarIconUrl } from '../helpers/player';
import { houseArt } from '../components/art';
import { MOCK_PROFILE, type LobbyProfile } from '../helpers/profile';
import { createPracticeSession, type PracticeSession } from '../practice';
import { playSound, setSoundEnabled } from '../audio';
import * as fx from '../fx/boardFx';
import { setTempo, sleep } from '../fx/runtime';

type TycoonSession = GameSession<TycoonView, Move>;

export type BoardMode = 'idle' | 'playing';
export type Sheet = { kind: 'tile'; idx: number } | { kind: 'assets'; seat: number } | { kind: 'log' } | { kind: 'chat' } | null;

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

type MatchEntry = Pick<MatchFoundData<TycoonView>, 'matchId' | 'state' | 'deadline' | 'you' | 'resumed'>;

export interface MatchResultState {
  matchId: string;
  rows: RankRow[];
  myPlace: number;
  reasonText: string;
  kenDelta?: number;
  exp?: number;
  spectator?: boolean;
}

export type OnlineStatus = 'connecting' | 'ready' | 'offline';

export type NoticeKind = 'confirm' | 'notice';
export type NoticeTone = 'default' | 'danger' | 'info' | 'success' | 'warning' | 'error';

export interface NoticeState {
  kind: NoticeKind;
  tone?: NoticeTone;
  kicker?: string;
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
  online: OnlineStatus;
  room: RoomStateData | null;
  roomChat: ChatMessageData[];
  matchChat: ChatMessageData[];
  chatUnread: boolean;
  reactionFx: ReactionFloat | null;
  awaySeats: Record<number, number>;
  selfDisconnected: boolean;
  spectating: boolean;
  spectators: number;
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
  view: TycoonView | null;
  matchId: string;
  practice: boolean;
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
  winFx: { seat: number; tiles: number[] } | null;
  toast: string | null;
  notice: NoticeState | null;
  noticeId: number;
  noticeQueue: NoticeState[];

  init(): void;
  dispose(): void;
  watchMatch(matchId: string): boolean;
  connect(): void;
  session(): TycoonSession | null;
  leaveRoom(): void;
  setReady(ready: boolean): void;
  startRoom(): void;
  kickMember(userId: string): void;
  sendRoomChat(text: string): void;
  sendMatchChat(text: string): void;
  sendReaction(type: GameReactionType): void;
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
  announce(text: string, tone: LogLine['tone']): void;
  clearToast(): void;
  showNotice(notice: NoticeState): void;
  closeNotice(notice: NoticeState): void;
}

const SOUND_KEY = 'ola:tycoon:sound';
const SPEED_KEY = 'ola:tycoon:speed';
const AUTO_END_KEY = 'ola:tycoon:auto-end';
const BOT_TEMPO = 1.8;
const SKIP_TEMPO = 8;
const CATCHUP_TEMPO = 4;
const TOAST_MS = 2400;
const RESULT_REVEAL_MS = 900;
const WIN_REVEAL_MS = 2400;
const SPECTATE_ENDED_TEXT = 'Đã thôi xem ván';
const SCREEN_IN_MS = 260;
const STEP_MS = { land: 300, debt: 320, round: 240 };
const SILENT_PAY_REASONS = new Set(['buy', 'takeover', 'build', 'sell']);

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

function barsFor(state: TycoonView): boolean {
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

interface LevelChange {
  from: number;
  to: number;
}

export const useTycoon = create<TycoonState>((set, get) => {
  const refs = {
    practice: null as PracticeSession | null,
    session: null as TycoonSession | null,
    sessionUnsubs: [] as Array<() => void>,
    connecting: false,
    disposed: false,
    leftMatchId: '',
    handledMatches: [] as string[],
    matchUnsubs: [] as Array<() => void>,
    incoming: null as TycoonView | null,
    queuedStates: 0,
    pendingMoves: [] as Move[],
    batchLevels: new Map<string, number>(),
    replayChain: Promise.resolve(),
    replayEpoch: 0,
    timer: 0 as ReturnType<typeof setInterval> | 0,
    toastTimer: 0 as ReturnType<typeof setTimeout> | 0,
    transientTimers: new Set<ReturnType<typeof setTimeout>>(),
    seq: 0,
    lastTick: -1,
    timedOut: false,
    feedSeat: -1,
  };

  const matchSession = (): TycoonSession | null => refs.practice ?? refs.session;

  const markMatch = (id: string): boolean => {
    if (refs.handledMatches.includes(id)) return false;
    refs.handledMatches = [...refs.handledMatches.slice(-63), id];
    return true;
  };

  const nextSeq = () => ++refs.seq;

  const stopTimer = () => {
    if (refs.timer) clearInterval(refs.timer);
    refs.timer = 0;
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
        refs.pendingMoves = [];
        set({ turnExpired: true });
        get().showToast('Hết giờ — hệ thống đã làm thay bạn');
      }
    }, 250);
  };

  const announceTurn = (state: TycoonView, deadline: number, attention: boolean) => {
    const myTurn = state.turn === get().you && !state.finished;
    refs.timedOut = false;
    refs.lastTick = -1;
    const left = deadline > 0 ? Math.max(0, deadline - Date.now()) : 0;
    set({ deadline: myTurn ? deadline : 0, timerLeftMs: myTurn ? left : 0, turnExpired: false });
    bridge.turnChanged({ yourTurn: myTurn, deadline });
    if (attention && myTurn) bridge.attention({ reason: ARCADE_ATTENTION_REASON.YourTurn });
  };

  const snapState = (state: TycoonView) => {
    const previousTurn = get().view?.turn;
    const myTurn = state.turn === get().you && !state.finished;
    flushSync(() =>
      set({
        view: state,
        positions: state.players.map((p) => p.pos),
        cash: state.players.map((p) => p.cash),
        tiles: state.tiles,
        movePending: false,
        replaying: true,
        myTurn,
        barsOn: barsFor(state),
        cardFx: state.phase === 'card' && state.card ? get().cardFx ?? { deck: state.card.deck, id: state.card.id, seq: nextSeq() } : null,
        diceFx: { ...get().diceFx, rolling: false, showTotal: previousTurn === state.turn && get().diceFx.showTotal },
        deadline: 0,
        timerLeftMs: 0,
        turnExpired: false,
      }),
    );
  };

  const turnTip = (state: TycoonView): string => {
    if (state.phase === 'jail') return 'Bạn đang ở tù, chọn cách ra';
    if (state.phase === 'travel') return 'Chọn ô để bay tới';
    return 'Gieo xúc xắc để đi';
  };

  const playTurnBanner = (state: TycoonView): Promise<void> => {
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

  const bankruptReport = (creditor: number, amount?: number): NoticeState => {
    const { view, tiles, cash, positions, you } = get();
    const pos = (((positions[you] ?? 0) % BOARD_SIZE) + BOARD_SIZE) % BOARD_SIZE;
    const owed =
      amount ??
      (view?.debt?.by === you
        ? view.debt.amount
        : creditor >= 0 && view && BOARD[pos].kind === 'street' && tiles[pos]?.owner === creditor
          ? currentRent({ ...view, tiles }, pos)
          : null);
    const money = cash[you] ?? 0;
    const houses = tiles.reduce((sum, t, idx) => (t.owner === you ? sum + Math.floor((t.houses * (BOARD[idx].houseCost ?? 0)) / 2) : sum), 0);
    const to = creditor >= 0 ? seatName(creditor) : 'ngân hàng';
    return {
      kind: 'notice',
      tone: 'danger',
      icon: 'warning',
      kicker: 'Bạn bị loại',
      title: 'Bạn phá sản',
      body: `${owed != null ? `Phải trả ${to} ${formatMoney(owed)}` : `Không đủ trả cho ${to}`}, nhưng tiền mặt ${formatMoney(money)} + bán hết nhà ${formatMoney(houses)} chỉ được ${formatMoney(money + houses)}.`,
      hint: 'Đất của bạn chuyển cho người nhận nợ. Bạn có thể xem tiếp ván hoặc về sảnh.',
      okLabel: 'Xem tiếp',
    };
  };

  const replayStep = async (step: Step, epoch: number, levelChange?: LevelChange): Promise<void> => {
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
        const payerPos = step.reason === 'rent' && from >= 0 ? get().positions[from] : undefined;
        const rentTile = payerPos != null ? ((payerPos % BOARD_SIZE) + BOARD_SIZE) % BOARD_SIZE : undefined;
        if (rentTile != null) fx.tileCallout(rentTile, to, `${seatName(from)} trả thuê`, formatMoney(amount), from === you ? 'down' : to === you ? 'up' : 'neutral');
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
        const houses = step.houses ?? 0;
        pushLog(`${seatName(step.by)} mua lại ${BOARD[tile].name} của ${seatName(step.target ?? -1)}`, step.by === you ? 'up' : step.target === you ? 'down' : 'neutral');
        fx.tileCallout(tile, step.by, step.target === you ? `${seatName(step.by)} mua lại ô của bạn` : `${seatName(step.by)} mua lại`, `Lv${houses}`, step.target === you ? 'down' : step.by === you ? 'up' : 'neutral', houseArt(houses));
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
        if (levelChange) pushLog(`${seatName(step.by)} nâng cấp ${BOARD[tile].name}: Lv${levelChange.from} → Lv${levelChange.to}`);
        commitTiles((tiles) => tiles.map((item, idx) => (idx === tile ? { ...item, houses } : item)));
        await fx.buildHouse(tile, houses, step.by, levelChange);
        return;
      }
      case 'sell': {
        const tile = step.tile ?? -1;
        if (tile < 0) return;
        const houses = step.houses ?? 0;
        if (levelChange) pushLog(`${seatName(step.by)} hạ cấp ${BOARD[tile].name}: Lv${levelChange.from} → Lv${levelChange.to}`);
        await fx.sellHouse(tile, step.by, levelChange);
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
        const report = step.by === you ? bankruptReport(step.creditor ?? -1, step.amount) : null;
        pushLog(`${seatName(step.by)} phá sản`, step.by === you ? 'down' : 'neutral');
        await fx.bankruptSeat(step.by, seatName(step.by), lost);
        if (!alive()) return;
        if (report && !refs.incoming?.finished) get().showNotice(report);
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

  const replaySteps = async (steps: Step[], epoch: number, batchContinues: boolean): Promise<void> => {
    flushSync(() => set({ replaying: true }));
    const levelChanges = new Map<number, LevelChange>();
    const firstLevel = new Map<string, number>(refs.batchLevels);
    const lastChange = new Map<string, number>();
    steps.forEach((step, i) => {
      if ((step.kind !== 'build' && step.kind !== 'sell') || step.tile == null) return;
      const key = `${step.kind}:${step.tile}`;
      const to = step.houses ?? 0;
      const before = step.kind === 'build' ? to - 1 : to + 1;
      if (!firstLevel.has(key)) firstLevel.set(key, before);
      const previous = lastChange.get(key);
      if (previous != null) levelChanges.delete(previous);
      levelChanges.set(i, { from: firstLevel.get(key) ?? before, to });
      lastChange.set(key, i);
    });
    if (batchContinues) {
      refs.batchLevels = firstLevel;
      levelChanges.clear();
    } else refs.batchLevels = new Map();
    for (const [i, step] of steps.entries()) {
      if (refs.replayEpoch !== epoch) return;
      refs.feedSeat = step.kind === 'pay' && step.by < 0 ? step.target ?? -1 : step.by ?? -1;
      await replayStep(step, epoch, levelChanges.get(i));
    }
    fx.clearMovingPawns();
  };

  const seatOf = (userId: string | undefined): number => (userId ? get().players.findIndex((p) => p.id === userId) : -1);

  const reasonFor = (state: TycoonView, winnerName: string): string => {
    const human = state.players[get().you];
    if (human?.quit) return 'Bạn đã bỏ cuộc';
    if (state.endReason === 'groups') return `${winnerName} sở hữu trọn ${WIN_GROUPS} nhóm màu — thắng ngay`;
    if (state.endReason === 'line') return `${winnerName} sở hữu trọn thành phố một cạnh bàn — thắng ngay`;
    if (state.endReason === 'airports') return `${winnerName} sở hữu cả 4 sân bay — thắng ngay`;
    if (human?.bankrupt) return 'Bạn đã phá sản';
    if (state.endReason === 'time') return `Hết ${TIME_LIMIT_MS / 60000} phút — xếp hạng theo tổng tài sản`;
    if (state.endReason === 'rounds') return `Hết ${MAX_ROUNDS} vòng — xếp hạng theo tổng tài sản`;
    return 'Chỉ còn một tỷ phú trụ lại';
  };

  const handleMatchOver = (data: MatchOverData<TycoonView>) => {
    if (data.matchId === refs.leftMatchId || data.matchId !== get().matchId || !markMatch(`over:${data.matchId}`)) return;
    const epoch = refs.replayEpoch;
    queueReplay(async () => {
      if (epoch !== refs.replayEpoch) return;
      const state = data.state;
      snapState(state);
      const { you, players, practice } = get();
      const ranked = (data.rankings ?? []).slice().sort((x, y) => x.place - y.place).map((entry) => seatOf(entry.userId)).filter((seat) => seat >= 0);
      const order = ranked.length > 0 ? ranked : state.players.map((_, seat) => seat);
      const rows: RankRow[] = order.map((seat, i) => ({
        seat,
        place: i + 1,
        name: players[seat]?.name ?? '?',
        worth: worth(state, seat),
        bankrupt: state.players[seat]?.bankrupt ?? false,
      }));
      const spectator = get().spectating;
      const myPlace = spectator ? 0 : (rows.find((row) => row.seat === you)?.place ?? rows.length);
      const winnerName = state.winner === you ? 'Bạn' : players[state.winner]?.name ?? '';
      const profile = get().profile;
      if (practice && profile) saveBotHistory(profile.id, botHistoryEntry(state, order, you, profile, get().lastBots, Date.now()));
      const winTiles = state.winner >= 0 ? winningTiles(state, state.winner, state.endReason) : [];
      if (winTiles.length > 0) {
        set({ winFx: { seat: state.winner, tiles: winTiles } });
        void fx.winBanner(`${winnerName === 'Bạn' ? 'BẠN' : winnerName.toUpperCase()} THẮNG!`);
        await new Promise((resolve) => setTimeout(resolve, WIN_REVEAL_MS));
      } else await sleep(RESULT_REVEAL_MS);
      if (epoch !== refs.replayEpoch || get().boardMode !== 'playing') return;
      playSound(myPlace === 1 || spectator ? 'win' : 'lose');
      fx.celebrateResult(myPlace === 1, order[0] ?? 0);
      bridge.gameOver({ matchId: data.matchId, winnerId: data.winnerId, reason: data.reason, won: myPlace === 1 });
      bridge.attention({ reason: ARCADE_ATTENTION_REASON.GameOver });
      const meId = players[you]?.id;
      const exp = data.expGains?.find((entry) => entry.userId === meId)?.exp;
      const kenDelta = practice || !data.bet ? undefined : myPlace === 1 ? (data.kenDelta ?? data.payout ?? 0) : -data.bet;
      if (!practice && !spectator) bridge.refreshUser();
      set({
        result: { matchId: data.matchId, rows, myPlace, reasonText: reasonFor(state, winnerName), ...(spectator ? { spectator } : { kenDelta, exp }) },
        myTurn: false,
        replaying: false,
        sheet: null,
        cardFx: null,
        deadline: 0,
      });
    });
  };

  const sendNow = (move: Move) => {
    const session = matchSession();
    if (!session) return;
    set({ movePending: true });
    session.sendMove(get().matchId, move);
  };

  const settle = (state: TycoonView, serverDeadline: number, turnChanged: boolean) => {
    flushSync(() => set({ replaying: false }));
    if (state.finished) return;
    const deadline = refs.practice ? refs.practice.idle() : serverDeadline;
    announceTurn(state, deadline, turnChanged);
    const next = refs.pendingMoves.shift();
    if (next && state.turn === get().you && !get().turnExpired) sendNow(next);
    else refs.pendingMoves = [];
  };

  const handleState = (data: StateData<TycoonView, Move>) => {
    if (data.matchId !== get().matchId) return;
    const epoch = refs.replayEpoch;
    refs.queuedStates += 1;
    queueReplay(async () => {
      refs.queuedStates -= 1;
      if (epoch !== refs.replayEpoch) return;
      const next = data.state;
      const before = get().view;
      const stale = () => epoch !== refs.replayEpoch;
      const behind = () => refs.queuedStates > 0;
      refs.incoming = next;
      setTempo(behind() ? CATCHUP_TEMPO : (get().players[data.lastBy]?.bot ? BOT_TEMPO : 1) * get().speed);
      set({ deadline: 0, timerLeftMs: 0, turnExpired: false });
      const openCard = data.lastMove?.type === 'CARD_ACK' ? get().cardFx : null;
      if (openCard) {
        flushSync(() => set({ replaying: true }));
        await fx.flyCardBack(openCard.deck);
        if (stale()) return;
        flushSync(() => set({ cardFx: null }));
      }
      const batchContinues = data.lastBy === get().you && refs.pendingMoves.length > 0;
      await replaySteps(next.steps ?? [], epoch, batchContinues);
      if (stale()) return;
      refs.incoming = null;
      const turnChanged = before != null && before.turn !== next.turn && !next.finished;
      snapState(next);
      if (turnChanged) {
        refs.feedSeat = -1;
        set({ feed: null });
        if (!behind()) await playTurnBanner(next);
        if (stale()) return;
      }
      settle(next, data.deadline, turnChanged);
    });
  };

  const handleMatchFound = (data: MatchEntry, seats: SeatInfo[], spectating = false) => {
    if (!spectating && !data.resumed && !markMatch(`found:${data.matchId}`)) return;
    refs.replayEpoch += 1;
    refs.leftMatchId = '';
    const epoch = refs.replayEpoch;
    set({
      boardMode: 'playing',
      setupOpen: false,
      roomsOpen: false,
      players: seats,
      you: data.you,
      matchId: data.matchId,
      matchSeq: get().matchSeq + 1,
      startedAt: data.state.startedAt ?? Date.now(),
      log: [],
      winFx: null,
      result: null,
      awaySeats: {},
      sheet: null,
      spectating,
      spectators: spectating ? get().spectators : 0,
      ...(data.matchId === get().matchId ? {} : { matchChat: [], chatUnread: false, reactionFx: null }),
    });
    snapState(data.state);
    startTimer();
    playSound('click');
    bridge.attention({ reason: ARCADE_ATTENTION_REASON.MatchStarted, matchId: data.matchId });
    queueReplay(async () => {
      await sleep(SCREEN_IN_MS);
      if (epoch !== refs.replayEpoch) return;
      if (!data.resumed) await playTurnBanner(data.state);
      if (epoch !== refs.replayEpoch) return;
      settle(data.state, data.deadline, false);
    });
  };

  const handleError = (data: ErrorData) => {
    refs.pendingMoves = [];
    refs.batchLevels = new Map();
    set({ movePending: false });
    if (get().boardMode === 'playing' || get().room) get().showToast(errorText(data.code, data.message));
  };

  const onlineSeats = (players: PlayerInfo[]): SeatInfo[] => players.map((p) => ({ id: p.id, name: p.name, avatar: avatarIconUrl(p.vipType), bot: false }));

  const bindMatch = (session: TycoonSession, seats: (data: MatchFoundData<TycoonView>) => SeatInfo[]): Array<() => void> => {
    const active = () => session === matchSession();
    return [
      session.onMatchFound((data) => {
        if (!active()) {
          if (session !== refs.session) return;
          stopPractice();
          resetBoard();
          get().showToast('Bạn đang có ván online, đã chuyển về bàn');
        }
        handleMatchFound(data, seats(data));
      }),
      session.onState((data) => {
        if (active()) handleState(data);
      }),
      session.onMatchOver((data) => {
        if (active()) handleMatchOver(data);
      }),
      session.onError((data) => {
        if (active() || session === refs.session) handleError(data);
      }),
    ];
  };

  const stopPractice = () => {
    refs.matchUnsubs.forEach((off) => off());
    refs.matchUnsubs = [];
    refs.practice?.disconnect();
    refs.practice = null;
  };

  const resetBoard = () => {
    refs.replayEpoch += 1;
    refs.pendingMoves = [];
    refs.batchLevels = new Map();
    refs.incoming = null;
    stopTimer();
    clearTransientTimers();
    set({
      boardMode: 'idle',
      view: null,
      matchId: '',
      practice: false,
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
      winFx: null,
      awaySeats: {},
      selfDisconnected: false,
      spectating: false,
      spectators: 0,
      matchChat: [],
      chatUnread: false,
      reactionFx: null,
    });
  };

  const stopWatching = () => {
    refs.session?.spectateLeave(get().matchId);
    resetBoard();
    set({ roomsOpen: true });
  };

  const leaveToLobby = () => {
    stopPractice();
    resetBoard();
    set({ notice: null, noticeQueue: [] });
  };

  const bindSession = (session: TycoonSession) => {
    refs.sessionUnsubs.forEach((off) => off());
    refs.sessionUnsubs = [
      session.onUserInfo((data) => {
        set({ online: 'ready', profile: { id: data.id, username: data.username, vipType: data.vipType ?? null, ken: data.ken, maxBet: data.maxBet ?? null } });
      }),
      session.onRoomState((data) => {
        if (data.watcher) return;
        set({ room: data, roomsOpen: false });
      }),
      session.onRoomSync((data) => {
        const s = get();
        if (s.boardMode === 'playing' && !s.practice && !s.result && s.matchId) {
          const backToRoom = Boolean(data.roomId) && s.room?.roomId === data.roomId;
          resetBoard();
          set({ ...(backToRoom ? {} : { room: null, roomChat: [], roomsOpen: true }) });
          get().showNotice({ kind: 'notice', tone: 'warning', icon: 'wifi-off', title: 'Đã rời ván', body: 'Bạn mất kết nối quá lâu nên đã rời ván đang chơi.', okLabel: 'Đã hiểu' });
          return;
        }
        if (!data.roomId && s.room) set({ room: null, roomChat: [], roomsOpen: true });
      }),
      session.onRoomClosed((data) => {
        const s = get();
        if (s.room?.roomId !== data.roomId) return;
        if (s.boardMode === 'playing' && !s.practice) return;
        set({ room: null, roomChat: [], roomsOpen: true });
        if (data.reason !== 'guest_left') get().showToast(roomClosedText(data.reason));
        session.listRooms();
      }),
      session.onRoomKicked((data) => {
        if (get().room?.roomId !== data.roomId) return;
        set({ room: null, roomChat: [], roomsOpen: true });
        get().showNotice({ kind: 'notice', tone: 'warning', title: 'Đã bị mời ra', body: 'Chủ bàn đã mời bạn ra khỏi bàn.', okLabel: 'Đã hiểu' });
        bridge.attention({ reason: ARCADE_ATTENTION_REASON.RoomKicked });
        session.listRooms();
      }),
      session.onChat((data) => {
        if (data.roomId && data.roomId === get().room?.roomId) set((s) => ({ roomChat: [...s.roomChat.slice(-49), data] }));
        if (data.matchId && data.matchId === get().matchId && !get().practice) {
          set((s) => ({ matchChat: [...s.matchChat.slice(-49), data], chatUnread: s.chatUnread || (s.sheet?.kind !== 'chat' && data.userId !== s.players[s.you]?.id) }));
        }
      }),
      session.onReaction((data) => {
        const s = get();
        if (data.matchId !== s.matchId || s.practice) return;
        const seat = seatOf(data.userId);
        if (seat >= 0) set({ reactionFx: { seq: nextSeq(), seat, type: data.type } });
      }),
      session.onOpponentDisconnected((data) => {
        if (refs.practice) return;
        const seat = seatOf(data.userId);
        if (seat < 0) return;
        set((s) => ({ awaySeats: { ...s.awaySeats, [seat]: data.graceDeadline } }));
        bridge.attention({ reason: ARCADE_ATTENTION_REASON.OpponentDisconnected });
      }),
      session.onOpponentReconnected((data) => {
        if (refs.practice) return;
        const seat = seatOf(data?.userId);
        set((s) => {
          const awaySeats = { ...s.awaySeats };
          if (seat >= 0) delete awaySeats[seat];
          else Object.keys(awaySeats).forEach((key) => delete awaySeats[Number(key)]);
          return { awaySeats };
        });
        if (data?.deadline != null && data.turn === get().view?.turn && get().myTurn) set({ deadline: data.deadline });
      }),
      session.onConnectionChange((connected) => {
        set({ selfDisconnected: !connected && get().boardMode === 'playing' && !get().practice });
        if (connected && get().online !== 'ready' && get().profile) set({ online: 'ready' });
        if (connected && get().spectating && !get().result) session.spectateJoin(get().matchId);
      }),
      session.onConnectionError(() => {
        if (get().online === 'connecting') set({ online: 'offline' });
      }),
      session.onSpectateJoined((data) => {
        const rejoin = get().spectating && data.matchId === get().matchId;
        if (refs.practice || (get().boardMode === 'playing' && !rejoin)) {
          session.spectateLeave(data.matchId);
          return;
        }
        set({ spectators: data.spectators, room: null, roomChat: [] });
        handleMatchFound({ matchId: data.matchId, state: data.state, deadline: data.deadline, you: -1, resumed: true }, onlineSeats(data.players), true);
      }),
      session.onSpectators((data) => {
        if (get().spectating && data.matchId === get().matchId) set({ spectators: data.spectators.length });
      }),
      session.onSpectateLeft((data) => {
        const s = get();
        if (!s.spectating || data.matchId !== s.matchId || s.result || data.reason === SPECTATE_LEFT_REASON.MatchOver) return;
        resetBoard();
        set({ roomsOpen: true });
        get().showToast(SPECTATE_ENDED_TEXT);
      }),
      ...bindMatch(session, (data) => onlineSeats(data.players)),
    ];
  };

  const beginPractice = (bots: BotSetupItem[]) => {
    if (bots.length === 0) return;
    leaveToLobby();
    const lineup = bots.slice(0, MAX_BOTS);
    const profile = get().profile ?? MOCK_PROFILE;
    set({ room: null, roomChat: [] });
    const session = createPracticeSession({ user: { id: profile.id, username: profile.username, vipType: profile.vipType }, bots: lineup, speed: () => get().speed });
    const seats: SeatInfo[] = [
      { id: session.players[0].id, name: 'Bạn', avatar: avatarIconUrl(null), bot: false },
      ...lineup.map((item, index) => ({ id: session.players[index + 1].id, name: botName(index), avatar: vipIconUrl(item.vip), bot: true, level: item.level })),
    ];
    refs.practice = session;
    set({ practice: true, lastBots: lineup.map((item) => ({ ...item })) });
    refs.matchUnsubs.forEach((off) => off());
    refs.matchUnsubs = bindMatch(session, () => seats);
    session.start();
  };

  return {
    profile: MOCK_PROFILE,
    online: 'connecting',
    room: null,
    roomChat: [],
    awaySeats: {},
    selfDisconnected: false,
    spectating: false,
    spectators: 0,
    matchChat: [],
    chatUnread: false,
    reactionFx: null,
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
    matchId: '',
    practice: false,
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
    winFx: null,
    toast: null,
    notice: null,
    noticeId: 0,
    noticeQueue: [],

    init() {
      refs.disposed = false;
      setSoundEnabled(get().soundOn);
      bridge.ready();
      get().connect();
    },

    connect() {
      if (refs.session || refs.connecting) return;
      refs.connecting = true;
      set({ online: 'connecting' });
      joinGame<TycoonView, Move>(GAME_ID)
        .then((session) => {
          refs.connecting = false;
          if (refs.disposed) {
            session.disconnect();
            return;
          }
          refs.session = session;
          bindSession(session);
        })
        .catch(() => {
          refs.connecting = false;
          if (!refs.disposed) set({ online: 'offline' });
        });
    },

    session() {
      return refs.session;
    },

    leaveRoom() {
      const roomId = get().room?.roomId;
      set({ room: null, roomChat: [], roomsOpen: true });
      refs.session?.leaveRoom(roomId);
      refs.session?.listRooms();
    },

    setReady(ready: boolean) {
      const roomId = get().room?.roomId;
      if (roomId) refs.session?.setRoomReady(roomId, ready);
    },

    startRoom() {
      const roomId = get().room?.roomId;
      if (roomId) refs.session?.startRoom(roomId);
    },

    kickMember(userId: string) {
      const roomId = get().room?.roomId;
      if (roomId) refs.session?.kickRoomMember(roomId, userId);
    },

    sendRoomChat(text: string) {
      const roomId = get().room?.roomId;
      const trimmed = text.trim();
      if (roomId && trimmed) refs.session?.sendRoomChat(roomId, trimmed);
    },

    watchMatch(matchId: string) {
      const session = refs.session;
      if (!session || !matchId || get().online !== 'ready' || get().boardMode === 'playing') return false;
      session.spectateJoin(matchId);
      return true;
    },

    dispose() {
      refs.disposed = true;
      leaveToLobby();
      refs.sessionUnsubs.forEach((off) => off());
      refs.sessionUnsubs = [];
      refs.session?.disconnect();
      refs.session = null;
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
      beginPractice(bots);
    },

    sendMove(move: Move) {
      get().sendMoves([move]);
    },

    sendMoves(moves: Move[]) {
      const { boardMode, myTurn, movePending, replaying, result, turnExpired } = get();
      if (boardMode !== 'playing' || !myTurn || movePending || replaying || result || turnExpired || moves.length === 0) return;
      playSound('click');
      refs.pendingMoves = moves.slice(1);
      refs.batchLevels = new Map();
      sendNow(moves[0]);
    },

    openSheet(sheet: Sheet) {
      if (get().result) return;
      set(sheet?.kind === 'chat' ? { sheet, chatUnread: false } : { sheet });
    },

    sendMatchChat(text: string) {
      const trimmed = text.trim();
      const { matchId, practice, spectating } = get();
      if (trimmed && matchId && !practice && !spectating) refs.session?.sendChat(matchId, trimmed);
    },

    sendReaction(type: GameReactionType) {
      const { matchId, practice, spectating } = get();
      if (matchId && !practice && !spectating) refs.session?.sendReaction(matchId, type);
    },

    closeSheet() {
      set({ sheet: null });
    },

    forfeitMatch() {
      if (!get().matchId || get().result || get().spectating) return;
      get().showNotice({
        kind: 'confirm',
        tone: 'danger',
        title: 'Bỏ cuộc',
        body: 'Bạn sẽ bị tính phá sản và xếp cuối. Kết thúc ván ngay?',
        okLabel: 'Bỏ cuộc',
        onOk: () => {
          const session = matchSession();
          if (!session || get().result) return;
          refs.replayEpoch += 1;
          refs.pendingMoves = [];
          set({ replaying: false, movePending: false, myTurn: false, deadline: 0 });
          session.forfeit(get().matchId);
        },
      });
    },

    exitMatch() {
      if (get().result) {
        get().closeResult();
        return;
      }
      if (get().spectating) {
        stopWatching();
        return;
      }
      const online = !get().practice;
      get().showNotice({
        kind: 'confirm',
        tone: 'danger',
        title: 'Về sảnh',
        body: online ? 'Rời ván online sẽ bị tính bỏ cuộc và xếp cuối. Về sảnh chứ?' : 'Ván đang chơi sẽ bị huỷ. Về sảnh chứ?',
        okLabel: 'Về sảnh',
        onOk: () => {
          if (online && refs.session && get().matchId) {
            refs.leftMatchId = get().matchId;
            refs.session.forfeit(get().matchId, true);
            set({ room: null, roomChat: [] });
          }
          leaveToLobby();
        },
      });
    },

    closeResult() {
      if (get().practice) {
        leaveToLobby();
        return;
      }
      if (get().spectating) {
        stopWatching();
        return;
      }
      const roomId = get().room?.roomId;
      resetBoard();
      if (roomId) refs.session?.leaveRoom(roomId);
      set({ room: null, roomChat: [] });
    },

    playAgain() {
      if (get().practice) {
        beginPractice(get().lastBots);
        return;
      }
      resetBoard();
      if (!get().room) set({ roomsOpen: true });
    },

    announce(text: string, tone: LogLine['tone']) {
      pushLog(text, tone);
      get().showToast(text);
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
