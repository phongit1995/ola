import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { sharedPersistStorage } from '@ola/shared/platform';

interface ChatLocalState {
  hiddenPeerCardIds: string[];
  hidePeerCard: (peerId: string) => void;
}

export const useChatLocalStore = create<ChatLocalState>()(
  persist(
    (set) => ({
      hiddenPeerCardIds: [],
      hidePeerCard: (peerId) =>
        set((state) =>
          peerId === '' || state.hiddenPeerCardIds.includes(peerId)
            ? state
            : { hiddenPeerCardIds: [...state.hiddenPeerCardIds, peerId] }
        ),
    }),
    { name: 'ola.chat.local', storage: sharedPersistStorage<ChatLocalState>() }
  )
);

export function isPeerCardHidden(peerId: string): boolean {
  if (peerId === '') return false;
  return useChatLocalStore.getState().hiddenPeerCardIds.includes(peerId);
}

export function hidePeerCard(peerId: string): void {
  useChatLocalStore.getState().hidePeerCard(peerId);
}
