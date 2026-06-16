import { create } from 'zustand';
import { persist } from 'zustand/middleware';

interface MeLocalState {
  hiddenPostIds: string[];
  blockedAuthorIds: string[];
  hidePost: (id: string) => void;
  blockAuthor: (authorId: string) => void;
}

export const useMeLocalStore = create<MeLocalState>()(
  persist(
    (set) => ({
      hiddenPostIds: [],
      blockedAuthorIds: [],
      hidePost: (id) =>
        set((state) =>
          state.hiddenPostIds.includes(id)
            ? state
            : { hiddenPostIds: [...state.hiddenPostIds, id] }
        ),
      blockAuthor: (authorId) =>
        set((state) =>
          state.blockedAuthorIds.includes(authorId)
            ? state
            : { blockedAuthorIds: [...state.blockedAuthorIds, authorId] }
        ),
    }),
    {
      name: 'ola.me.local',
      partialize: (state) => ({
        hiddenPostIds: state.hiddenPostIds,
        blockedAuthorIds: state.blockedAuthorIds,
      }),
    }
  )
);
