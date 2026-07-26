import { create } from 'zustand';

type PageUpdate = number | ((current: number) => number);

interface HistoryUiState {
  page: number;
  setPage: (update: PageUpdate) => void;
  resetPage: () => void;
}

export const useHistory = create<HistoryUiState>()((set) => ({
  page: 0,
  setPage: (update) =>
    set((state) => ({
      page: typeof update === 'function' ? update(state.page) : update,
    })),
  resetPage: () => set({ page: 0 }),
}));
