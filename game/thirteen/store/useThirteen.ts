import { create } from 'zustand';
import { ARCADE_ATTENTION_REASON } from '@ola/shared/constants';
import { bridge, joinGame, type GameSession } from '../../src/sdk';
import type {
  ChatMessageData,
  ExpGainEntry,
  MatchFoundData,
  MatchOverData,
  PlayerInfo,
  RankingEntry,
  RoomInfo,
  RoomStateData,
  StateData,
  UserInfoData,
} from '../../src/sdk';
import { GAME_ID } from '../logic/constants.gen';
import { sortHand } from '../logic/cards';
import { detectCombo, type Combo } from '../logic/combos';
import { canBeat } from '../logic/beats';
import { hintPlays } from '../logic/hints';
import { RecentMatchIds } from '../logic/recent-match-ids';
import { decodeServerState, type ServerMove, type ServerPlay, type ServerState, type ServerStep } from '../logic/server-types';
import { errorText, roomClosedText } from '../helpers/errorText';
import type { BotSetupItem } from '../helpers/practice';
import { createPracticeSession } from '../practice';
import { CHAT_BUBBLE_MS, receiveMatchChat, type SeatChatBubble } from './matchChat';

export type Phase = 'connecting' | 'lobby' | 'room' | 'table';

export interface SeatReaction {
  seat: number;
  type: string;
  key: number;
}

export interface TableEvent {
  kind: 'play' | 'pass';
  seat: number;
  at: number;
}

export interface MatchResult {
  rankings: RankingEntry[];
  expGains?: ExpGainEntry[];
  winnerId?: string;
  reason: string;
  instantWin?: string;
}

interface ThirteenStore {
  phase: Phase;
  user: UserInfoData | null;
  practice: BotSetupItem[] | null;
  rooms: RoomInfo[];
  room: RoomStateData | null;
  roomChat: ChatMessageData[];
  matchId: string;
  roomOwnerId: string;
  you: number;
  players: PlayerInfo[];
  hand: number[];
  selected: number[];
  handCounts: number[];
  table: ServerPlay | null;
  lastPlaySeat: number;
  passed: boolean[];
  quit: boolean[];
  finishOrder: number[];
  turn: number;
  deadlineAt: number;
  animating: boolean;
  movePending: boolean;
  require3s: boolean;
  chopFx: number;
  tableEvent: TableEvent | null;
  passFxSeat: number;
  finishFx: { seat: number; place: number } | null;
  dealing: boolean;
  matchChat: ChatMessageData[];
  chatOpen: boolean;
  chatUnread: number;
  chatBubbles: SeatChatBubble[];
  reactions: SeatReaction[];
  awaySeats: Record<number, number>;
  selfDisconnected: boolean;
  result: MatchResult | null;
  notice: string | null;
  toast: string | null;
  confirmExit: boolean;
  init(): void;
  dispose(): void;
  startPractice(bots: BotSetupItem[]): void;
  refreshRooms(): void;
  createRoom(maxPlayers: number, password: string, bet: number): void;
  joinRoom(room: RoomInfo, password?: string): void;
  leaveRoom(): void;
  setReady(ready: boolean): void;
  startRoom(): void;
  kickMember(userId: string): void;
  toggleCard(card: number): void;
  clearSelection(): void;
  suggestPlay(): void;
  playSelected(): void;
  passTurn(): void;
  sendChat(text: string): void;
  sendRoomChatText(text: string): void;
  sendReaction(type: string): void;
  setChatOpen(open: boolean): void;
  requestExit(): void;
  cancelExit(): void;
  confirmExitNow(): void;
  closeResult(stayInRoom: boolean): void;
  dismissNotice(): void;
  showToast(text: string): void;
  selectedCombo(): Combo | null;
  canPlaySelected(): boolean;
}

const STEP_MS: Record<string, number> = {
  deal: 1500,
  play: 450,
  pass: 350,
  clear: 500,
  finish: 700,
  instant: 900,
};

const sleep = (ms: number): Promise<void> => new Promise((resolve) => setTimeout(resolve, ms));

export const useThirteen = create<ThirteenStore>()((set, get) => {
  const refs = {
    session: null as GameSession<ServerState, ServerMove> | null,
    practice: null as GameSession<ServerState, ServerMove> | null,
    unsubs: [] as Array<() => void>,
    replayChain: Promise.resolve(),
    replayEpoch: 0,
    handledMatchOvers: new RecentMatchIds(),
    handledMatchStarts: new RecentMatchIds(),
    leftMatchId: '',
    toastTimer: 0,
    disposed: false,
  };

  const matchSession = (): GameSession<ServerState, ServerMove> | null => refs.practice ?? refs.session;

  const stopPractice = (): void => {
    refs.practice?.disconnect();
    refs.practice = null;
    set({ practice: null });
  };

  const queueReplay = (fn: () => Promise<void>): void => {
    refs.replayChain = refs.replayChain.then(fn).catch(() => undefined);
  };

  const toPerfDeadline = (deadline: number): number => performance.now() + (deadline - Date.now());

  const snapState = (state: ServerState, turn: number, deadline: number): void => {
    set({
      you: state.you,
      hand: sortHand(state.yourHand),
      handCounts: state.handCounts,
      table: state.table ?? null,
      lastPlaySeat: state.table?.by ?? -1,
      passed: state.passed,
      quit: state.quit,
      finishOrder: state.finishOrder,
      require3s: state.require3s,
      turn,
      deadlineAt: toPerfDeadline(deadline),
      movePending: false,
      animating: false,
      dealing: false,
    });
    const mine = turn === state.you;
    bridge.turnChanged({ yourTurn: mine, deadline });
    if (mine) bridge.attention({ reason: ARCADE_ATTENTION_REASON.YourTurn });
  };

  const replayStep = async (step: ServerStep, you: number): Promise<void> => {
    switch (step.kind) {
      case 'deal':
        set({ dealing: true });
        await sleep(STEP_MS.deal);
        set({ dealing: false });
        return;
      case 'play':
        set({
          table: { cards: step.cards ?? [], by: step.by },
          lastPlaySeat: step.by,
          tableEvent: { kind: 'play', seat: step.by, at: Date.now() },
          ...(step.chop ? { chopFx: Date.now() } : {}),
        });
        if (step.by !== you) {
          set((s) => ({
            handCounts: s.handCounts.map((count, i) => (i === step.by ? Math.max(0, count - (step.cards?.length ?? 0)) : count)),
          }));
        }
        await sleep(step.chop ? STEP_MS.play + 400 : STEP_MS.play);
        return;
      case 'pass':
        set({ passFxSeat: step.by, tableEvent: { kind: 'pass', seat: step.by, at: Date.now() } });
        set((s) => ({ passed: s.passed.map((p, i) => (i === step.by ? true : p)) }));
        await sleep(STEP_MS.pass);
        set({ passFxSeat: -1 });
        return;
      case 'clear':
        await sleep(STEP_MS.clear);
        set({ table: null, passed: get().passed.map(() => false) });
        return;
      case 'finish':
        set({ finishFx: { seat: step.by, place: step.place ?? 0 } });
        await sleep(STEP_MS.finish);
        set({ finishFx: null });
        return;
      case 'instant':
        await sleep(STEP_MS.instant);
        return;
      default:
        return;
    }
  };

  const handleState = async (data: StateData<ServerState, ServerMove>): Promise<void> => {
    if (get().matchId !== data.matchId) return;
    const epoch = refs.replayEpoch;
    let state: ServerState;
    try {
      state = decodeServerState(data.state);
    } catch {
      return;
    }
    set({ animating: true });
    const fast = data.lastBy === state.you;
    for (const step of state.steps ?? []) {
      if (refs.replayEpoch !== epoch || get().matchId !== data.matchId) return;
      if (fast && step.kind === 'play') {
        set({
          table: { cards: step.cards ?? [], by: step.by },
          lastPlaySeat: step.by,
          tableEvent: { kind: 'play', seat: step.by, at: Date.now() },
        });
        continue;
      }
      await replayStep(step, state.you);
    }
    if (refs.replayEpoch !== epoch || get().matchId !== data.matchId) return;
    snapState(state, data.turn, data.deadline);
  };

  const startMatch = (data: MatchFoundData<ServerState>): void => {
    let state: ServerState;
    try {
      state = decodeServerState(data.state);
    } catch {
      return;
    }
    refs.replayEpoch += 1;
    const epoch = refs.replayEpoch;
    const fresh = refs.handledMatchStarts.mark(data.matchId);
    if (data.matchId === refs.leftMatchId) refs.leftMatchId = '';
    set({
      phase: 'table',
      matchId: data.matchId,
      roomOwnerId: data.roomOwnerId ?? '',
      players: data.players,
      you: data.you,
      selected: [],
      matchChat: [],
      chatUnread: 0,
      chatBubbles: [],
      reactions: [],
      awaySeats: {},
      result: null,
      selfDisconnected: false,
      tableEvent: null,
    });
    if (data.resumed || !fresh) {
      queueReplay(async () => {
        if (refs.replayEpoch !== epoch) return;
        snapState(state, data.turn, data.deadline);
      });
      return;
    }
    bridge.attention({ reason: ARCADE_ATTENTION_REASON.MatchStarted });
    queueReplay(async () => {
      if (refs.replayEpoch !== epoch) return;
      set({ animating: true, hand: sortHand(state.yourHand), handCounts: state.handCounts, table: null });
      for (const step of state.steps ?? []) {
        if (refs.replayEpoch !== epoch) return;
        await replayStep(step, state.you);
      }
      if (refs.replayEpoch !== epoch) return;
      snapState(state, data.turn, data.deadline);
    });
  };

  const handleMatchOver = (data: MatchOverData<unknown>): void => {
    if (data.matchId === refs.leftMatchId) return;
    if (!refs.handledMatchOvers.mark(data.matchId)) return;
    if (get().matchId && get().matchId !== data.matchId) return;
    const final = data.state as { instantWin?: string } | undefined;
    const epoch = refs.replayEpoch;
    queueReplay(async () => {
      await sleep(600);
      if (refs.replayEpoch !== epoch) return;
      const me = get().user?.id;
      const myEntry = data.rankings?.find((entry) => entry.userId === me);
      set({
        result: {
          rankings: data.rankings ?? [],
          expGains: data.expGains ?? [],
          winnerId: data.winnerId,
          reason: data.reason,
          instantWin: final?.instantWin,
        },
        animating: false,
        movePending: false,
      });
      bridge.gameOver({
        matchId: data.matchId,
        winnerId: data.winnerId,
        reason: data.reason,
        won: data.winnerId != null && data.winnerId === me,
      });
      bridge.attention({ reason: ARCADE_ATTENTION_REASON.GameOver });
      if (myEntry && !get().practice) bridge.refreshUser();
    });
  };

  const bindMatch = (source: GameSession<ServerState, ServerMove>): Array<() => void> => {
    const active = (): boolean => source === matchSession();
    return [
      source.onMatchFound((data) => {
        if (!active()) {
          if (source !== refs.session) return;
          stopPractice();
          get().showToast('Bạn đang có ván thật, đã chuyển về bàn');
        }
        startMatch(data);
      }),
      source.onState((data) => {
        if (active()) queueReplay(() => handleState(data));
      }),
      source.onMatchOver((data) => {
        if (active()) handleMatchOver(data);
      }),
      source.onChat((data) => {
        if (data.roomId) {
          if (source === refs.session) set((s) => ({ roomChat: [...s.roomChat.slice(-49), data] }));
          return;
        }
        if (!active() || (data.matchId && data.matchId !== get().matchId)) return;
        const key = Date.now() + Math.random();
        set((s) => receiveMatchChat(s, data, key));
        window.setTimeout(() => {
          set((s) => ({ chatBubbles: s.chatBubbles.filter((bubble) => bubble.key !== key) }));
        }, CHAT_BUBBLE_MS);
        if (data.userId !== get().user?.id) bridge.attention({ reason: ARCADE_ATTENTION_REASON.NewChat });
      }),
      source.onReaction((data) => {
        if (!active()) return;
        const seat = get().players.findIndex((p) => p.id === data.userId);
        if (seat < 0) return;
        const key = Date.now() + Math.random();
        set((s) => ({ reactions: [...s.reactions.slice(-5), { seat, type: data.type, key }] }));
        window.setTimeout(() => {
          set((s) => ({ reactions: s.reactions.filter((r) => r.key !== key) }));
        }, 2600);
      }),
      source.onOpponentDisconnected((data) => {
        if (!active()) return;
        const seat = data.userId ? get().players.findIndex((p) => p.id === data.userId) : -1;
        if (seat < 0) return;
        set((s) => ({ awaySeats: { ...s.awaySeats, [seat]: toPerfDeadline(data.graceDeadline) } }));
        bridge.attention({ reason: ARCADE_ATTENTION_REASON.OpponentDisconnected });
      }),
      source.onOpponentReconnected((data) => {
        if (!active()) return;
        const seat = data?.userId ? get().players.findIndex((p) => p.id === data.userId) : -1;
        set((s) => {
          const awaySeats = { ...s.awaySeats };
          if (seat >= 0) delete awaySeats[seat];
          else Object.keys(awaySeats).forEach((k) => delete awaySeats[Number(k)]);
          return { awaySeats };
        });
        const turn = data?.turn;
        const deadline = data?.deadline;
        if (turn == null || deadline == null) return;
        const epoch = refs.replayEpoch;
        queueReplay(async () => {
          if (refs.replayEpoch !== epoch || get().phase !== 'table' || turn !== get().turn) return;
          set({ deadlineAt: toPerfDeadline(deadline) });
        });
      }),
      source.onError((data) => {
        if (!active()) return;
        set({ movePending: false });
        get().showToast(errorText(data.code));
      }),
    ];
  };

  const bindLobby = (session: GameSession<ServerState, ServerMove>): void => {
    refs.unsubs.push(
      session.onUserInfo((data) => {
        set({ user: data });
        if (get().phase === 'connecting') {
          set({ phase: 'lobby' });
          session.listRooms();
        }
      }),
      session.onRoomList((data) => set({ rooms: data.rooms })),
      session.onRoomUpsert((data) => {
        set((s) => {
          const rooms = s.rooms.filter((room) => room.id !== data.room.id);
          return { rooms: [data.room, ...rooms] };
        });
      }),
      session.onRoomRemoved((data) => set((s) => ({ rooms: s.rooms.filter((room) => room.id !== data.roomId) }))),
      session.onRoomState((data) => {
        set({ room: data, phase: get().phase === 'table' ? 'table' : 'room' });
      }),
      session.onRoomSync((data) => {
        if (!data.roomId && get().phase === 'room') {
          set({ phase: 'lobby', room: null, roomChat: [] });
          session.listRooms();
        }
      }),
      session.onRoomClosed((data) => {
        if (get().room?.roomId === data.roomId || get().phase === 'room') {
          const wasSelf = data.reason === 'guest_left';
          set({ phase: 'lobby', room: null, roomChat: [], ...(wasSelf ? {} : { notice: roomClosedText(data.reason) }) });
          session.listRooms();
        }
      }),
      session.onRoomKicked(() => {
        set({ phase: 'lobby', room: null, roomChat: [], notice: 'Bạn đã bị mời khỏi bàn' });
        bridge.attention({ reason: ARCADE_ATTENTION_REASON.RoomKicked });
        session.listRooms();
      }),
      ...bindMatch(session),
      session.onConnectionChange((connected) => {
        set({ selfDisconnected: !connected && get().phase === 'table' && !get().practice });
        if (connected && get().phase === 'connecting') session.listRooms();
      }),
      session.onConnectionError(() => {
        set({ notice: 'Không thể kết nối máy chủ trò chơi. Hãy thử lại sau.' });
      }),
    );
  };

  return {
    phase: 'connecting',
    user: null,
    practice: null,
    rooms: [],
    room: null,
    roomChat: [],
    matchId: '',
    roomOwnerId: '',
    you: 0,
    players: [],
    hand: [],
    selected: [],
    handCounts: [],
    table: null,
    lastPlaySeat: -1,
    passed: [],
    quit: [],
    finishOrder: [],
    turn: 0,
    deadlineAt: 0,
    animating: false,
    movePending: false,
    require3s: false,
    chopFx: 0,
    tableEvent: null,
    passFxSeat: -1,
    finishFx: null,
    dealing: false,
    matchChat: [],
    chatOpen: false,
    chatUnread: 0,
    chatBubbles: [],
    reactions: [],
    awaySeats: {},
    selfDisconnected: false,
    result: null,
    notice: null,
    toast: null,
    confirmExit: false,

    init() {
      refs.disposed = false;
      void joinGame<ServerState, ServerMove>(GAME_ID)
        .then((session) => {
          if (refs.disposed) {
            session.disconnect();
            return;
          }
          refs.session = session;
          bindLobby(session);
        })
        .catch(() => {
          set({ notice: 'Không thể đăng nhập vào trò chơi. Hãy mở lại từ ứng dụng Ola.' });
        });
    },

    dispose() {
      refs.disposed = true;
      refs.unsubs.forEach((off) => off());
      refs.unsubs = [];
      refs.practice?.disconnect();
      refs.practice = null;
      refs.session?.disconnect();
      refs.session = null;
    },

    startPractice(bots) {
      const user = get().user;
      if (!user || bots.length === 0) return;
      refs.practice?.disconnect();
      const practice = createPracticeSession({ user: { id: user.id, username: user.username, vipType: user.vipType }, bots });
      refs.practice = practice;
      bindMatch(practice);
      set({ practice: bots, roomOwnerId: '', room: null, roomChat: [] });
      practice.joinQueue();
    },
    refreshRooms() {
      refs.session?.listRooms();
    },
    createRoom(maxPlayers, password, bet) {
      refs.session?.createRoom(bet, password || undefined, maxPlayers);
    },
    joinRoom(room, password) {
      refs.session?.joinRoom(room.id, password);
    },
    leaveRoom() {
      const roomId = get().room?.roomId;
      set({ phase: 'lobby', room: null, roomChat: [] });
      refs.session?.leaveRoom(roomId);
      refs.session?.listRooms();
    },
    setReady(ready) {
      const roomId = get().room?.roomId;
      if (roomId) refs.session?.setRoomReady(roomId, ready);
    },
    startRoom() {
      const roomId = get().room?.roomId;
      if (roomId) refs.session?.startRoom(roomId);
    },
    kickMember(userId) {
      const roomId = get().room?.roomId;
      if (roomId) refs.session?.kickRoomMember(roomId, userId);
    },

    toggleCard(card) {
      set((s) => ({
        selected: s.selected.includes(card) ? s.selected.filter((c) => c !== card) : [...s.selected, card],
      }));
    },
    clearSelection() {
      set({ selected: [] });
    },
    suggestPlay() {
      const s = get();
      if (s.animating || s.movePending || s.turn !== s.you || s.result) return;
      const hints = hintPlays(s.hand, s.table ? detectCombo(s.table.cards) : null, s.require3s);
      if (hints.length === 0) return;
      const selected = [...s.selected].sort((a, b) => a - b).join(',');
      const current = hints.findIndex((play) => play.join(',') === selected);
      set({ selected: hints[(current + 1) % hints.length] });
    },
    selectedCombo() {
      const selected = get().selected;
      if (selected.length === 0) return null;
      return detectCombo(selected);
    },
    canPlaySelected() {
      const s = get();
      if (s.animating || s.movePending || s.turn !== s.you || s.result) return false;
      const combo = get().selectedCombo();
      if (!combo) return false;
      if (s.require3s && !s.selected.includes(0)) return false;
      const prev = s.table ? detectCombo(s.table.cards) : null;
      return canBeat(combo, prev ?? null);
    },
    playSelected() {
      const s = get();
      const session = matchSession();
      if (!get().canPlaySelected() || !session) return;
      set({ movePending: true, selected: [] });
      session.sendMove(s.matchId, { type: 'play', cards: [...s.selected] });
    },
    passTurn() {
      const s = get();
      const session = matchSession();
      if (s.animating || s.movePending || s.turn !== s.you || !s.table || !session) return;
      set({ movePending: true, selected: [] });
      session.sendMove(s.matchId, { type: 'pass' });
    },

    sendChat(text) {
      const trimmed = text.trim();
      if (trimmed && get().matchId) matchSession()?.sendChat(get().matchId, trimmed);
    },
    sendRoomChatText(text) {
      const trimmed = text.trim();
      const roomId = get().room?.roomId;
      if (trimmed && roomId) refs.session?.sendRoomChat(roomId, trimmed);
    },
    sendReaction(type) {
      if (get().matchId) matchSession()?.sendReaction(get().matchId, type as never);
    },
    setChatOpen(open) {
      set(open ? { chatOpen: true, chatUnread: 0 } : { chatOpen: false });
    },

    requestExit() {
      set({ confirmExit: true });
    },
    cancelExit() {
      set({ confirmExit: false });
    },
    confirmExitNow() {
      const s = get();
      set({ confirmExit: false });
      if (s.phase === 'table' && s.practice) {
        refs.practice?.forfeit(s.matchId);
        stopPractice();
        refs.replayEpoch += 1;
        set({ phase: 'lobby', matchId: '', result: null, room: null, selected: [], matchChat: [], chatOpen: false, chatUnread: 0, chatBubbles: [] });
        refs.session?.listRooms();
        return;
      }
      if (s.phase === 'table' && s.matchId && !s.result) {
        refs.leftMatchId = s.matchId;
        refs.session?.forfeit(s.matchId, true);
        refs.replayEpoch += 1;
        set({ phase: 'lobby', matchId: '', result: null, room: null });
        refs.session?.listRooms();
        return;
      }
      bridge.exit();
    },

    closeResult(stayInRoom) {
      if (get().practice) {
        refs.replayEpoch += 1;
        set({ result: null, matchId: '', selected: [], chatOpen: false, chatUnread: 0, chatBubbles: [] });
        if (stayInRoom && refs.practice) {
          refs.practice.joinQueue();
          return;
        }
        stopPractice();
        set({ phase: 'lobby', matchChat: [] });
        refs.session?.listRooms();
        return;
      }
      const roomId = get().room?.roomId;
      refs.replayEpoch += 1;
      set({
        result: null,
        matchId: '',
        phase: stayInRoom && roomId ? 'room' : 'lobby',
        selected: [],
        matchChat: [],
        chatOpen: false,
        chatUnread: 0,
        chatBubbles: [],
        ...(stayInRoom && roomId ? {} : { room: null, roomChat: [] }),
      });
      if (!stayInRoom && roomId) {
        refs.session?.leaveRoom(roomId);
      }
      refs.session?.listRooms();
    },

    dismissNotice() {
      set({ notice: null });
    },
    showToast(text) {
      window.clearTimeout(refs.toastTimer);
      set({ toast: text });
      refs.toastTimer = window.setTimeout(() => set({ toast: null }), 2600);
    },
  };
});
