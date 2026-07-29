import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import i18n from 'i18next';
import { KEN_TREASURE_OPEN_ANIMATION_MS } from '../constants/ken';
import { toast } from '../lib/toast';
import { playKenChestSound } from '../platform/sound';
import { sharedPersistStorage } from '../platform/persistStorage';
import { KenTreasureService } from '../services/kenTreasure.service';
import type {
  KenTreasureChest,
  KenTreasurePositionState,
  KenTreasureState,
} from '../types/client/kenTreasure.type';
import { useAuthStore } from './authStore';

export type {
  KenTreasureChest,
  KenTreasurePhase,
} from '../types/client/kenTreasure.type';

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
      new Promise<void>((resolve) =>
        setTimeout(() => resolve(), KEN_TREASURE_OPEN_ANIMATION_MS)
      ),
    ]);
    const current = get().chests[id];
    if (!current || current.phase !== 'opening') return;
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
  reset: () => set({ chests: {} }),
}));

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
