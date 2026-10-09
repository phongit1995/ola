import { create } from 'zustand';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';

export interface WordChainScrollAnchor {
  key: string;
  offset: number;
}

interface WordChainViewState {
  draft: string;
  anchor: WordChainScrollAnchor | null;
  reset: () => void;
}

const initialWordChainView = { draft: '', anchor: null };

export const useWordChainViewStore = create<WordChainViewState>((set) => ({
  ...initialWordChainView,
  reset: () => set(initialWordChainView),
}));

useWordChainStore.subscribe((state, previous) => {
  if (previous.opened && !state.opened) useWordChainViewStore.getState().reset();
});
