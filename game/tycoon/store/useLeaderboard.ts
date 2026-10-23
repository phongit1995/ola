import { create } from 'zustand';
import { LEADERBOARD_CACHE_MS, type LeaderboardResult, type LeaderboardStatus, type LeaderboardTab } from '../helpers/leaderboard';
import { mockFetchLeaderboard } from '../helpers/leaderboardMock';
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

const requestSeq: Record<LeaderboardTab, number> = { day: 0, week: 0, level: 0 };

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
    const seq = ++requestSeq[tab];
    set((state) => ({ boards: { ...state.boards, [tab]: { ...state.boards[tab], status: 'loading' } } }));
    try {
      const data = await mockFetchLeaderboard(tab);
      if (seq !== requestSeq[tab]) return;
      set((state) => ({ boards: { ...state.boards, [tab]: { status: 'ready', data, at: Date.now() } } }));
    } catch {
      if (seq !== requestSeq[tab]) return;
      set((state) => ({ boards: { ...state.boards, [tab]: { ...state.boards[tab], status: 'error' } } }));
    }
  },
}));
