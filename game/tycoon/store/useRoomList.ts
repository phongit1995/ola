import { create } from 'zustand';
import { GAME_ERROR_CODE } from '../../src/sdk';
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
import { RoomRequestError, mockCreateRoom, mockFetchRooms, mockJoinRoom, mockSpectate } from '../helpers/roomMock';
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

const errorCode = (error: unknown): string => (error instanceof RoomRequestError ? error.code : NETWORK_ERROR);

const tycoon = () => useTycoon.getState();

const playerKen = (): number => tycoon().profile?.ken ?? 0;

export const useRoomList = create<RoomListState>((set, get) => {
  let loadSeq = 0;
  let session = 0;

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

  const succeed = (request: RoomRequest, room: TycoonRoom) => {
    closeModals();
    playSound('click');
    if (request.kind === 'spectate') tycoon().showToast(`Đang xem bàn của @${room.owner}. Chế độ xem đang được làm`);
    else if (request.kind === 'create') tycoon().showToast('Đã tạo bàn. Phòng chờ đang được làm');
    else tycoon().showToast(`Đã vào bàn của @${room.owner}. Phòng chờ đang được làm`);
    void get().refresh();
  };

  const send = (request: RoomRequest): Promise<TycoonRoom> => {
    if (request.kind === 'create') return mockCreateRoom(request.input);
    if (request.kind === 'spectate') return mockSpectate(request.room.id);
    return mockJoinRoom(request.room.id, request.password);
  };

  async function run(request: RoomRequest): Promise<void> {
    if (get().pendingId) return;
    const owner = session;
    set({ pendingId: request.kind === 'create' ? 'create' : request.room.id });
    try {
      const room = await send(request);
      if (owner !== session) return;
      set({ pendingId: null });
      succeed(request, room);
    } catch (error) {
      if (owner !== session) return;
      set({ pendingId: null });
      handleFailure(errorCode(error), request);
    }
  }

  const fetchRooms = async (mode: 'load' | 'refresh') => {
    const seq = ++loadSeq;
    set(mode === 'load' ? { status: 'loading', refreshing: false } : { refreshing: true });
    try {
      const rooms = await mockFetchRooms();
      if (seq !== loadSeq) return;
      set((state) => ({ rooms, status: 'ready', refreshing: false, page: Math.min(state.page, pageCount(rooms.length) - 1) }));
    } catch {
      if (seq !== loadSeq) return;
      if (get().status === 'ready') {
        set({ refreshing: false });
        tycoon().showToast('Chưa làm mới được danh sách bàn');
        return;
      }
      set({ status: 'error', refreshing: false });
    }
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
      session += 1;
      set({ page: 0, pendingId: null });
      closeModals();
      return fetchRooms('load');
    },

    leave() {
      session += 1;
      loadSeq += 1;
      set({ pendingId: null, refreshing: false });
      closeModals();
    },

    async refresh() {
      if (get().status !== 'ready') {
        await fetchRooms('load');
        return;
      }
      await fetchRooms('refresh');
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
      await run({ kind: 'join', room });
    },

    async submitPassword(password: string) {
      const room = get().lockedRoom;
      if (!room || !password) return;
      set({ lockedError: null });
      await run({ kind: 'join', room, password });
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
      await run({ kind: 'spectate', room });
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
      await run({ kind: 'create', input });
    },
  };
});
