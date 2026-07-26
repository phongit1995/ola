import { create } from 'zustand';

interface LobbyState {
  pickOpen: boolean;
  exitOpen: boolean;
  setPickOpen: (open: boolean) => void;
  setExitOpen: (open: boolean) => void;
  reset: () => void;
}

export const useLobby = create<LobbyState>()((set) => ({
  pickOpen: false,
  exitOpen: false,
  setPickOpen: (pickOpen) => set({ pickOpen }),
  setExitOpen: (exitOpen) => set({ exitOpen }),
  reset: () => set({ pickOpen: false, exitOpen: false }),
}));
