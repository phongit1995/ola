import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { sharedPersistStorage } from '../../platform/persistStorage';
import type {
  PersistedWordChainPrefs,
  WordChainPrefsState,
} from '../../types/client/wordChain.type';

export const useWordChainPrefsStore = create<WordChainPrefsState>()(
  persist(
    (set) => ({
      hintAutoSend: false,
      setHintAutoSend: (hintAutoSend) => set({ hintAutoSend }),
    }),
    {
      name: 'ola.word-chain.prefs',
      storage: sharedPersistStorage<PersistedWordChainPrefs>(),
      partialize: (state) => ({ hintAutoSend: state.hintAutoSend }),
    }
  )
);
