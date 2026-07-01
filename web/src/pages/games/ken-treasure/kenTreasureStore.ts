import { create } from 'zustand';
import { KenTreasureService } from '@services';
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
  syncFromActive: () => Promise<void>;
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
  syncFromActive: async () => {
    if (get().phase !== 'idle') return;
    const res = await KenTreasureService.listActive().catch(() => null);
    if (!res || get().phase !== 'idle') return;
    const chest = res.items.find((item) => !item.opened);
    if (chest) {
      set({ chestId: chest.id, expiresAt: chest.expiresAt, phase: 'closed', result: null });
    }
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
      set({ phase: 'closed' });
      return;
    }
    syncAuthKen(result.kenBalance);
    set({ result: { isEmpty: result.isEmpty, kenAmount: result.kenAmount }, phase: 'result' });
  },
  dismiss: () => set({ chestId: null, expiresAt: null, phase: 'idle', result: null }),
}));
