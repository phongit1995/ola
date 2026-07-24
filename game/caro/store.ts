import { create } from 'zustand';
import {
  bridge,
  joinGame,
  type GameSession,
  type MatchFoundData,
  type PlayerInfo,
  type RoomInfo,
  type RoomStateData,
  type UserInfoData,
} from '../src/sdk';
import { parseVipTypeId, vipIconUrl } from '@ola/shared/lib/vip';
import { BOARD_ASSETS, VIP_DEFAULT_ICON } from './assets';
import { createBotSession, type BotLevel } from './bot';
import { SIZE, emptyState, findWinLine, type CaroMove, type CaroState, type WinLine } from './types';

export type OverlayAction = 'again' | 'cancel' | 'lobby';

export interface OverlayState {
  title: string;
  sub: string;
  kind?: 'win' | 'lose' | 'draw';
  actions: OverlayAction[];
}

export interface PlayerDisplay {
  name: string;
  vip: string;
  mark: 'x' | 'o';
  active: boolean;
}

export interface ChatMsg {
  id: number;
  who: string;
  text: string;
}

const BOT_VIP_ID: Record<BotLevel, number> = { easy: 1, normal: 2, hard: 3 };

function avatarIconSrc(vipType?: string | null): string {
  const id = parseVipTypeId(vipType);
  return id != null ? vipIconUrl(id) : VIP_DEFAULT_ICON;
}

function opponentOf(players: PlayerInfo[], you: number): PlayerInfo {
  return players[1 - you];
}

function formatClock(seconds: number): string {
  const m = Math.floor(seconds / 60);
  const s = seconds % 60;
  return `${String(m).padStart(2, '0')}:${String(s).padStart(2, '0')}`;
}

const EMPTY_PLAYER: PlayerDisplay = { name: '---', vip: VIP_DEFAULT_ICON, mark: 'x', active: false };

function roomErrorText(code: string): string | null {
  switch (code) {
    case 'WRONG_PASSWORD':
      return 'Sai mật khẩu';
    case 'ROOM_NOT_FOUND':
      return 'Bàn không còn nữa';
    case 'OWN_ROOM':
      return 'Không thể vào bàn của bạn';
    default:
      return null;
  }
}

export interface CaroStore {
  lobbyVisible: boolean;
  lobbyPhase: 'loading' | 'connecting' | 'error' | 'ready';
  lobbyAnimKey: number;
  userInfo: UserInfoData | null;
  ken: number;

  rankedVisible: boolean;
  leaderboardVisible: boolean;
  rooms: RoomInfo[];
  roomWaiting: RoomStateData | null;
  oppAway: number | null;

  board: number[];
  lastIdx: number;
  status: string;
  myTurn: boolean;
  showTimer: boolean;
  timerText: string;
  timerUrgent: boolean;
  turnArrowSrc: string | null;
  me: PlayerDisplay;
  op: PlayerDisplay;
  overlay: OverlayState | null;
  replayVisible: boolean;
  forfeitDisabled: boolean;

  result: { win: boolean; kenDelta: number | null } | null;
  toast: string | null;
  matchSeq: number;
  turnAnnounce: { id: number; text: string; mine: boolean } | null;
  winLine: WinLine | null;
  messages: ChatMsg[];

  init(ready: boolean): void;
  dispose(): void;
  playBot(level: BotLevel): void;
  playRanked(): void;
  refreshRooms(): void;
  createRoom(bet: number, password?: string): void;
  joinRoom(roomId: string, password?: string): void;
  cancelRoom(): void;
  toggleRoomReady(): void;
  startRoom(): void;
  kickRoomGuest(): void;
  showLeaderboard(): void;
  hideLeaderboard(): void;
  retry(): void;
  exitApp(): void;
  placeMove(x: number, y: number): void;
  again(): void;
  replay(): void;
  cancelSearch(): void;
  toLobby(): void;
  forfeit(): void;
  exitMatch(): void;
  closeResult(): void;
  showToast(message: string): void;
  sendChat(text: string): void;
}

export const useCaroStore = create<CaroStore>()((set, get) => {
  const refs = {
    online: null as GameSession<CaroState, CaroMove> | null,
    bot: null as GameSession<CaroState, CaroMove> | null,
    botLevel: null as BotLevel | null,
    session: null as GameSession<CaroState, CaroMove> | null,
    match: null as MatchFoundData<CaroState> | null,
    matchBet: 0,
    user: null as UserInfoData | null,
    connecting: false,
    deadline: 0,
    timer: undefined as number | undefined,
    toastTimer: undefined as number | undefined,
    kenRaf: undefined as number | undefined,
    announceId: 0,
    opponentIsBot: false,
  };

  const showToast = (message: string): void => {
    set({ toast: message });
    window.clearTimeout(refs.toastTimer);
    refs.toastTimer = window.setTimeout(() => set({ toast: null }), 2200);
  };

  const animateKen = (target: number): void => {
    if (refs.kenRaf) cancelAnimationFrame(refs.kenRaf);
    const from = get().ken;
    const start = performance.now();
    const duration = from === target ? 0 : 700;
    const step = (now: number): void => {
      const t = duration === 0 ? 1 : Math.min(1, (now - start) / duration);
      const eased = 1 - (1 - t) * (1 - t);
      set({ ken: from + (target - from) * eased });
      if (t < 1) refs.kenRaf = requestAnimationFrame(step);
    };
    refs.kenRaf = requestAnimationFrame(step);
  };

  const stopTimer = (): void => {
    if (refs.timer) window.clearInterval(refs.timer);
    refs.timer = undefined;
  };

  const clearMatchUi = (): void => {
    stopTimer();
    set((s) => ({
      forfeitDisabled: true,
      myTurn: false,
      me: { ...s.me, active: false },
      op: { ...s.op, active: false },
      showTimer: false,
      timerUrgent: false,
      turnArrowSrc: null,
      turnAnnounce: null,
      winLine: null,
      oppAway: null,
    }));
  };

  const applyTurn = (turn: number, deadlineMs: number): void => {
    const match = refs.match;
    if (!match) return;
    const mine = turn === match.you;
    refs.deadline = deadlineMs;
    refs.announceId += 1;
    set((s) => ({
      myTurn: mine,
      status: mine ? 'Lượt của bạn' : 'Đợi đối thủ...',
      turnAnnounce: {
        id: refs.announceId,
        mine,
        text: mine ? 'ĐẾN LƯỢT BẠN' : refs.opponentIsBot ? 'ĐẾN LƯỢT MÁY' : 'ĐẾN LƯỢT ĐỐI THỦ',
      },
      me: { ...s.me, active: mine },
      op: { ...s.op, active: !mine },
      showTimer: true,
      turnArrowSrc: mine ? BOARD_ASSETS.boardTurnLeft : BOARD_ASSETS.boardTurnRight,
    }));
    bridge.turnChanged({ yourTurn: mine, deadline: deadlineMs });
    stopTimer();
    const tick = (): void => {
      const left = Math.max(0, Math.ceil((refs.deadline - Date.now()) / 1000));
      set({ timerText: formatClock(left), timerUrgent: left <= 10 });
      if (left === 0) stopTimer();
    };
    tick();
    refs.timer = window.setInterval(tick, 250);
  };

  const renderState = (s: CaroState): void => {
    set({ board: [...s.board], lastIdx: s.lastX >= 0 ? s.lastY * SIZE + s.lastX : -1 });
  };

  const wireSession = (target: GameSession<CaroState, CaroMove>): void => {
    target.onUserInfo((info) => {
      refs.user = info;
      set((s) => ({ userInfo: info, lobbyPhase: 'ready', lobbyAnimKey: s.lobbyAnimKey + 1 }));
      animateKen(info.ken ?? 0);
    });

    target.onConnectionChange((connected) => {
      if (refs.session === target && !connected) {
        set({ status: 'Mất kết nối, đang thử lại...' });
      }
    });

    target.onQueueWaiting(() => {
      if (refs.session !== target) return;
      set({
        lobbyVisible: false,
        overlay: { title: 'Đang tìm trận...', sub: 'Đợi người chơi khác vào hàng chờ', actions: ['cancel'] },
        status: 'Đang tìm trận',
      });
    });

    target.onRoomList((data) => {
      if (refs.session !== target) return;
      set({ rooms: data.rooms });
    });

    target.onRoomWaiting((data) => {
      if (refs.session !== target) return;
      refs.matchBet = data.bet;
      set((s) => ({
        roomWaiting:
          s.roomWaiting?.roomId === data.roomId
            ? { ...s.roomWaiting, bet: data.bet, locked: data.locked }
            : { roomId: data.roomId, ownerId: '', youId: '', bet: data.bet, locked: data.locked, members: [] },
      }));
    });

    target.onRoomState((data) => {
      if (refs.session !== target) return;
      refs.matchBet = data.bet;
      set({ roomWaiting: data });
    });

    target.onRoomClosed((data) => {
      if (refs.session !== target) return;
      if (get().roomWaiting?.roomId !== data.roomId) return;
      set({ roomWaiting: null });
      if (data.reason === 'owner_left' || data.reason === 'owner_disconnected' || data.reason === 'owner_busy') {
        showToast('Chủ phòng đã rời, phòng đã đóng');
      }
      refs.online?.listRooms();
    });

    target.onRoomKicked((data) => {
      if (refs.session !== target) return;
      if (get().roomWaiting?.roomId !== data.roomId) return;
      set({ roomWaiting: null });
      showToast('Bạn đã bị chủ phòng mời ra');
      refs.online?.listRooms();
    });

    target.onOpponentDisconnected((data) => {
      if (refs.session !== target) return;
      set({ oppAway: data.graceDeadline, status: 'Đối thủ mất kết nối, đang chờ...' });
      showToast('Đối thủ mất kết nối');
    });

    target.onOpponentReconnected(() => {
      if (refs.session !== target) return;
      set({ oppAway: null, status: 'Đối thủ đã kết nối lại' });
      showToast('Đối thủ đã kết nối lại');
    });

    target.onMatchFound((data) => {
      if (refs.session !== target) {
        if (target !== refs.online || !data.resumed) return;
        refs.session = refs.online;
      }
      refs.match = data;
      refs.matchBet = data.bet ?? refs.matchBet;
      refs.opponentIsBot = target === refs.bot;
      const isBot = target === refs.bot && refs.botLevel != null;
      const botVip = isBot ? vipIconUrl(BOT_VIP_ID[refs.botLevel as BotLevel]) : VIP_DEFAULT_ICON;
      const user = refs.user;
      const meMark: 'x' | 'o' = data.you === 0 ? 'x' : 'o';
      set((s) => ({
        matchSeq: s.matchSeq + 1,
        lobbyVisible: false,
        rankedVisible: false,
        leaderboardVisible: false,
        overlay: null,
        result: null,
        winLine: null,
        roomWaiting: null,
        oppAway: null,
        messages: [],
        me: {
          name: user ? `@${user.username}` : data.players[data.you].name,
          vip: user ? avatarIconSrc(user.vipType) : VIP_DEFAULT_ICON,
          mark: meMark,
          active: false,
        },
        op: {
          name: opponentOf(data.players, data.you).name,
          vip: botVip,
          mark: meMark === 'x' ? 'o' : 'x',
          active: false,
        },
        forfeitDisabled: false,
        replayVisible: target === refs.bot,
      }));
      renderState(data.state);
      applyTurn(data.turn, data.deadline);
      if (data.resumed) set({ status: 'Đã vào lại trận đấu' });
    });

    target.onState((data) => {
      if (refs.session !== target) return;
      renderState(data.state);
      if (data.turn < 0) {
        stopTimer();
        const { lastX, lastY, board } = data.state;
        const line = lastX >= 0 ? findWinLine(board, lastX, lastY, board[lastY * SIZE + lastX]) : null;
        set({ myTurn: false, showTimer: false, timerUrgent: false, turnAnnounce: null, winLine: line });
        return;
      }
      applyTurn(data.turn, data.deadline);
    });

    target.onMatchOver((data) => {
      if (refs.session !== target) return;
      clearMatchUi();
      renderState(data.state);
      const match = refs.match;
      const won = match != null && data.winnerId === match.players[match.you].id;
      const draw = data.winnerId == null || data.winnerId === '';
      if (draw) {
        set({ overlay: { title: 'Hòa!', sub: '', kind: 'draw', actions: ['again', 'lobby'] }, status: 'Chơi ván mới?' });
      } else {
        const bet = refs.matchBet;
        set({ result: { win: won, kenDelta: bet > 0 ? (won ? bet : -bet) : null } });
      }
      bridge.gameOver({ matchId: data.matchId, winnerId: data.winnerId, reason: data.reason, won });
      refs.match = null;
    });

    target.onError((err) => {
      if (refs.session !== target) return;
      if (!refs.match) {
        showToast(roomErrorText(err.code) ?? err.message);
        return;
      }
      set({ status: err.message });
    });
  };

  const connectToServer = async (): Promise<void> => {
    if (refs.connecting) return;
    refs.connecting = true;
    set({ lobbyPhase: 'connecting' });
    try {
      if (!refs.online) {
        refs.online = await joinGame<CaroState, CaroMove>('caro');
        wireSession(refs.online);
      }
      await new Promise<void>((resolve, reject) => {
        const off = refs.online!.onUserInfo(() => {
          off();
          clearTimeout(timer);
          resolve();
        });
        const timer = setTimeout(() => {
          off();
          reject(new Error('connect timeout'));
        }, 8000);
      });
    } catch {
      refs.online?.disconnect();
      refs.online = null;
      refs.user = null;
      set({ userInfo: null, lobbyPhase: 'error' });
    } finally {
      refs.connecting = false;
    }
  };

  const toLobby = (): void => {
    const waitingRoom = get().roomWaiting;
    if (waitingRoom) refs.online?.leaveRoom(waitingRoom.roomId);
    set((s) => ({
      overlay: null,
      result: null,
      rankedVisible: false,
      leaderboardVisible: false,
      lobbyVisible: true,
      roomWaiting: null,
      lobbyAnimKey: s.lobbyAnimKey + 1,
    }));
    if (!refs.user && !refs.connecting) void connectToServer();
  };

  return {
    lobbyVisible: true,
    lobbyPhase: 'loading',
    lobbyAnimKey: 0,
    userInfo: null,
    ken: 0,
    rankedVisible: false,
    leaderboardVisible: false,
    rooms: [],
    roomWaiting: null,
    oppAway: null,
    board: emptyState().board,
    lastIdx: -1,
    status: 'Sẵn sàng',
    myTurn: false,
    showTimer: false,
    timerText: '00:45',
    timerUrgent: false,
    turnArrowSrc: null,
    me: EMPTY_PLAYER,
    op: { ...EMPTY_PLAYER, mark: 'o' },
    overlay: null,
    replayVisible: false,
    forfeitDisabled: true,
    result: null,
    toast: null,
    matchSeq: 0,
    turnAnnounce: null,
    winLine: null,
    messages: [],

    init(ready) {
      if (!ready) return;
      set((s) => ({ lobbyPhase: s.lobbyPhase === 'loading' ? 'connecting' : s.lobbyPhase }));
      void connectToServer();
    },

    dispose() {
      stopTimer();
      window.clearTimeout(refs.toastTimer);
      if (refs.kenRaf) cancelAnimationFrame(refs.kenRaf);
    },

    playBot(level) {
      if (!refs.bot || refs.botLevel !== level) {
        refs.bot?.disconnect();
        refs.bot = createBotSession(level);
        refs.botLevel = level;
        wireSession(refs.bot);
      }
      refs.matchBet = 0;
      refs.session = refs.bot;
      refs.session.joinQueue();
    },

    playRanked() {
      set({ lobbyVisible: false, leaderboardVisible: false, rankedVisible: true, rooms: [], roomWaiting: null });
      const enter = (): void => {
        if (!refs.online) return;
        refs.session = refs.online;
        refs.online.listRooms();
      };
      if (refs.online) enter();
      else void connectToServer().then(enter);
    },

    refreshRooms() {
      refs.online?.listRooms();
    },

    createRoom(bet, password) {
      if (!refs.online) return;
      refs.session = refs.online;
      refs.matchBet = bet;
      refs.online.createRoom(bet, password || undefined);
    },

    joinRoom(roomId, password) {
      if (!refs.online) return;
      refs.session = refs.online;
      refs.online.joinRoom(roomId, password || undefined);
    },

    cancelRoom() {
      const room = get().roomWaiting;
      refs.online?.leaveRoom(room?.roomId);
      set({ roomWaiting: null });
      refs.online?.listRooms();
    },

    toggleRoomReady() {
      const room = get().roomWaiting;
      if (!room) return;
      const me = room.members.find((member) => member.id === room.youId);
      refs.online?.setRoomReady(room.roomId, !(me?.ready ?? false));
    },

    startRoom() {
      const room = get().roomWaiting;
      if (room) refs.online?.startRoom(room.roomId);
    },

    kickRoomGuest() {
      const room = get().roomWaiting;
      if (!room || room.ownerId !== room.youId) return;
      const guest = room.members.find((member) => !member.owner);
      if (guest) refs.online?.kickRoomMember(room.roomId, guest.id);
    },

    showLeaderboard() {
      set({ lobbyVisible: true, rankedVisible: false, leaderboardVisible: true });
    },

    hideLeaderboard() {
      set({ leaderboardVisible: false });
    },

    placeMove(x, y) {
      if (!refs.match || !get().myTurn) return;
      refs.session?.sendMove(refs.match.matchId, { x, y });
    },

    again() {
      if (refs.session === refs.bot) {
        refs.session?.joinQueue();
        return;
      }
      set({ overlay: null });
      get().playRanked();
    },

    replay() {
      if (refs.match && !window.confirm('Chơi lại ván mới?')) return;
      refs.session?.joinQueue();
    },

    cancelSearch() {
      refs.session?.leaveQueue();
      toLobby();
    },

    forfeit() {
      if (refs.match && window.confirm('Bỏ cuộc trận này?')) refs.session?.forfeit(refs.match.matchId);
    },

    exitMatch() {
      if (refs.match) refs.session?.forfeit(refs.match.matchId);
      refs.match = null;
      clearMatchUi();
      toLobby();
    },

    closeResult() {
      set({ result: null });
      toLobby();
    },

    retry() {
      void connectToServer();
    },

    exitApp() {
      bridge.exit();
    },

    toLobby,
    showToast,

    sendChat(text) {
      const trimmed = text.trim();
      if (!trimmed) return;
      const me = get().me;
      const who = me.name && me.name !== '---' ? me.name : 'Bạn';
      set((s) => ({ messages: [...s.messages, { id: Date.now(), who, text: trimmed }] }));
    },
  };
});

if (import.meta.env.DEV) {
  (window as unknown as { caroStore?: typeof useCaroStore }).caroStore = useCaroStore;
}
