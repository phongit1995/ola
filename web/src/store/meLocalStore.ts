import { create } from 'zustand';
import { persist } from 'zustand/middleware';

export interface ViewedProfile {
  id: string;
  username: string;
  fullName?: string;
  avatar?: string;
  vipTypeId?: number | null;
}

const MAX_VIEWED_PROFILES = 30;
const MAX_HIDDEN_POSTS = 500;
const MAX_BLOCKED_AUTHORS = 500;

interface MeLocalState {
  hiddenPostIds: string[];
  blockedAuthorIds: string[];
  viewedProfiles: ViewedProfile[];
  hidePost: (id: string) => void;
  blockAuthor: (authorId: string) => void;
  recordViewedProfile: (profile: ViewedProfile) => void;
  clearViewedProfiles: () => void;
}

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
    {
      name: 'ola.me.local',
      partialize: (state) => ({
        hiddenPostIds: state.hiddenPostIds,
        blockedAuthorIds: state.blockedAuthorIds,
        viewedProfiles: state.viewedProfiles,
      }),
    }
  )
);
