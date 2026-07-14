import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import i18n from 'i18next';
import { KenTreasureService } from '../services';
import { toast } from '../lib';
import { playKenChestSound } from '../platform';
import { sharedPersistStorage } from '../platform/persistStorage';
import { useAuthStore } from './authStore';

export type KenTreasurePhase = 'closed' | 'opening' | 'result';

const OPEN_ANIM_MS = 1000;

interface KenTreasureResult {
  isEmpty: boolean;
  kenAmount: number;
}

export interface KenTreasureChest {
  id: string;
  expiresAt: string;
  phase: KenTreasurePhase;
  result: KenTreasureResult | null;
}

interface KenTreasureState {
  chests: Record<string, KenTreasureChest>;
  show: (payload: { id: string; expiresAt: string }) => void;
  open: (id: string) => Promise<void>;
  dismiss: (id: string) => void;
}

function hasActiveModal(chests: Record<string, KenTreasureChest>): boolean {
  return Object.values(chests).some((c) => c.phase === 'opening' || c.phase === 'result');
}

function patchChests(
  chests: Record<string, KenTreasureChest>,
  id: string,
  patch: Partial<KenTreasureChest>
): Record<string, KenTreasureChest> {
  const current = chests[id];
  if (!current) return chests;
  return { ...chests, [id]: { ...current, ...patch } };
}

function syncAuthKen(ken: number) {
  useAuthStore.setState((state) => (state.user ? { user: { ...state.user, ken } } : state));
}

export const useKenTreasureStore = create<KenTreasureState>((set, get) => ({
  chests: {},
  show: ({ id, expiresAt }) => {
    if (get().chests[id]) return;
    playKenChestSound();
    set((state) => ({
      chests: { ...state.chests, [id]: { id, expiresAt, phase: 'closed', result: null } },
    }));
  },
  open: async (id) => {
    const { chests } = get();
    const chest = chests[id];
    if (!chest || chest.phase !== 'closed' || hasActiveModal(chests)) return;
    set((state) => ({ chests: patchChests(state.chests, id, { phase: 'opening' }) }));
    const [result] = await Promise.all([
      KenTreasureService.open(id).catch(() => null),
      new Promise<void>((resolve) => setTimeout(() => resolve(), OPEN_ANIM_MS)),
    ]);
    if (!result) {
      toast.error(i18n.t('kenTreasure.openError'));
      set((state) => ({ chests: patchChests(state.chests, id, { phase: 'closed' }) }));
      return;
    }
    syncAuthKen(result.kenBalance);
    set((state) => ({
      chests: patchChests(state.chests, id, {
        phase: 'result',
        result: { isEmpty: result.isEmpty, kenAmount: result.kenAmount },
      }),
    }));
  },
  dismiss: (id) =>
    set((state) => {
      if (!state.chests[id]) return state;
      const next = { ...state.chests };
      delete next[id];
      return { chests: next };
    }),
}));

interface KenTreasurePositionState {
  x: number;
  y: number;
  setPosition: (x: number, y: number) => void;
}

export const useKenTreasurePositionStore = create<KenTreasurePositionState>()(
  persist(
    (set) => ({
      x: 0,
      y: 0,
      setPosition: (x, y) => set({ x, y }),
    }),
    {
      name: 'ola.kenTreasure.position',
      storage: sharedPersistStorage<KenTreasurePositionState>(),
    }
  )
);
