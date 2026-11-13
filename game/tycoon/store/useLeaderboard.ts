import { create } from 'zustand';
import { LEADERBOARD_CACHE_MS, leaderboardFromServer, leaderboardMatchesTab, type LeaderboardResult, type LeaderboardStatus, type LeaderboardTab } from '../helpers/leaderboard';
import { createRequestGuard, requestOnce } from '../helpers/requestOnce';
import { useTycoon } from './useTycoon';
import { playSound } from '../audio';

export interface LeaderboardBoard {
  status: LeaderboardStatus;
  data: LeaderboardResult | null;
  at: number;
}

interface LeaderboardState {
  tab: LeaderboardTab;
  boards: Record<LeaderboardTab, LeaderboardBoard>;

  open(): void;
  select(tab: LeaderboardTab): void;
  load(tab: LeaderboardTab, force?: boolean): Promise<void>;
}

const EMPTY: LeaderboardBoard = { status: 'idle', data: null, at: 0 };

function emptyBoards(): Record<LeaderboardTab, LeaderboardBoard> {
  return { day: EMPTY, week: EMPTY, level: EMPTY };
}

const requestGuards: Record<LeaderboardTab, () => () => boolean> = { day: createRequestGuard(), week: createRequestGuard(), level: createRequestGuard() };

export const useLeaderboard = create<LeaderboardState>((set, get) => ({
  tab: 'day',
  boards: emptyBoards(),

  open() {
    set({ tab: 'day', boards: emptyBoards() });
    void get().load('day');
  },

  select(tab) {
    if (tab === get().tab) return;
    playSound('click');
    set({ tab });
    void get().load(tab);
  },

  async load(tab, force = false) {
    const board = get().boards[tab];
    if (board.status === 'loading') return;
    if (!force && board.status === 'ready' && Date.now() - board.at < LEADERBOARD_CACHE_MS) return;
    const isCurrent = requestGuards[tab]();
    set((state) => ({ boards: { ...state.boards, [tab]: { ...state.boards[tab], status: 'loading' } } }));
    const fail = () => {
      if (isCurrent()) set((state) => ({ boards: { ...state.boards, [tab]: { ...state.boards[tab], status: 'error' } } }));
    };
    const tycoon = useTycoon.getState();
    const session = tycoon.session();
    if (!session || tycoon.online !== 'ready') {
      fail();
      return;
    }
    const reply = await requestOnce({
      subscribe: session.onLeaderboard,
      matches: (data) => leaderboardMatchesTab(tab, data),
      isCurrent,
      send: () => {
        if (tab === 'level') session.getLeaderboard('week', 'level');
        else session.getLeaderboard(tab);
      },
    });
    if (reply.status === 'stale') return;
    if (reply.status === 'timeout' || reply.data.error?.trim()) {
      fail();
      return;
    }
    const result: LeaderboardResult = leaderboardFromServer(tab, reply.data, useTycoon.getState().profile?.id);
    set((state) => ({ boards: { ...state.boards, [tab]: { status: 'ready', data: result, at: Date.now() } } }));
  },
}));
