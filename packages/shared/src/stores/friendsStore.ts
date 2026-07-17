import { create } from 'zustand';
import { RelationshipService } from '../services';
import type { Friend, Relationship } from '../types';
import { registerOnLogout } from './authStore';

interface FriendsState {
  friends: Friend[];
  requests: Relationship[];
  loaded: boolean;
  loading: boolean;
  requestsLoaded: boolean;
  requestsLoading: boolean;
  loadFriends: () => Promise<boolean>;
  ensureFriends: () => void;
  loadRequests: () => void;
  removeRequest: (id: string) => void;
  reset: () => void;
}

const initialState = {
  friends: [] as Friend[],
  requests: [] as Relationship[],
  loaded: false,
  loading: false,
  requestsLoaded: false,
  requestsLoading: false,
};

export const useFriendsStore = create<FriendsState>((set, get) => ({
  ...initialState,
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
  loadRequests: () => {
    if (get().requestsLoaded || get().requestsLoading) return;
    set({ requestsLoading: true });
    RelationshipService.pending()
      .then((res) => set({ requests: res.relationships, requestsLoaded: true }))
      .catch(() => undefined)
      .finally(() => set({ requestsLoading: false }));
  },
  removeRequest: (id) => set((state) => ({ requests: state.requests.filter((item) => item.id !== id) })),
  reset: () => set({ ...initialState }),
}));

registerOnLogout(() => useFriendsStore.getState().reset());
