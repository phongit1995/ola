import { create } from 'zustand';
import { EggService } from '@services';
import type { EggDrawResult, EggPack } from '@app-types';
import { useAuthStore } from '@/store/authStore';

export type EggPacksStatus = 'idle' | 'loading' | 'ready' | 'error';

interface EggGameState {
  ken: number;
  totalWin: number;
  muted: boolean;
  initialized: boolean;
  packs: EggPack[];
  packsStatus: EggPacksStatus;
  drawing: boolean;
  suppressKenSync: boolean;
  winReward: EggDrawResult | null;
  init: (ken: number) => void;
  loadPacks: () => Promise<void>;
  draw: (packId: string, idempotencyKey: string) => Promise<EggDrawResult | null>;
  applyResult: (result: EggDrawResult) => void;
  syncKen: (ken: number) => void;
  showWin: (result: EggDrawResult) => void;
  closeWin: () => void;
  toggleMute: () => void;
}

function syncAuthKen(ken: number) {
  useAuthStore.setState((state) =>
    state.user ? { user: { ...state.user, ken } } : state
  );
}

export const useEggGameStore = create<EggGameState>((set, get) => ({
  ken: 0,
  totalWin: 0,
  muted: false,
  initialized: false,
  packs: [],
  packsStatus: 'idle',
  drawing: false,
  suppressKenSync: false,
  winReward: null,
  init: (ken) => {
    if (get().initialized) return;
    set({ ken, initialized: true });
  },
  loadPacks: async () => {
    if (get().packsStatus === 'loading') return;
    set({ packsStatus: 'loading' });
    try {
      const result = await EggService.listPacks();
      const items = result?.items ?? [];
      if (items.length === 0) {
        set({ packs: [], packsStatus: 'error' });
        return;
      }
      set({ packs: items, packsStatus: 'ready' });
    } catch {
      set({ packs: [], packsStatus: 'error' });
    }
  },
  draw: async (packId, idempotencyKey) => {
    if (get().drawing) return null;
    set({ drawing: true, suppressKenSync: true });
    try {
      return await EggService.draw(packId, idempotencyKey);
    } catch {
      set({ suppressKenSync: false });
      return null;
    } finally {
      set({ drawing: false });
    }
  },
  applyResult: (result) => {
    set((state) => ({
      ken: result.kenBalance,
      totalWin: result.kenAmount ? state.totalWin + result.kenAmount : state.totalWin,
      suppressKenSync: false,
    }));
    syncAuthKen(result.kenBalance);
  },
  syncKen: (ken) =>
    set((state) => (state.suppressKenSync || ken === state.ken ? state : { ken })),
  showWin: (result) => set({ winReward: result }),
  closeWin: () => set({ winReward: null }),
  toggleMute: () => set((state) => ({ muted: !state.muted })),
}));
