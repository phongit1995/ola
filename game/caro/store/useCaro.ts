import { create } from 'zustand';
import { ARCADE_ATTENTION_REASON } from '@ola/shared/constants';
import {
  bridge,
  GAME_ERROR_CODE,
  GameAuthenticationExpiredError,
  GameAuthenticationRequiredError,
  joinGame,
  type GameSession,
  type LeaderboardPeriod,
  type MatchFoundData,
  type RoomStateData,
  type UserInfoData,
} from '../../src/sdk';
import { vipIconUrl } from '@ola/shared/lib/vip';
import {
  BOARD_ASSETS,
  VIP_DEFAULT_ICON,
  preloadBoardAssets,
  preloadHistoryAssets,
  preloadLeaderboardAssets,
  preloadRankedAssets,
  preloadReactionAssets,
  preloadResultAssets,
} from '../assets';
import { createBotSession } from '../bot';
import { findFinalWinLine } from '../helpers/board';
import { chatErrorText, matchErrorText, reactionErrorText, roomErrorText } from '../helpers/errorText';
import { formatClock } from '../helpers/format';
import { mergeMatchHistory, readBotHistory, saveBotHistory } from '../helpers/history';
import { avatarIconSrc, opponentOf } from '../helpers/player';
import { roomCreationError } from '../helpers/room';
import type { CaroStore, RoomActionPending } from './types';
import { createInitialCaroState, EMPTY_PLAYER } from './initialState';
import {
  SIZE,
  emptyState,
  type BotLevel,
  type CaroMove,
  type CaroState,
} from '../types';

const BOT_VIP_ID: Record<BotLevel, number> = { easy: 1, normal: 2, hard: 3 };
const CHAT_HISTORY_LIMIT = 100;
const WIN_RESULT_REVEAL_MS = 1700;
const LEADERBOARD_REQUEST_TIMEOUT_MS = 8000;
const HISTORY_REQUEST_TIMEOUT_MS = 8000;
const AUTHENTICATION_REQUIRED_TEXT = 'Vui lòng đăng nhập để chơi Cờ Caro';
const AUTHENTICATION_EXPIRED_TEXT = 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại';

function authenticationErrorText(error: unknown): string | null {
  if (error instanceof GameAuthenticationRequiredError) return AUTHENTICATION_REQUIRED_TEXT;
  if (error instanceof GameAuthenticationExpiredError) return AUTHENTICATION_EXPIRED_TEXT;
  return null;
}

export const useCaro = create<CaroStore>()((set, get) => {
  const refs = {
    online: null as GameSession<CaroState, CaroMove> | null,
    bot: null as GameSession<CaroState, CaroMove> | null,
    botLevel: null as BotLevel | null,
    session: null as GameSession<CaroState, CaroMove> | null,
    match: null as MatchFoundData<CaroState> | null,
    matchBet: 0,
    user: null as UserInfoData | null,
    connecting: false,
    connectPromise: null as Promise<void> | null,
    deadline: 0,
    timer: undefined as number | undefined,
    toastTimer: undefined as number | undefined,
    kenRaf: undefined as number | undefined,
    announceId: 0,
    opponentIsBot: false,
    chatOpponentId: null as string | null,
    chatSeq: 0,
    reactionSeq: 0,
    pendingRoomId: null as string | null,
    roomConnectionLost: false,
    exitingMatch: null as MatchFoundData<CaroState> | null,
    handledMatchIds: new Set<string>(),
    leaderboardTimers: { day: undefined, week: undefined } as Record<LeaderboardPeriod, number | undefined>,
    historyTimer: undefined as number | undefined,
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
      movePending: false,
      me: { ...s.me, active: false },
      op: { ...s.op, active: false },
      showTimer: false,
      timerUrgent: false,
      turnArrowSrc: null,
      turnAnnounce: null,
      winLine: null,
      oppAway: null,
      reactionNotice: null,
    }));
  };

  const enterPendingRoom = (pending: Exclude<RoomActionPending, null>, status: string): void => {
    stopTimer();
    refs.match = null;
    refs.opponentIsBot = false;
    refs.chatOpponentId = null;
    refs.chatSeq = 0;
    refs.pendingRoomId = null;
    const user = refs.user;
    set((s) => ({
      boardMode: 'pregame',
      roomActionPending: pending,
      lobbyVisible: false,
      rankedVisible: false,
      leaderboardVisible: false,
      overlay: null,
      result: null,
      roomWaiting: null,
      bet: refs.matchBet,
      board: emptyState().board,
      lastIdx: -1,
      status,
      myTurn: false,
      movePending: false,
      showTimer: false,
      timerUrgent: false,
      turnArrowSrc: null,
      turnAnnounce: null,
      winLine: null,
      replayVisible: false,
      forfeitDisabled: true,
      messages: [],
      matchSeq: s.matchSeq + 1,
      me: {
        name: user ? `@${user.username}` : '@Bạn',
        vip: user ? avatarIconSrc(user.vipType) : VIP_DEFAULT_ICON,
        mark: 'x',
        active: false,
        owner: false,
      },
      op: { ...EMPTY_PLAYER, name: 'Đang chờ...', mark: 'o' },
    }));
  };

  const applyRoomState = (room: RoomStateData): void => {
    stopTimer();
    const current = get();
    const previousRoom =
      current.roomWaiting?.roomId === room.roomId ? current.roomWaiting : null;
    const previousOpponent = previousRoom?.members.find(
      (member) => member.id !== previousRoom.youId,
    );
    refs.match = null;
    refs.opponentIsBot = false;
    refs.pendingRoomId = room.roomId;
    refs.matchBet = room.bet;
    const meMember = room.members.find((member) => member.id === room.youId);
    const opponent = room.members.find((member) => member.id !== room.youId);
    const preserveChat = opponent != null && refs.chatOpponentId === opponent.id;
    if (!preserveChat) refs.chatSeq = 0;
    refs.chatOpponentId = opponent?.id ?? null;
    const isOwner = room.ownerId === room.youId;
    const bothReady = room.members.length === 2 && room.members.every((member) => member.ready);
    // MATCH_OVER is followed immediately by ROOM_WAITING and ROOM_STATE. Keep
    // presenting the completed match until its result UI is dismissed.
    const preserveOutcome = current.result != null || current.overlay?.kind != null;
    const status = !opponent
      ? 'Đang chờ đối thủ vào bàn...'
      : bothReady
      ? isOwner
        ? 'Cả hai đã sẵn sàng — bấm Bắt đầu'
        : 'Đang chờ chủ phòng bắt đầu...'
      : meMember?.ready
      ? 'Đang chờ đối thủ sẵn sàng...'
      : 'Đối thủ đã vào bàn — hãy bấm Sẵn sàng';
    const firstRoomState = current.roomWaiting?.roomId !== room.roomId;
    const user = refs.user;
    if (previousRoom) {
      if (!previousOpponent && opponent) {
        bridge.attention({
          reason: ARCADE_ATTENTION_REASON.OpponentJoined,
          roomId: room.roomId,
        });
      } else if (previousOpponent && opponent && !previousOpponent.ready && opponent.ready) {
        bridge.attention({
          reason: ARCADE_ATTENTION_REASON.OpponentReady,
          roomId: room.roomId,
        });
      } else if (previousOpponent && !opponent) {
        bridge.attention({
          reason: ARCADE_ATTENTION_REASON.OpponentLeft,
          roomId: room.roomId,
        });
      }
    }
    set((s) => ({
      boardMode: preserveOutcome ? s.boardMode : 'pregame',
      roomActionPending: null,
      lobbyVisible: false,
      rankedVisible: false,
      leaderboardVisible: false,
      overlay: preserveOutcome ? s.overlay : null,
      result: preserveOutcome ? s.result : null,
      roomWaiting: room,
      bet: room.bet,
      board: preserveOutcome ? s.board : firstRoomState ? emptyState().board : s.board,
      lastIdx: preserveOutcome ? s.lastIdx : firstRoomState ? -1 : s.lastIdx,
      status: preserveOutcome ? s.status : status,
      myTurn: false,
      movePending: false,
      showTimer: false,
      timerUrgent: false,
      turnArrowSrc: null,
      turnAnnounce: null,
      winLine: preserveOutcome ? s.winLine : null,
      replayVisible: false,
      forfeitDisabled: true,
      messages: preserveChat ? s.messages : [],
      matchSeq: firstRoomState ? s.matchSeq + 1 : s.matchSeq,
      me: preserveOutcome
        ? s.me
        : {
            name: meMember ? `@${meMember.name}` : user ? `@${user.username}` : '@Bạn',
            vip: avatarIconSrc(meMember?.vipType ?? user?.vipType),
            mark: 'x',
            active: false,
            owner: meMember?.owner ?? false,
          },
      op: preserveOutcome
        ? s.op
        : opponent
          ? {
              name: `@${opponent.name}`,
              vip: avatarIconSrc(opponent.vipType),
              mark: 'o',
              active: false,
              owner: opponent.owner,
            }
          : { ...EMPTY_PLAYER, name: 'Đang chờ...', mark: 'o' },
    }));
  };

  const showWaitingRoom = (): boolean => {
    const room = get().roomWaiting;
    if (!room) return false;
    set({
      overlay: null,
      result: null,
      board: emptyState().board,
      lastIdx: -1,
      winLine: null,
    });
    applyRoomState(room);
    return true;
  };

  const applyTurn = (turn: number, deadlineMs: number): void => {
    const match = refs.match;
    if (!match) return;
    const mine = turn === match.you;
    refs.deadline = deadlineMs;
    refs.announceId += 1;
    set((s) => ({
      myTurn: mine,
      movePending: false,
      status: mine ? 'Lượt của bạn' : 'Đợi đối thủ...',
      turnAnnounce: {
        id: refs.announceId,
        mine,
        text: mine ? 'ĐẾN LƯỢT BẠN' : refs.opponentIsBot ? 'ĐẾN LƯỢT MÁY' : 'ĐẾN LƯỢT ĐỐI THỦ',
      },
      me: { ...s.me, active: mine },
      op: { ...s.op, active: !mine },
      showTimer: true,
      turnArrowSrc: mine ? BOARD_ASSETS.boardTurnRight : BOARD_ASSETS.boardTurnLeft,
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
      bridge.refreshUser();
      set((s) => ({
        userInfo: info,
        lobbyPhase: 'ready',
        lobbyError: null,
        lobbyAnimKey: s.lobbyAnimKey + 1,
        history: mergeMatchHistory(s.history, readBotHistory(info.id)),
      }));
      animateKen(info.ken ?? 0);
    });

    target.onConnectionChange((connected) => {
      if (refs.session !== target) return;
      if (!connected) {
        if (target === refs.online && get().boardMode === 'pregame') refs.roomConnectionLost = true;
        set({ status: 'Mất kết nối, đang thử lại...' });
        return;
      }
      if (target === refs.online && refs.roomConnectionLost && get().boardMode === 'pregame') {
        refs.roomConnectionLost = false;
        refs.pendingRoomId = null;
        refs.matchBet = 0;
        set({
          boardMode: 'idle',
          roomActionPending: null,
          roomWaiting: null,
          bet: 0,
          rankedVisible: true,
          lobbyVisible: false,
          leaderboardVisible: false,
        });
        showToast('Kết nối bị gián đoạn, bạn đã rời bàn');
        target.listRooms();
        return;
      }
      if (target === refs.online && get().rankedVisible) target.listRooms();
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

    target.onRoomUpsert((data) => {
      if (refs.session !== target) return;
      set((state) => {
        const index = state.rooms.findIndex((room) => room.id === data.room.id);
        if (index < 0) return { rooms: [data.room, ...state.rooms] };
        const rooms = [...state.rooms];
        rooms[index] = data.room;
        return { rooms };
      });
    });

    target.onRoomRemoved((data) => {
      if (refs.session !== target) return;
      set((state) => ({ rooms: state.rooms.filter((room) => room.id !== data.roomId) }));
    });

    target.onLeaderboard((data) => {
      if (target !== refs.online || (data.period !== 'day' && data.period !== 'week')) return;
      const period = data.period;
      window.clearTimeout(refs.leaderboardTimers[period]);
      refs.leaderboardTimers[period] = undefined;
      set((state) => ({
        leaderboards: data.error
          ? state.leaderboards
          : {
              ...state.leaderboards,
              [period]: data.items,
            },
        leaderboardLoading: {
          ...state.leaderboardLoading,
          [period]: false,
        },
        leaderboardErrors: {
          ...state.leaderboardErrors,
          [period]: data.error ?? null,
        },
      }));
    });

    target.onHistory((data) => {
      if (target !== refs.online) return;
      window.clearTimeout(refs.historyTimer);
      refs.historyTimer = undefined;
      set((state) => ({
        history: data.error
          ? state.history
          : mergeMatchHistory(data.items, refs.user ? readBotHistory(refs.user.id) : []),
        historyLoading: false,
        historyError: data.error ?? null,
      }));
    });

    target.onRoomWaiting((data) => {
      if (refs.session !== target) return;
      refs.matchBet = data.bet;
      refs.pendingRoomId = data.roomId;
      set((s) => ({
        boardMode: s.result != null || s.overlay?.kind != null ? s.boardMode : 'pregame',
        bet: data.bet,
        lobbyVisible: false,
        rankedVisible: false,
        leaderboardVisible: false,
        status:
          s.result != null || s.overlay?.kind != null
            ? s.status
            : s.roomWaiting?.roomId === data.roomId
              ? s.status
              : 'Đang tải thông tin bàn...',
      }));
    });

    target.onRoomState((data) => {
      if (refs.session !== target) return;
      applyRoomState(data);
    });

    target.onRoomClosed((data) => {
      if (refs.session !== target) return;
      const room = get().roomWaiting;
      if (room?.roomId !== data.roomId && refs.pendingRoomId !== data.roomId) return;
      if (
        room != null &&
        room.ownerId !== room.youId &&
        (data.reason === 'owner_left' ||
          data.reason === 'owner_disconnected' ||
          data.reason === 'owner_busy')
      ) {
        bridge.attention({
          reason: ARCADE_ATTENTION_REASON.OpponentLeft,
          roomId: data.roomId,
        });
      }
      refs.pendingRoomId = null;
      refs.chatOpponentId = null;
      refs.chatSeq = 0;
      refs.matchBet = 0;
      set({
        boardMode: 'idle',
        roomActionPending: null,
        roomWaiting: null,
        bet: 0,
        rankedVisible: true,
        lobbyVisible: false,
        leaderboardVisible: false,
        overlay: null,
        result: null,
        board: emptyState().board,
        lastIdx: -1,
        winLine: null,
        oppAway: null,
        messages: [],
      });
      if (data.reason === 'guest_left') {
        showToast('Bạn đã rời bàn');
      } else if (data.reason === 'member_left') {
        showToast('Một người đã thoát bàn, phòng đã được hủy');
      } else if (data.reason === 'owner_left' || data.reason === 'owner_disconnected' || data.reason === 'owner_busy') {
        showToast('Chủ phòng đã rời, phòng đã đóng');
      }
      refs.online?.listRooms();
    });

    target.onRoomKicked((data) => {
      if (refs.session !== target) return;
      if (get().roomWaiting?.roomId !== data.roomId && refs.pendingRoomId !== data.roomId) return;
      bridge.attention({
        reason: ARCADE_ATTENTION_REASON.RoomKicked,
        roomId: data.roomId,
      });
      refs.pendingRoomId = null;
      refs.chatOpponentId = null;
      refs.chatSeq = 0;
      refs.matchBet = 0;
      set({
        boardMode: 'idle',
        roomActionPending: null,
        roomWaiting: null,
        bet: 0,
        rankedVisible: true,
        lobbyVisible: false,
        leaderboardVisible: false,
        overlay: null,
        result: null,
        board: emptyState().board,
        lastIdx: -1,
        winLine: null,
        oppAway: null,
        messages: [],
        notice: 'Bạn đã bị chủ phòng mời ra khỏi bàn.',
      });
      refs.online?.listRooms();
    });

    target.onOpponentDisconnected((data) => {
      if (refs.session !== target) return;
      bridge.attention({
        reason: ARCADE_ATTENTION_REASON.OpponentDisconnected,
        matchId: refs.match?.matchId,
      });
      set({ oppAway: data.graceDeadline, status: 'Đối thủ mất kết nối, đang chờ...' });
      showToast('Đối thủ mất kết nối');
    });

    target.onOpponentReconnected(() => {
      if (refs.session !== target) return;
      set({ oppAway: null, status: 'Đối thủ đã kết nối lại' });
      showToast('Đối thủ đã kết nối lại');
    });

    target.onMatchFound((data) => {
      const resumesOnlineSession = refs.session !== target && target === refs.online && data.resumed === true;
      if (refs.session !== target && !resumesOnlineSession) return;
      const mePlayer = data.players[data.you];
      const opponent = opponentOf(data.players, data.you);
      if (!mePlayer || !opponent) {
        showToast('Dữ liệu người chơi không hợp lệ');
        return;
      }
      if (resumesOnlineSession) refs.session = target;
      refs.match = data;
      preloadBoardAssets();
      preloadResultAssets();
      preloadReactionAssets();
      if (!data.resumed) {
        bridge.attention({
          reason: ARCADE_ATTENTION_REASON.MatchStarted,
          matchId: data.matchId,
        });
      }
      refs.exitingMatch = null;
      const matchBet = data.bet ?? refs.matchBet;
      refs.matchBet = matchBet;
      refs.opponentIsBot = target === refs.bot;
      const isBot = target === refs.bot && refs.botLevel != null;
      const preserveChat = !isBot && refs.chatOpponentId === opponent.id;
      if (!preserveChat) refs.chatSeq = 0;
      refs.chatOpponentId = isBot ? null : opponent.id;
      const opponentVip = isBot
        ? vipIconUrl(BOT_VIP_ID[refs.botLevel as BotLevel])
        : avatarIconSrc(opponent.vipType);
      const user = refs.user;
      const meMark: 'x' | 'o' = data.you === 0 ? 'x' : 'o';
      refs.pendingRoomId = null;
      set((s) => ({
        boardMode: 'playing',
        roomActionPending: null,
        matchSeq: s.matchSeq + 1,
        betDeductionVisible: !data.resumed && target !== refs.bot && matchBet > 0,
        lobbyVisible: false,
        rankedVisible: false,
        leaderboardVisible: false,
        historyVisible: false,
        overlay: null,
        result: null,
        winLine: null,
        roomWaiting: null,
        bet: matchBet,
        oppAway: null,
        messages: preserveChat ? s.messages : [],
        movePending: false,
        me: {
          name: user ? `@${user.username}` : mePlayer.name,
          vip: avatarIconSrc(mePlayer.vipType ?? user?.vipType),
          mark: meMark,
          active: false,
          owner: data.roomOwnerId === mePlayer.id,
        },
        op: {
          name: opponent.name,
          vip: opponentVip,
          mark: meMark === 'x' ? 'o' : 'x',
          active: false,
          owner: data.roomOwnerId === opponent.id,
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
      if (refs.match?.matchId !== data.matchId) return;
      renderState(data.state);
      if (data.turn < 0) {
        stopTimer();
        set({ myTurn: false, movePending: false, showTimer: false, timerUrgent: false, turnAnnounce: null });
        return;
      }
      applyTurn(data.turn, data.deadline);
    });

    target.onChat((data) => {
      if (refs.session !== target) return;
      if (data.matchId && data.matchId !== refs.match?.matchId) return;
      if (data.roomId && data.roomId !== get().roomWaiting?.roomId) return;
      const match = refs.match;
      const room = get().roomWaiting;
      const isMatchChat = data.matchId != null && match?.matchId === data.matchId;
      const isRoomChat = data.roomId != null && room?.roomId === data.roomId;
      if (!isMatchChat && !isRoomChat) return;
      const myID = isMatchChat && match ? match.players[match.you].id : room?.youId;
      const opponentID =
        isMatchChat && match
          ? match.players[1 - match.you].id
          : room?.members.find((member) => member.id !== room?.youId)?.id;
      const who = data.userId === myID ? get().me.name : data.userId === opponentID ? get().op.name : data.name;
      if (!refs.opponentIsBot && data.userId === opponentID) {
        bridge.attention({
          reason: ARCADE_ATTENTION_REASON.NewChat,
          roomId: data.roomId,
          matchId: data.matchId,
        });
      }
      refs.chatSeq += 1;
      set((state) => ({
        messages: [...state.messages, { id: refs.chatSeq, who, text: data.text }].slice(-CHAT_HISTORY_LIMIT),
      }));
    });

    target.onReaction((data) => {
      if (refs.session !== target || refs.match?.matchId !== data.matchId) return;
      const match = refs.match;
      const myID = match.players[match.you]?.id;
      refs.reactionSeq += 1;
      set({
        reactionNotice: {
          id: refs.reactionSeq,
          type: data.type,
          mine: data.userId === myID,
        },
      });
    });

    target.onMatchOver((data) => {
      if (refs.session !== target) return;
      const exiting = refs.exitingMatch?.matchId === data.matchId;
      if (refs.match != null && refs.match.matchId !== data.matchId && !exiting) return;
      if (refs.handledMatchIds.has(data.matchId)) return;
      refs.handledMatchIds.add(data.matchId);
      if (refs.handledMatchIds.size > 64) {
        const oldest = refs.handledMatchIds.values().next().value;
        if (oldest) refs.handledMatchIds.delete(oldest);
      }
      clearMatchUi();
      renderState(data.state);
      const match = refs.match ?? (exiting ? refs.exitingMatch : null);
      const myId = match?.players[match.you]?.id ?? refs.user?.id ?? target.userId;
      const won = data.winnerId != null && data.winnerId !== '' && data.winnerId === myId;
      const draw = data.winnerId == null || data.winnerId === '';
      if (target === refs.bot && match && refs.user) {
        const opponent = match.players[1 - match.you];
        if (opponent) {
          const botHistory = saveBotHistory(refs.user.id, {
            id: data.matchId,
            playedAt: Date.now(),
            opponentId: 'bot',
            opponentName: opponent.name,
            bet: 0,
            outcome: draw ? 'draw' : won ? 'win' : 'lose',
            kenDelta: 0,
          });
          set((state) => ({ history: mergeMatchHistory(state.history, botHistory) }));
        }
      }
      bridge.gameOver({ matchId: data.matchId, winnerId: data.winnerId, reason: data.reason, won });
      refs.match = null;
      if (exiting) {
        refs.exitingMatch = null;
        return;
      }
      const bet = data.bet ?? refs.matchBet;
      const line = !draw && data.reason === 'win' ? findFinalWinLine(data.state) : null;
      const winnerPayout = data.payout ?? bet * 2;
      const winnerNet = data.kenDelta ?? winnerPayout - bet;
      const kenDelta = target === refs.bot ? 0 : draw ? null : bet === 0 ? 0 : won ? winnerNet : -bet;
      const payoutRevealDelay =
        !draw && target !== refs.bot && bet > 0 && winnerPayout > 0 ? WIN_RESULT_REVEAL_MS : 0;
      set({
        overlay: null,
        result: {
          matchId: data.matchId,
          outcome: draw ? 'draw' : won ? 'win' : 'lose',
          kenDelta,
          winnerPayout: draw || target === refs.bot || bet === 0 ? null : winnerPayout,
          revealDelayMs: line ? WIN_RESULT_REVEAL_MS : payoutRevealDelay,
        },
        winLine: line,
        status: draw ? 'Ván đấu hòa!' : won ? 'Bạn thắng!' : 'Bạn thua!',
      });
    });

    target.onError((err) => {
      if (refs.session !== target) return;
      const lostRoom =
        err.code === GAME_ERROR_CODE.NotRoomMember ||
        err.code === GAME_ERROR_CODE.RoomNotFound ||
        err.code === GAME_ERROR_CODE.RoomMismatch;
      if (lostRoom && !refs.match && get().roomWaiting) {
        refs.pendingRoomId = null;
        refs.matchBet = 0;
        refs.chatOpponentId = null;
        refs.chatSeq = 0;
        set({
          boardMode: 'idle',
          roomActionPending: null,
          roomWaiting: null,
          bet: 0,
          board: emptyState().board,
          lastIdx: -1,
          overlay: null,
          result: null,
          winLine: null,
          messages: [],
          lobbyVisible: false,
          leaderboardVisible: false,
          rankedVisible: true,
        });
        refs.online?.listRooms();
        showToast(roomErrorText(err.code) ?? err.message);
        return;
      }
      const roomActionError = get().roomActionPending != null ? roomErrorText(err.code) : null;
      const interactionMessage =
        roomActionError == null ? chatErrorText(err.code) ?? reactionErrorText(err.code) : null;
      if (interactionMessage) {
        showToast(interactionMessage);
        return;
      }
      if (!refs.match) {
        const pending = get().roomActionPending;
        const currentRoom = get().roomWaiting;
        const returnToRooms = (pending === 'creating' || pending === 'joining') && !currentRoom;
        if (currentRoom && !returnToRooms) {
          applyRoomState(currentRoom);
        } else {
          set({
            roomActionPending: null,
            ...(returnToRooms
              ? {
                  boardMode: 'idle' as const,
                  bet: 0,
                  rankedVisible: true,
                  lobbyVisible: false,
                  leaderboardVisible: false,
                }
              : {}),
          });
        }
        if (returnToRooms) refs.pendingRoomId = null;
        if (returnToRooms) refs.matchBet = 0;
        showToast(roomErrorText(err.code) ?? matchErrorText(err.code) ?? err.message);
        return;
      }
      set({ movePending: false, status: matchErrorText(err.code) ?? err.message });
    });
  };

  const connectToServer = (): Promise<void> => {
    if (refs.connectPromise) return refs.connectPromise;
    refs.connectPromise = (async () => {
      refs.connecting = true;
      set({ lobbyPhase: 'connecting', lobbyError: null });
      try {
        if (!refs.online) {
          refs.online = await joinGame<CaroState, CaroMove>('caro');
          wireSession(refs.online);
          if (!refs.session) refs.session = refs.online;
        }
        await new Promise<void>((resolve, reject) => {
          const online = refs.online!;
          let timer: number | undefined;
          let offUserInfo = (): void => {};
          let offConnectionError = (): void => {};
          const cleanup = (): void => {
            offUserInfo();
            offConnectionError();
            if (timer != null) clearTimeout(timer);
          };
          offUserInfo = online.onUserInfo(() => {
            cleanup();
            resolve();
          });
          offConnectionError = online.onConnectionError((error) => {
            if (authenticationErrorText(error) == null) return;
            cleanup();
            reject(error);
          });
          timer = window.setTimeout(() => {
            cleanup();
            reject(new Error('connect timeout'));
          }, 8000);
        });
      } catch (error) {
        const authenticationMessage = authenticationErrorText(error);
        const online = refs.online;
        online?.disconnect();
        if (refs.session === online) refs.session = null;
        refs.online = null;
        refs.user = null;
        set({
          userInfo: null,
          lobbyPhase: 'error',
          lobbyError: authenticationMessage ?? 'Không kết nối được máy chủ',
        });
      } finally {
        refs.connecting = false;
        refs.connectPromise = null;
      }
    })();
    return refs.connectPromise;
  };

  const toLobby = (): void => {
    const waitingRoom = get().roomWaiting;
    if (waitingRoom) {
      if (get().roomActionPending) return;
      set({ roomActionPending: 'leaving' });
      refs.online?.leaveRoom(waitingRoom.roomId);
      return;
    }
    refs.pendingRoomId = null;
    refs.chatOpponentId = null;
    refs.chatSeq = 0;
    refs.matchBet = 0;
    set((s) => ({
      boardMode: 'idle',
      roomActionPending: null,
      overlay: null,
      result: null,
      rankedVisible: false,
      leaderboardVisible: false,
      lobbyVisible: true,
      roomWaiting: null,
      bet: 0,
      board: emptyState().board,
      lastIdx: -1,
      winLine: null,
      messages: [],
      lobbyAnimKey: s.lobbyAnimKey + 1,
    }));
    if (!refs.user && !refs.connecting) void connectToServer();
  };

  return {
    ...createInitialCaroState(),

    init() {
      set((s) => ({ lobbyPhase: s.lobbyPhase === 'loading' ? 'connecting' : s.lobbyPhase }));
      void connectToServer();
    },

    dispose() {
      stopTimer();
      window.clearTimeout(refs.toastTimer);
      if (refs.kenRaf) cancelAnimationFrame(refs.kenRaf);
      refs.bot?.disconnect();
      refs.online?.disconnect();
      window.clearTimeout(refs.leaderboardTimers.day);
      window.clearTimeout(refs.leaderboardTimers.week);
      refs.leaderboardTimers.day = undefined;
      refs.leaderboardTimers.week = undefined;
      window.clearTimeout(refs.historyTimer);
      refs.historyTimer = undefined;
      refs.bot = null;
      refs.online = null;
      refs.session = null;
      refs.connectPromise = null;
      refs.match = null;
    },

    syncKenFromHost(ken) {
      if (!Number.isSafeInteger(ken) || ken < 0) return;
      if (refs.user?.ken === ken && get().userInfo?.ken === ken) return;
      if (refs.user) refs.user = { ...refs.user, ken };
      set((state) => ({
        userInfo: state.userInfo ? { ...state.userInfo, ken } : null,
      }));
      animateKen(ken);
    },

    playBot(level) {
      preloadBoardAssets();
      if (!refs.bot || refs.botLevel !== level) {
        refs.bot?.disconnect();
        refs.bot = createBotSession(level);
        refs.botLevel = level;
        wireSession(refs.bot);
      }
      refs.matchBet = 0;
      set({ bet: 0 });
      refs.session = refs.bot;
      refs.session.joinQueue();
    },

    playRanked() {
      preloadRankedAssets();
      const activeRoom = get().roomWaiting;
      if (activeRoom) {
        applyRoomState(activeRoom);
        return;
      }
      refs.matchBet = 0;
      set({
        boardMode: 'idle',
        roomActionPending: null,
        bet: 0,
        lobbyVisible: false,
        leaderboardVisible: false,
        rankedVisible: true,
        rooms: [],
      });
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
      preloadBoardAssets();
      const normalizedPassword = password?.trim() ?? '';
      const validationError = roomCreationError(
        bet,
        normalizedPassword,
        refs.user?.ken ?? null,
        refs.user?.maxBet ?? null,
      );
      if (validationError) {
        showToast(validationError);
        return;
      }
      refs.session = refs.online;
      refs.matchBet = bet;
      enterPendingRoom('creating', 'Đang tạo bàn...');
      refs.online.createRoom(bet, normalizedPassword || undefined);
    },

    joinRoom(roomId, password) {
      if (!refs.online) return;
      preloadBoardAssets();
      refs.session = refs.online;
      refs.matchBet = get().rooms.find((room) => room.id === roomId)?.bet ?? 0;
      enterPendingRoom('joining', 'Đang vào bàn...');
      refs.pendingRoomId = roomId;
      refs.online.joinRoom(roomId, password || undefined);
    },

    cancelRoom() {
      const room = get().roomWaiting;
      if (!room || get().roomActionPending) return;
      set({ roomActionPending: 'leaving', status: 'Đang hủy bàn...' });
      refs.online?.leaveRoom(room.roomId);
    },

    toggleRoomReady() {
      const room = get().roomWaiting;
      if (!room || room.members.length < 2 || get().roomActionPending) return;
      if (room.ownerId === room.youId) return;
      const me = room.members.find((member) => member.id === room.youId);
      set({ roomActionPending: 'ready' });
      refs.online?.setRoomReady(room.roomId, !(me?.ready ?? false));
    },

    startRoom() {
      const room = get().roomWaiting;
      if (!room || get().roomActionPending) return;
      const guest = room.members.find((member) => !member.owner);
      const canStart = room.ownerId === room.youId && room.members.length === 2 && guest?.ready === true;
      if (!canStart) return;
      set({ roomActionPending: 'starting', status: 'Đang bắt đầu trận...' });
      refs.online?.startRoom(room.roomId);
    },

    kickRoomGuest() {
      const room = get().roomWaiting;
      if (!room || room.ownerId !== room.youId || get().roomActionPending) return;
      const guest = room.members.find((member) => !member.owner);
      if (guest) {
        set({ roomActionPending: 'kicking' });
        refs.online?.kickRoomMember(room.roomId, guest.id);
      }
    },

    showLeaderboard() {
      preloadLeaderboardAssets();
      set({ lobbyVisible: true, rankedVisible: false, historyVisible: false, leaderboardVisible: true });
    },

    hideLeaderboard() {
      set({ leaderboardVisible: false });
    },

    showHistory() {
      preloadHistoryAssets();
      set({ lobbyVisible: true, rankedVisible: false, leaderboardVisible: false, historyVisible: true });
      get().loadHistory();
    },

    hideHistory() {
      set({ historyVisible: false });
    },

    loadHistory() {
      const request = (): void => {
        if (!refs.online) {
          set({ historyLoading: false, historyError: 'Không kết nối được máy chủ' });
          return;
        }
        set({ historyLoading: true, historyError: null });
        window.clearTimeout(refs.historyTimer);
        refs.historyTimer = window.setTimeout(() => {
          refs.historyTimer = undefined;
          set({ historyLoading: false, historyError: 'Máy chủ phản hồi quá lâu' });
        }, HISTORY_REQUEST_TIMEOUT_MS);
        refs.online.getHistory();
      };
      if (refs.online) request();
      else void connectToServer().then(request);
    },

    loadLeaderboard(period) {
      const request = (): void => {
        if (!refs.online) {
          set((state) => ({
            leaderboardLoading: { ...state.leaderboardLoading, [period]: false },
            leaderboardErrors: { ...state.leaderboardErrors, [period]: 'Không kết nối được máy chủ' },
          }));
          return;
        }
        set((state) => ({
          leaderboardLoading: { ...state.leaderboardLoading, [period]: true },
          leaderboardErrors: { ...state.leaderboardErrors, [period]: null },
        }));
        window.clearTimeout(refs.leaderboardTimers[period]);
        refs.leaderboardTimers[period] = window.setTimeout(() => {
          refs.leaderboardTimers[period] = undefined;
          set((state) => ({
            leaderboardLoading: { ...state.leaderboardLoading, [period]: false },
            leaderboardErrors: { ...state.leaderboardErrors, [period]: 'Máy chủ phản hồi quá lâu' },
          }));
        }, LEADERBOARD_REQUEST_TIMEOUT_MS);
        refs.online?.getLeaderboard(period);
      };
      if (refs.online) request();
      else void connectToServer().then(request);
    },

    placeMove(x, y) {
      const state = get();
      if (
        !refs.match ||
        !state.myTurn ||
        state.movePending ||
        !Number.isInteger(x) ||
        !Number.isInteger(y) ||
        x < 0 ||
        x >= SIZE ||
        y < 0 ||
        y >= SIZE ||
        state.board[y * SIZE + x] !== 0
      ) {
        return;
      }
      set({ movePending: true });
      refs.session?.sendMove(refs.match.matchId, { x, y });
    },

    again() {
      if (showWaitingRoom()) return;
      if (refs.session === refs.bot) {
        set({ overlay: null, result: null, winLine: null });
        refs.session?.joinQueue();
        return;
      }
      set({ overlay: null, result: null, winLine: null });
      get().playRanked();
    },

    replay() {
      if (refs.match && !window.confirm('Chơi lại ván mới?')) return;
      if (refs.match) refs.session?.forfeit(refs.match.matchId);
      refs.session?.joinQueue();
    },

    cancelSearch() {
      refs.session?.leaveQueue();
      toLobby();
    },

    forfeit() {
      if (!refs.match) return;
      set({ forfeitDisabled: true });
      refs.session?.forfeit(refs.match.matchId);
    },

    exitMatch() {
      if (refs.match) {
        refs.exitingMatch = refs.match;
        refs.session?.forfeit(refs.match.matchId, true);
      }
      refs.match = null;
      clearMatchUi();
      toLobby();
    },

    closeResult() {
      if (showWaitingRoom()) return;
      set({ result: null, winLine: null });
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
    dismissNotice() {
      set({ notice: null });
    },

    sendChat(text) {
      const trimmed = text.trim();
      if (!trimmed) return;
      if (refs.match) {
        refs.session?.sendChat(refs.match.matchId, trimmed);
        return;
      }
      const room = get().roomWaiting;
      if (room?.members.length === 2) {
        refs.online?.sendRoomChat(room.roomId, trimmed);
      }
    },

    sendReaction(type) {
      if (!refs.match || get().boardMode !== 'playing' || get().result != null) return;
      refs.session?.sendReaction(refs.match.matchId, type);
    },
  };
});

if (import.meta.env.DEV) {
  (window as unknown as { caroStore?: typeof useCaro }).caroStore = useCaro;
}
