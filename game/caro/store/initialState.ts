import { VIP_DEFAULT_ICON } from '../assets';
import { emptyState } from '../types';
import type { CaroState, PlayerDisplay } from './types';

export const EMPTY_PLAYER: PlayerDisplay = {
  name: '---',
  vip: VIP_DEFAULT_ICON,
  mark: 'x',
  active: false,
  owner: false,
};

export function createInitialCaroState(): CaroState {
  return {
    lobbyVisible: true,
    lobbyPhase: 'loading',
    lobbyError: null,
    lobbyAnimKey: 0,
    userInfo: null,
    ken: 0,
    bet: 0,
    rankedVisible: false,
    leaderboardVisible: false,
    leaderboards: { day: null, week: null },
    leaderboardLoading: { day: false, week: false },
    leaderboardErrors: { day: null, week: null },
    rooms: [],
    roomWaiting: null,
    boardMode: 'idle',
    roomActionPending: null,
    oppAway: null,
    board: emptyState().board,
    lastIdx: -1,
    status: 'Sẵn sàng',
    myTurn: false,
    movePending: false,
    showTimer: false,
    timerText: '00:45',
    timerUrgent: false,
    turnArrowSrc: null,
    me: { ...EMPTY_PLAYER },
    op: { ...EMPTY_PLAYER, mark: 'o' },
    overlay: null,
    replayVisible: false,
    forfeitDisabled: true,
    result: null,
    toast: null,
    notice: null,
    matchSeq: 0,
    betDeductionVisible: false,
    turnAnnounce: null,
    winLine: null,
    messages: [],
  };
}
