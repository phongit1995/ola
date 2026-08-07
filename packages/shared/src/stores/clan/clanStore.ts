import { create } from 'zustand';
import { ClanService } from '../../services/clan.service';
import { registerOnLogout } from '../authStore';
import type { ClanState } from '../../types/client/clan.type';

function errorMessage(error: unknown): string {
  if (error != null && typeof error === 'object' && 'message' in error) {
    return String((error as { message: unknown }).message);
  }
  return 'unknown error';
}

export const useClanStore = create<ClanState>((set, get) => ({
  myClans: [],
  mineLoading: false,
  mineLoaded: false,
  current: null,
  currentLoading: false,
  currentError: null,
  ensureMine: async () => {
    const { mineLoading, mineLoaded } = get();
    if (mineLoading || mineLoaded) return;
    await get().refreshMine();
  },
  refreshMine: async () => {
    set({ mineLoading: true });
    try {
      const clans = await ClanService.mine();
      set({ myClans: clans, mineLoading: false, mineLoaded: true });
    } catch (error) {
      console.error('load my clans failed', error);
      set({ mineLoading: false });
    }
  },
  loadByHandle: async (handle) => {
    set({ currentLoading: true, currentError: null });
    try {
      const clan = await ClanService.byHandle(handle);
      set({ current: clan, currentLoading: false });
      return clan;
    } catch (error) {
      set({ current: null, currentLoading: false, currentError: errorMessage(error) });
      return null;
    }
  },
  loadById: async (id) => {
    set({ currentLoading: true, currentError: null });
    try {
      const clan = await ClanService.get(id);
      set({ current: clan, currentLoading: false });
      return clan;
    } catch (error) {
      set({ current: null, currentLoading: false, currentError: errorMessage(error) });
      return null;
    }
  },
  join: async (id) => {
    try {
      const clan = await ClanService.join(id);
      set({ current: clan, mineLoaded: false });
      return true;
    } catch (error) {
      set({ currentError: errorMessage(error) });
      return false;
    }
  },
  leave: async (id) => {
    try {
      const clan = await ClanService.leave(id);
      set((state) => ({
        current: clan,
        myClans: state.myClans.filter((item) => item.id !== id),
      }));
      return true;
    } catch (error) {
      set({ currentError: errorMessage(error) });
      return false;
    }
  },
  update: async (id, payload) => {
    try {
      const clan = await ClanService.update(id, payload);
      set({ current: clan });
      return clan;
    } catch (error) {
      set({ currentError: errorMessage(error) });
      return null;
    }
  },
  setCurrent: (clan) => set({ current: clan, currentError: null }),
  reset: () =>
    set({
      myClans: [],
      mineLoading: false,
      mineLoaded: false,
      current: null,
      currentLoading: false,
      currentError: null,
    }),
}));

registerOnLogout(() => useClanStore.getState().reset());
