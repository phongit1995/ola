import { create } from 'zustand';
import { EGG_TOPUP } from '@/pages/games/egg/eggGame.constants';

interface EggGameState {
  ken: number;
  totalWin: number;
  muted: boolean;
  initialized: boolean;
  init: (ken: number) => void;
  spend: (cost: number) => boolean;
  addWin: (amount: number) => void;
  topup: () => void;
  toggleMute: () => void;
}

export const useEggGameStore = create<EggGameState>((set, get) => ({
  ken: 0,
  totalWin: 0,
  muted: false,
  initialized: false,
  init: (ken) => {
    if (get().initialized) return;
    set({ ken, initialized: true });
  },
  spend: (cost) => {
    let ok = false;
    set((state) => {
      if (state.ken < cost) return state;
      ok = true;
      return { ken: state.ken - cost };
    });
    return ok;
  },
  addWin: (amount) =>
    set((state) => ({ ken: state.ken + amount, totalWin: state.totalWin + amount })),
  topup: () => set((state) => ({ ken: state.ken + EGG_TOPUP })),
  toggleMute: () => set((state) => ({ muted: !state.muted })),
}));
