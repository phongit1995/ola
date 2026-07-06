import { create } from 'zustand';

export type AppOverlayKind =
  | 'notifications'
  | 'profile'
  | 'vip'
  | 'vipBuy'
  | 'ken'
  | 'kenBuy'
  | 'media'
  | 'nearby'
  | 'settings';

export type VipBuyMode = 'give' | 'buy' | 'extend';

export interface AppOverlayEntry {
  kind: AppOverlayKind;
  mode?: VipBuyMode;
}

interface AppOverlayState {
  stack: AppOverlayEntry[];
  push: (kind: AppOverlayKind, mode?: VipBuyMode) => void;
  back: () => void;
  reset: () => void;
}

export const useAppOverlayStore = create<AppOverlayState>((set) => ({
  stack: [],
  push: (kind, mode) => set((state) => ({ stack: [...state.stack, { kind, mode }] })),
  back: () => set((state) => ({ stack: state.stack.slice(0, -1) })),
  reset: () => set({ stack: [] }),
}));
