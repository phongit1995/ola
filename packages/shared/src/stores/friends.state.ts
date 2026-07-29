import type { FriendsState } from '../types/client/friends.type';

export const initialFriendsState: Pick<
  FriendsState,
  | 'friends'
  | 'requests'
  | 'loaded'
  | 'loading'
  | 'requestsLoaded'
  | 'requestsLoading'
> = {
  friends: [],
  requests: [],
  loaded: false,
  loading: false,
  requestsLoaded: false,
  requestsLoading: false,
};
