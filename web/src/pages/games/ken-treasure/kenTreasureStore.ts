import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { KenTreasureService } from '@services';
import { toast } from '@lib';
import i18n from '@/i18n';
import { useAuthStore } from '@/store/authStore';

export type KenTreasurePhase = 'idle' | 'closed' | 'opening' | 'result';

const OPEN_ANIM_MS = 1000;

interface KenTreasureResult {
  isEmpty: boolean;
  kenAmount: number;
}

interface KenTreasureState {
  chestId: string | null;
  expiresAt: string | null;
  phase: KenTreasurePhase;
  result: KenTreasureResult | null;
  show: (payload: { id: string; expiresAt: string }) => void;
  open: () => Promise<void>;
  dismiss: () => void;
}

function syncAuthKen(ken: number) {
  useAuthStore.setState((state) => (state.user ? { user: { ...state.user, ken } } : state));
}

export const useKenTreasureStore = create<KenTreasureState>((set, get) => ({
  chestId: null,
  expiresAt: null,
  phase: 'idle',
  result: null,
  show: ({ id, expiresAt }) => {
    const { phase, chestId } = get();
    if (phase !== 'idle' && chestId === id) return;
    if (phase === 'opening' || phase === 'result') return;
    set({ chestId: id, expiresAt, phase: 'closed', result: null });
  },
  open: async () => {
    const { chestId, phase } = get();
    if (!chestId || phase !== 'closed') return;
    set({ phase: 'opening' });
    const [result] = await Promise.all([
      KenTreasureService.open(chestId).catch(() => null),
      new Promise((resolve) => setTimeout(resolve, OPEN_ANIM_MS)),
    ]);
    if (!result) {
      if (import.meta.env.DEV && chestId === 'debug') {
        set({ result: { isEmpty: false, kenAmount: 8888 }, phase: 'result' });
        return;
      }
      toast.error(i18n.t('kenTreasure.openError'));
      set({ phase: 'closed' });
      return;
    }
    syncAuthKen(result.kenBalance);
    set({ result: { isEmpty: result.isEmpty, kenAmount: result.kenAmount }, phase: 'result' });
  },
  dismiss: () => set({ chestId: null, expiresAt: null, phase: 'idle', result: null }),
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
    { name: 'ola.kenTreasure.position' }
  )
);

if (import.meta.env.DEV) {
  Object.assign(window, { kenTreasureStore: useKenTreasureStore });
}
