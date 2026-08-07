import { create } from 'zustand';
import { RelationshipService } from '../../services/relationship.service';
import type { FriendsState } from '../../types/client/friends.type';
import { registerOnLogout } from '../auth/authStore';
import { initialFriendsState } from './friends.state';

export const useFriendsStore = create<FriendsState>((set, get) => ({
  ...initialFriendsState,
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
  reset: () => set({ ...initialFriendsState }),
}));

registerOnLogout(() => useFriendsStore.getState().reset());
