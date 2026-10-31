import { create } from 'zustand';
import { RelationshipService } from '../../services/relationship.service';
import type { FriendsState } from '../../types/client/friends.type';
import { registerOnLogout } from '../auth/authStore';
import { initialFriendsState } from './friends.state';

let requestsInFlight: Promise<void> | null = null;

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
  loadRequests: (force = false) => {
    if (requestsInFlight) return requestsInFlight;
    if (get().requestsLoaded && !force) return Promise.resolve();
    set({ requestsLoading: true });
    const request: Promise<void> = RelationshipService.pending()
      .then((res) => {
        if (requestsInFlight === request) set({ requests: res.relationships, requestsLoaded: true });
      })
      .catch(() => undefined)
      .finally(() => {
        if (requestsInFlight !== request) return;
        requestsInFlight = null;
        set({ requestsLoading: false });
      });
    requestsInFlight = request;
    return request;
  },
  removeRequest: (id) => set((state) => ({ requests: state.requests.filter((item) => item.id !== id) })),
  reset: () => {
    requestsInFlight = null;
    set({ ...initialFriendsState });
  },
}));

registerOnLogout(() => useFriendsStore.getState().reset());
