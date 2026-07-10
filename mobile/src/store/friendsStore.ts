import { create } from 'zustand';
import { RelationshipService } from '@ola/shared/services';
import type { Friend } from '@ola/shared/types';

interface FriendsState {
  friends: Friend[];
  loaded: boolean;
  loading: boolean;
  loadFriends: () => Promise<boolean>;
  ensureFriends: () => void;
}

export const useFriendsStore = create<FriendsState>((set, get) => ({
  friends: [],
  loaded: false,
  loading: false,
  loadFriends: async () => {
    set({ loading: true });
    try {
      const res = await RelationshipService.friends({ limit: 200 });
      set({ friends: res.friends, loaded: true, loading: false });
      return true;
    } catch {
      set({ loading: false });
      return false;
    }
  },
  ensureFriends: () => {
    if (get().loaded || get().loading) return;
    void get().loadFriends();
  },
}));
