import { create } from 'zustand';
import { GAME_ERROR_CODE, type ErrorData, type RoomInfo } from '../../src/sdk';
import { formatKen } from '../helpers/format';
import {
  BET_NOT_ALLOWED_TEXT,
  BET_INVALID_TEXT,
  BET_OVER_BALANCE_TEXT,
  DEFAULT_MAX_PLAYERS,
  NETWORK_ERROR,
  PASSWORD_TOO_LONG_TEXT,
  WRONG_PASSWORD_TEXT,
  pageCount,
  roomToastText,
  type CreateRoomInput,
  type FieldError,
  type TycoonRoom,
} from '../helpers/room';
import { playSound } from '../audio';
import { useTycoon } from './useTycoon';

export type RoomListStatus = 'loading' | 'ready' | 'error';

type RoomRequest =
  | { kind: 'join'; room: TycoonRoom; password?: string }
  | { kind: 'spectate'; room: TycoonRoom }
  | { kind: 'create'; input: CreateRoomInput };

interface RoomListState {
  status: RoomListStatus;
  rooms: TycoonRoom[];
  refreshing: boolean;
  page: number;
  pendingId: string | null;
  createOpen: boolean;
  createPlayers: number;
  createError: FieldError | null;
  lockedRoom: TycoonRoom | null;
  lockedError: string | null;
  errorSeq: number;

  load(): Promise<void>;
  leave(): void;
  refresh(): Promise<void>;
  setPage(page: number): void;
  join(room: TycoonRoom): Promise<void>;
  submitPassword(password: string): Promise<void>;
  clearLockedError(): void;
  closeLocked(): void;
  spectate(room: TycoonRoom): Promise<void>;
  openCreate(): void;
  closeCreate(): void;
  setCreatePlayers(count: number): void;
  setCreateError(error: FieldError | null): void;
  submitCreate(input: CreateRoomInput): Promise<void>;
}

const FIELD_ERRORS = new Map<string, FieldError>([
  [GAME_ERROR_CODE.InvalidBet, { field: 'bet', text: BET_INVALID_TEXT }],
  [GAME_ERROR_CODE.BetNotAllowed, { field: 'bet', text: BET_NOT_ALLOWED_TEXT }],
  [GAME_ERROR_CODE.InvalidPassword, { field: 'password', text: PASSWORD_TOO_LONG_TEXT }],
]);

const REFRESH_AFTER = new Set<string>([GAME_ERROR_CODE.RoomFull, GAME_ERROR_CODE.RoomNotFound, GAME_ERROR_CODE.MatchNotFound]);

const REQUEST_TIMEOUT_MS = 10_000;

const tycoon = () => useTycoon.getState();

const playerKen = (): number => tycoon().profile?.ken ?? 0;

export const useRoomList = create<RoomListState>((set, get) => {
  let unsubs: Array<() => void> = [];
  let waitOnline: (() => void) | null = null;
  let pending: RoomRequest | null = null;
  let pendingTimer: ReturnType<typeof setTimeout> | 0 = 0;

  const toRoom = (room: RoomInfo): TycoonRoom => room;

  const clearPending = () => {
    pending = null;
    if (pendingTimer) clearTimeout(pendingTimer);
    pendingTimer = 0;
    set({ pendingId: null });
  };

  const detach = () => {
    unsubs.forEach((off) => off());
    unsubs = [];
    waitOnline?.();
    waitOnline = null;
  };

  const showInsufficientKen = (bet: number) => {
    tycoon().showNotice({
      kind: 'notice',
      tone: 'warning',
      icon: 'ken',
      title: 'Chưa đủ KEN',
      body: `Bàn này cược ${formatKen(bet)} KEN. Bạn đang có ${formatKen(playerKen())} KEN.`,
      okLabel: 'Đã hiểu',
    });
  };

  const showBetNotAllowed = () => {
    tycoon().showNotice({
      kind: 'notice',
      tone: 'warning',
      icon: 'ken',
      title: 'Chưa thể chơi bàn cược',
      body: 'Tài khoản của bạn chưa thể chơi bàn có cược KEN. Hãy chọn bàn Giao lưu.',
      okLabel: 'Đã hiểu',
    });
  };

  const showNetworkError = (request: RoomRequest) => {
    tycoon().showNotice({
      kind: 'confirm',
      tone: 'error',
      icon: 'wifi-off',
      title: 'Mất kết nối',
      body: 'Chưa thể kết nối vào bàn. Kiểm tra mạng rồi thử lại nhé.',
      okLabel: 'Thử lại',
      cancelLabel: 'Để sau',
      onOk: () => run(request),
    });
  };

  const closeModals = () => set({ createOpen: false, createError: null, lockedRoom: null, lockedError: null });

  const handleFailure = (code: string, request: RoomRequest) => {
    if (code === NETWORK_ERROR) {
      showNetworkError(request);
      return;
    }
    if (request.kind === 'create') {
      const fieldError = code === GAME_ERROR_CODE.InsufficientKen ? { field: 'bet' as const, text: BET_OVER_BALANCE_TEXT } : FIELD_ERRORS.get(code);
      if (fieldError) {
        set((state) => ({ createError: fieldError, errorSeq: state.errorSeq + 1 }));
        return;
      }
    }
    if (request.kind === 'join' && code === GAME_ERROR_CODE.WrongPassword) {
      set((state) => ({ lockedError: WRONG_PASSWORD_TEXT, errorSeq: state.errorSeq + 1 }));
      return;
    }
    if (code === GAME_ERROR_CODE.InsufficientKen && request.kind === 'join') {
      closeModals();
      showInsufficientKen(request.room.bet);
      return;
    }
    if (code === GAME_ERROR_CODE.BetNotAllowed) {
      closeModals();
      showBetNotAllowed();
      return;
    }
    if (REFRESH_AFTER.has(code)) {
      closeModals();
      tycoon().showToast(roomToastText(code));
      void get().refresh();
      return;
    }
    tycoon().showToast(roomToastText(code));
  };

  const succeed = () => {
    clearPending();
    closeModals();
    playSound('click');
  };

  const fail = (code: string) => {
    const request = pending;
    clearPending();
    if (request) handleFailure(code, request);
  };

  function run(request: RoomRequest): void {
    if (get().pendingId) return;
    const session = tycoon().session();
    if (!session || tycoon().online !== 'ready') {
      handleFailure(NETWORK_ERROR, request);
      return;
    }
    if (request.kind === 'spectate' && !request.room.matchId) {
      handleFailure(GAME_ERROR_CODE.MatchNotFound, request);
      return;
    }
    pending = request;
    set({ pendingId: request.kind === 'create' ? 'create' : request.room.id });
    pendingTimer = setTimeout(() => fail(NETWORK_ERROR), REQUEST_TIMEOUT_MS);
    if (request.kind === 'create')
      session.createRoom(request.input.bet, request.input.password || undefined, request.input.maxPlayers, request.input.allowSpectators);
    else if (request.kind === 'spectate') tycoon().watchMatch(request.room.matchId ?? '');
    else session.joinRoom(request.room.id, request.password);
  }

  const attach = () => {
    detach();
    const session = tycoon().session();
    if (!session || tycoon().online !== 'ready') {
      if (tycoon().online === 'offline') {
        set({ status: 'error', refreshing: false });
        return;
      }
      waitOnline = useTycoon.subscribe((state) => {
        if (state.online === 'ready' && state.session()) attach();
        else if (state.online === 'offline') {
          detach();
          set({ status: 'error', refreshing: false });
        }
      });
      return;
    }
    unsubs = [
      session.onRoomList((data) => {
        const rooms = data.rooms.map(toRoom);
        set((state) => ({ rooms, status: 'ready', refreshing: false, page: Math.min(state.page, pageCount(rooms.length) - 1) }));
      }),
      session.onRoomUpsert((data) => {
        set((state) => ({ rooms: [toRoom(data.room), ...state.rooms.filter((room) => room.id !== data.room.id)] }));
      }),
      session.onRoomRemoved((data) => {
        set((state) => {
          const rooms = state.rooms.filter((room) => room.id !== data.roomId);
          return { rooms, page: Math.min(state.page, pageCount(rooms.length) - 1) };
        });
      }),
      session.onRoomState((data) => {
        if (!data.watcher && pending && pending.kind !== 'spectate') succeed();
      }),
      session.onSpectateJoined(() => {
        if (pending?.kind === 'spectate') succeed();
      }),
      session.onError((data: ErrorData) => {
        if (pending) fail(data.code);
      }),
    ];
    session.listRooms();
  };

  return {
    status: 'loading',
    rooms: [],
    refreshing: false,
    page: 0,
    pendingId: null,
    createOpen: false,
    createPlayers: DEFAULT_MAX_PLAYERS,
    createError: null,
    lockedRoom: null,
    lockedError: null,
    errorSeq: 0,

    load() {
      if (tycoon().online === 'offline') tycoon().connect();
      set({ page: 0, status: 'loading', refreshing: false });
      clearPending();
      closeModals();
      attach();
      return Promise.resolve();
    },

    leave() {
      detach();
      clearPending();
      set({ refreshing: false });
      closeModals();
    },

    async refresh() {
      const session = tycoon().session();
      if (!session || tycoon().online !== 'ready') {
        attach();
        return;
      }
      if (unsubs.length === 0) attach();
      set(get().status === 'ready' ? { refreshing: true } : { status: 'loading' });
      session.listRooms();
    },

    setPage(page: number) {
      set({ page: Math.min(Math.max(0, page), pageCount(get().rooms.length) - 1) });
    },

    async join(room: TycoonRoom) {
      if (get().pendingId) return;
      if (room.bet > playerKen()) {
        showInsufficientKen(room.bet);
        return;
      }
      if (room.locked) {
        playSound('click');
        set({ lockedRoom: room, lockedError: null });
        return;
      }
      run({ kind: 'join', room });
    },

    async submitPassword(password: string) {
      const room = get().lockedRoom;
      if (!room || !password) return;
      set({ lockedError: null });
      run({ kind: 'join', room, password });
    },

    clearLockedError() {
      if (get().lockedError) set({ lockedError: null });
    },

    closeLocked() {
      if (get().pendingId) return;
      set({ lockedRoom: null, lockedError: null });
    },

    async spectate(room: TycoonRoom) {
      if (get().pendingId) return;
      run({ kind: 'spectate', room });
    },

    openCreate() {
      playSound('click');
      set({ createOpen: true, createError: null });
    },

    closeCreate() {
      if (get().pendingId) return;
      set({ createOpen: false, createError: null });
    },

    setCreatePlayers(count: number) {
      set({ createPlayers: count });
    },

    setCreateError(error: FieldError | null) {
      set((state) => ({ createError: error, errorSeq: error ? state.errorSeq + 1 : state.errorSeq }));
    },

    async submitCreate(input: CreateRoomInput) {
      set({ createError: null });
      run({ kind: 'create', input });
    },
  };
});
