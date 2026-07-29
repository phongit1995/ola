import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import {
  MAX_BLOCKED_AUTHORS,
  MAX_HIDDEN_POSTS,
  MAX_VIEWED_PROFILES,
} from '../constants/me';
import { sharedPersistStorage } from '../platform/persistStorage';
import type { MeLocalState } from '../types/client/meLocal.type';

export type { ViewedProfile } from '../types/client/meLocal.type';

export const useMeLocalStore = create<MeLocalState>()(
  persist(
    (set) => ({
      hiddenPostIds: [],
      blockedAuthorIds: [],
      viewedProfiles: [],
      hidePost: (id) =>
        set((state) =>
          state.hiddenPostIds.includes(id)
            ? state
            : { hiddenPostIds: [...state.hiddenPostIds, id].slice(-MAX_HIDDEN_POSTS) }
        ),
      blockAuthor: (authorId) =>
        set((state) =>
          state.blockedAuthorIds.includes(authorId)
            ? state
            : { blockedAuthorIds: [...state.blockedAuthorIds, authorId].slice(-MAX_BLOCKED_AUTHORS) }
        ),
      recordViewedProfile: (profile) =>
        set((state) => ({
          viewedProfiles: [
            profile,
            ...state.viewedProfiles.filter((item) => item.id !== profile.id),
          ].slice(0, MAX_VIEWED_PROFILES),
        })),
      clearViewedProfiles: () => set({ viewedProfiles: [] }),
    }),
    { name: 'ola.me.local', storage: sharedPersistStorage<MeLocalState>() }
  )
);
