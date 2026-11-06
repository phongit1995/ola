import { useEffect } from 'react';
import { create } from 'zustand';

interface OpenModalState {
  count: number;
  register: () => () => void;
}

export const useOpenModalStore = create<OpenModalState>((set) => ({
  count: 0,
  register: () => {
    set((state) => ({ count: state.count + 1 }));
    return () => set((state) => ({ count: state.count - 1 }));
  },
}));

export function useTrackOpenModal(shown: boolean) {
  useEffect(() => {
    if (shown) return useOpenModalStore.getState().register();
  }, [shown]);
}
