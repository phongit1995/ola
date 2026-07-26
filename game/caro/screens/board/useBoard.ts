import { create } from 'zustand';

export interface BoardPan {
  x: number;
  y: number;
}

type BoardPanUpdate = BoardPan | ((current: BoardPan) => BoardPan);

interface BoardState {
  chatInput: string;
  reactionOpen: boolean;
  exitOpen: boolean;
  forfeitOpen: boolean;
  pan: BoardPan;
  setChatInput: (value: string) => void;
  setReactionOpen: (open: boolean) => void;
  setExitOpen: (open: boolean) => void;
  setForfeitOpen: (open: boolean) => void;
  setPan: (update: BoardPanUpdate) => void;
  resetChat: () => void;
  closeDialogs: () => void;
}

export const useBoard = create<BoardState>()((set) => ({
  chatInput: '',
  reactionOpen: false,
  exitOpen: false,
  forfeitOpen: false,
  pan: { x: 0, y: 0 },
  setChatInput: (chatInput) => set({ chatInput }),
  setReactionOpen: (reactionOpen) => set({ reactionOpen }),
  setExitOpen: (exitOpen) => set({ exitOpen }),
  setForfeitOpen: (forfeitOpen) => set({ forfeitOpen }),
  setPan: (update) =>
    set((state) => ({
      pan: typeof update === 'function' ? update(state.pan) : update,
    })),
  resetChat: () => set({ chatInput: '', reactionOpen: false }),
  closeDialogs: () => set({ exitOpen: false, forfeitOpen: false }),
}));
