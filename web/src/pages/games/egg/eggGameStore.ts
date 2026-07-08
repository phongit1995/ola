import { create } from 'zustand';
import { EggService } from '@services';
import type { EggDrawResult, EggPack } from '@app-types';
import { syncAuthKen } from '@/store/authKen';

export type EggPacksStatus = 'idle' | 'loading' | 'ready' | 'error';

interface EggGameState {
  ken: number;
  totalWin: number;
  muted: boolean;
  packs: EggPack[];
  packsStatus: EggPacksStatus;
  drawing: boolean;
  smashing: boolean;
  suppressKenSync: boolean;
  winReward: EggDrawResult | null;
  loadPacks: () => Promise<void>;
  draw: (packId: string, idempotencyKey: string) => Promise<EggDrawResult | null>;
  applyResult: (result: EggDrawResult) => void;
  syncKen: (ken: number) => void;
  beginSmash: () => void;
  endSmash: () => void;
  showWin: (result: EggDrawResult) => void;
  closeWin: () => void;
  toggleMute: () => void;
}

export const useEggGameStore = create<EggGameState>((set, get) => ({
  ken: 0,
  totalWin: 0,
  muted: false,
  packs: [],
  packsStatus: 'idle',
  drawing: false,
  smashing: false,
  suppressKenSync: false,
  winReward: null,
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
  beginSmash: () => set({ smashing: true }),
  endSmash: () => set({ smashing: false }),
  showWin: (result) => set({ winReward: result }),
  closeWin: () => set({ winReward: null }),
  toggleMute: () => set((state) => ({ muted: !state.muted })),
}));
