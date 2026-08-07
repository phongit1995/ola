import { create } from 'zustand';
import { randomUuid } from '../lib/randomUuid';
import { rotationForIndex } from '../lib/spinWheel';
import { WheelService } from '../services/wheel.service';
import type { WheelPlayerSegment } from '../types/api/wheel.type';
import type { SpinWheelState } from '../types/client/spinWheel.type';
import { useAuthStore } from './auth/authStore';

export type { WheelConfigStatus } from '../types/client/spinWheel.type';

function sortedSegments(segments: WheelPlayerSegment[]): WheelPlayerSegment[] {
  return [...segments].sort((a, b) => a.sortOrder - b.sortOrder);
}

function syncAuthKen(ken: number) {
  useAuthStore.setState((state) => (state.user ? { user: { ...state.user, ken } } : state));
}

export const useSpinWheelStore = create<SpinWheelState>((set, get) => ({
  ken: 0,
  muted: false,
  config: null,
  configStatus: 'idle',
  rotation: 0,
  spinning: false,
  suppressKenSync: false,
  result: null,
  pendingResult: null,
  loadConfig: async () => {
    if (get().configStatus === 'loading') return;
    set({ configStatus: 'loading' });
    try {
      const config = await WheelService.getConfig();
      if (!config || config.segments.length === 0) {
        set({ config: null, configStatus: 'error' });
        return;
      }
      set({
        config: { ...config, segments: sortedSegments(config.segments) },
        configStatus: 'ready',
      });
    } catch {
      set({ config: null, configStatus: 'error' });
    }
  },
  spin: async () => {
    const state = get();
    if (state.spinning || !state.config) return false;
    const count = state.config.segments.length;
    set({ spinning: true, suppressKenSync: true });
    try {
      const result = await WheelService.spin(randomUuid());
      set((current) => ({
        pendingResult: result,
        rotation: rotationForIndex(current.rotation, result.segmentIndex, count),
        ken: result.kenBalanceAfterCost,
      }));
      return true;
    } catch {
      set({ spinning: false, suppressKenSync: false });
      return false;
    }
  },
  settle: () => {
    const state = get();
    const result = state.pendingResult;
    if (!result) return;
    set((current) => ({
      spinning: false,
      suppressKenSync: false,
      pendingResult: null,
      result,
      ken: result.kenBalance,
      config: current.config
        ? { ...current.config, freeAvailable: result.freeAvailable }
        : current.config,
    }));
    syncAuthKen(result.kenBalance);
  },
  syncKen: (ken) =>
    set((state) => (state.suppressKenSync || ken === state.ken ? state : { ken })),
  closeResult: () => set({ result: null }),
  toggleMute: () => set((state) => ({ muted: !state.muted })),
}));
