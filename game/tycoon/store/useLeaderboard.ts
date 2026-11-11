import { create } from 'zustand';
import { LEADERBOARD_CACHE_MS, leaderboardFromServer, type LeaderboardResult, type LeaderboardStatus, type LeaderboardTab } from '../helpers/leaderboard';
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

const requestSeq: Record<LeaderboardTab, number> = { day: 0, week: 0, level: 0 };
const REQUEST_TIMEOUT_MS = 10_000;

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
    if (tab === 'level') return;
    const board = get().boards[tab];
    if (board.status === 'loading') return;
    if (!force && board.status === 'ready' && Date.now() - board.at < LEADERBOARD_CACHE_MS) return;
    const seq = ++requestSeq[tab];
    set((state) => ({ boards: { ...state.boards, [tab]: { ...state.boards[tab], status: 'loading' } } }));
    const fail = () => {
      if (seq === requestSeq[tab]) set((state) => ({ boards: { ...state.boards, [tab]: { ...state.boards[tab], status: 'error' } } }));
    };
    const tycoon = useTycoon.getState();
    const session = tycoon.session();
    if (!session || tycoon.online !== 'ready') {
      fail();
      return;
    }
    await new Promise<void>((resolve) => {
      const timer = setTimeout(() => {
        off();
        fail();
        resolve();
      }, REQUEST_TIMEOUT_MS);
      const off = session.onLeaderboard((data) => {
        if (data.period !== tab) return;
        clearTimeout(timer);
        off();
        resolve();
        if (seq !== requestSeq[tab]) return;
        if (data.error?.trim()) {
          fail();
          return;
        }
        const result: LeaderboardResult = leaderboardFromServer(tab, data.items ?? [], useTycoon.getState().profile?.id);
        set((state) => ({ boards: { ...state.boards, [tab]: { status: 'ready', data: result, at: Date.now() } } }));
      });
      session.getLeaderboard(tab);
    });
  },
}));
