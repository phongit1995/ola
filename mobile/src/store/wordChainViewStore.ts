import { create } from 'zustand';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';

export interface WordChainScrollAnchor {
  key: string;
  offset: number;
}

interface WordChainViewState {
  draft: string;
  sending: boolean;
  anchor: WordChainScrollAnchor | null;
  setDraft: (draft: string) => void;
  sendDraft: (send: (content: string) => Promise<unknown>) => Promise<void>;
  reset: () => void;
}

const initialWordChainView = { draft: '', sending: false, anchor: null };

let viewGeneration = 0;

export const useWordChainViewStore = create<WordChainViewState>((set, get) => ({
  ...initialWordChainView,
  setDraft: (draft) => set({ draft }),
  sendDraft: async (send) => {
    const { draft, sending } = get();
    const content = draft.trim();
    if (content === '' || sending) return;
    const generation = viewGeneration;
    set({ sending: true });
    try {
      await send(content);
      if (generation === viewGeneration && get().draft.trim() === content) set({ draft: '' });
    } finally {
      if (generation === viewGeneration) set({ sending: false });
    }
  },
  reset: () => {
    viewGeneration += 1;
    set(initialWordChainView);
  },
}));

useWordChainStore.subscribe((state, previous) => {
  if (previous.opened && !state.opened) useWordChainViewStore.getState().reset();
});
