import { create } from 'zustand';

export interface BoardPan {
  x: number;
  y: number;
}

type BoardPanUpdate = BoardPan | ((current: BoardPan) => BoardPan);

interface BoardState {
  chatInput: string;
  exitOpen: boolean;
  forfeitOpen: boolean;
  pan: BoardPan;
  setChatInput: (value: string) => void;
  setExitOpen: (open: boolean) => void;
  setForfeitOpen: (open: boolean) => void;
  setPan: (update: BoardPanUpdate) => void;
  resetChat: () => void;
  closeDialogs: () => void;
}

export const useBoard = create<BoardState>()((set) => ({
  chatInput: '',
  exitOpen: false,
  forfeitOpen: false,
  pan: { x: 0, y: 0 },
  setChatInput: (chatInput) => set({ chatInput }),
  setExitOpen: (exitOpen) => set({ exitOpen }),
  setForfeitOpen: (forfeitOpen) => set({ forfeitOpen }),
  setPan: (update) =>
    set((state) => ({
      pan: typeof update === 'function' ? update(state.pan) : update,
    })),
  resetChat: () => set({ chatInput: '' }),
  closeDialogs: () => set({ exitOpen: false, forfeitOpen: false }),
}));
