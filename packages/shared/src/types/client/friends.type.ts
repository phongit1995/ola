import type { Friend, Relationship } from '../api/relationship.type';

export interface FriendsState {
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
