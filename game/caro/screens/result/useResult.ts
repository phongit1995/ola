import { create } from 'zustand';
import type { MatchResultState } from '../../store/types';

interface ResultState {
  revealedResult: MatchResultState | null;
  setRevealedResult: (result: MatchResultState | null) => void;
}

export const useResult = create<ResultState>()((set) => ({
  revealedResult: null,
  setRevealedResult: (revealedResult) => set({ revealedResult }),
}));
