import { create } from 'zustand';
import { ARCADE_ATTENTION_REASON } from '@ola/shared/constants';
import { bridge, joinGame, type GameSession } from '../../src/sdk';
import type {
  ChatMessageData,
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
import { RecentMatchIds } from '../logic/recent-match-ids';
import { decodeServerState, type ServerMove, type ServerPlay, type ServerState, type ServerStep } from '../logic/server-types';
import { errorText, roomClosedText } from '../helpers/errorText';

export type Phase = 'connecting' | 'lobby' | 'room' | 'table';

export interface SeatReaction {
  seat: number;
  type: string;
  key: number;
}

export interface MatchResult {
  rankings: RankingEntry[];
  winnerId?: string;
  reason: string;
  instantWin?: string;
}

interface ThirteenStore {
  phase: Phase;
  user: UserInfoData | null;
  queueing: boolean;
  rooms: RoomInfo[];
  room: RoomStateData | null;
  roomChat: ChatMessageData[];
  matchId: string;
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
  passFxSeat: number;
  finishFx: { seat: number; place: number } | null;
  dealing: boolean;
  matchChat: ChatMessageData[];
  chatOpen: boolean;
  reactions: SeatReaction[];
  awaySeats: Record<number, number>;
  selfDisconnected: boolean;
  result: MatchResult | null;
  notice: string | null;
  toast: string | null;
  confirmExit: boolean;
  init(): void;
  dispose(): void;
  joinQueue(): void;
  leaveQueue(): void;
  refreshRooms(): void;
  createRoom(maxPlayers: number, password: string, bet: number): void;
  joinRoom(room: RoomInfo, password?: string): void;
  leaveRoom(): void;
  setReady(ready: boolean): void;
  startRoom(): void;
  kickMember(userId: string): void;
  toggleCard(card: number): void;
  clearSelection(): void;
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
    unsubs: [] as Array<() => void>,
    replayChain: Promise.resolve(),
    replayEpoch: 0,
    handledMatchOvers: new RecentMatchIds(),
    handledMatchStarts: new RecentMatchIds(),
    toastTimer: 0,
    disposed: false,
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
        set({ passFxSeat: step.by });
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
        set({ table: { cards: step.cards ?? [], by: step.by }, lastPlaySeat: step.by });
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
    set({
      phase: 'table',
      matchId: data.matchId,
      players: data.players,
      you: data.you,
      selected: [],
      matchChat: [],
      reactions: [],
      awaySeats: {},
      result: null,
      queueing: false,
      selfDisconnected: false,
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
    if (!refs.handledMatchOvers.mark(data.matchId)) return;
    if (get().matchId && get().matchId !== data.matchId) return;
    const final = data.state as { instantWin?: string } | undefined;
    queueReplay(async () => {
      await sleep(600);
      const me = get().user?.id;
      const myEntry = data.rankings?.find((entry) => entry.userId === me);
      set({
        result: {
          rankings: data.rankings ?? [],
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
      if (myEntry) bridge.refreshUser();
    });
  };

  const bindSession = (session: GameSession<ServerState, ServerMove>): void => {
    refs.unsubs.push(
      session.onUserInfo((data) => {
        set({ user: data });
        if (get().phase === 'connecting') {
          set({ phase: 'table' === get().phase ? 'table' : 'lobby' });
          session.listRooms();
        }
      }),
      session.onQueueWaiting(() => set({ queueing: true })),
      session.onRoomList((data) => set({ rooms: data.rooms })),
      session.onRoomUpsert((data) => {
        set((s) => {
          const rooms = s.rooms.filter((room) => room.id !== data.room.id);
          return { rooms: [data.room, ...rooms] };
        });
      }),
      session.onRoomRemoved((data) => set((s) => ({ rooms: s.rooms.filter((room) => room.id !== data.roomId) }))),
      session.onRoomWaiting(() => set({ queueing: false })),
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
      session.onMatchFound((data) => startMatch(data)),
      session.onState((data) => queueReplay(() => handleState(data))),
      session.onMatchOver((data) => handleMatchOver(data)),
      session.onChat((data) => {
        if (data.roomId) {
          set((s) => ({ roomChat: [...s.roomChat.slice(-49), data] }));
        } else {
          set((s) => ({ matchChat: [...s.matchChat.slice(-49), data] }));
          if (data.userId !== get().user?.id) bridge.attention({ reason: ARCADE_ATTENTION_REASON.NewChat });
        }
      }),
      session.onReaction((data) => {
        const seat = get().players.findIndex((p) => p.id === data.userId);
        if (seat < 0) return;
        const key = Date.now() + Math.random();
        set((s) => ({ reactions: [...s.reactions.slice(-5), { seat, type: data.type, key }] }));
        window.setTimeout(() => {
          set((s) => ({ reactions: s.reactions.filter((r) => r.key !== key) }));
        }, 2600);
      }),
      session.onOpponentDisconnected((data) => {
        const seat = data.userId ? get().players.findIndex((p) => p.id === data.userId) : -1;
        if (seat < 0) return;
        set((s) => ({ awaySeats: { ...s.awaySeats, [seat]: toPerfDeadline(data.graceDeadline) } }));
        bridge.attention({ reason: ARCADE_ATTENTION_REASON.OpponentDisconnected });
      }),
      session.onOpponentReconnected((data) => {
        const seat = data?.userId ? get().players.findIndex((p) => p.id === data.userId) : -1;
        set((s) => {
          const awaySeats = { ...s.awaySeats };
          if (seat >= 0) delete awaySeats[seat];
          else Object.keys(awaySeats).forEach((k) => delete awaySeats[Number(k)]);
          return { awaySeats };
        });
      }),
      session.onError((data) => {
        set({ movePending: false });
        get().showToast(errorText(data.code));
      }),
      session.onConnectionChange((connected) => {
        set({ selfDisconnected: !connected && get().phase === 'table' });
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
    queueing: false,
    rooms: [],
    room: null,
    roomChat: [],
    matchId: '',
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
    passFxSeat: -1,
    finishFx: null,
    dealing: false,
    matchChat: [],
    chatOpen: false,
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
          bindSession(session);
        })
        .catch(() => {
          set({ notice: 'Không thể đăng nhập vào trò chơi. Hãy mở lại từ ứng dụng Ola.' });
        });
    },

    dispose() {
      refs.disposed = true;
      refs.unsubs.forEach((off) => off());
      refs.unsubs = [];
      refs.session?.disconnect();
      refs.session = null;
    },

    joinQueue() {
      set({ queueing: true });
      refs.session?.joinQueue();
    },
    leaveQueue() {
      set({ queueing: false });
      refs.session?.leaveQueue();
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
      if (!get().canPlaySelected() || !refs.session) return;
      set({ movePending: true, selected: [] });
      refs.session.sendMove(s.matchId, { type: 'play', cards: [...s.selected] });
    },
    passTurn() {
      const s = get();
      if (s.animating || s.movePending || s.turn !== s.you || !s.table || !refs.session) return;
      set({ movePending: true, selected: [] });
      refs.session.sendMove(s.matchId, { type: 'pass' });
    },

    sendChat(text) {
      const trimmed = text.trim();
      if (trimmed && get().matchId) refs.session?.sendChat(get().matchId, trimmed);
    },
    sendRoomChatText(text) {
      const trimmed = text.trim();
      const roomId = get().room?.roomId;
      if (trimmed && roomId) refs.session?.sendRoomChat(roomId, trimmed);
    },
    sendReaction(type) {
      if (get().matchId) refs.session?.sendReaction(get().matchId, type as never);
    },
    setChatOpen(open) {
      set({ chatOpen: open });
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
      if (s.phase === 'table' && s.matchId && !s.result) {
        refs.session?.forfeit(s.matchId, true);
        refs.replayEpoch += 1;
        set({ phase: 'lobby', matchId: '', result: null, room: null });
        refs.session?.listRooms();
        return;
      }
      bridge.exit();
    },

    closeResult(stayInRoom) {
      const roomId = get().room?.roomId;
      refs.replayEpoch += 1;
      set({
        result: null,
        matchId: '',
        phase: stayInRoom && roomId ? 'room' : 'lobby',
        selected: [],
        matchChat: [],
        chatOpen: false,
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
