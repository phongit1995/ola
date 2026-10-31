import { RelationshipService } from '@ola/shared/services/relationship.service';
import { useFriendsStore } from '@ola/shared/stores/friends/friendsStore';

jest.mock('@ola/shared/services/relationship.service', () => ({
  RelationshipService: { pending: jest.fn(), friends: jest.fn() },
}));

jest.mock('@ola/shared/stores/auth/authStore', () => ({
  registerOnLogout: jest.fn(),
}));

const pending = RelationshipService.pending as jest.Mock;

function deferred<T>() {
  let resolve!: (value: T) => void;
  const promise = new Promise<T>((done) => {
    resolve = done;
  });
  return { promise, resolve };
}

const request = (id: string) => ({ id }) as never;

describe('friendsStore.loadRequests', () => {
  beforeEach(() => {
    pending.mockReset();
    useFriendsStore.getState().reset();
  });

  it('resolves only after a slow response has been stored', async () => {
    const slow = deferred<{ relationships: unknown[] }>();
    pending.mockReturnValue(slow.promise);
    let settled = false;
    const load = useFriendsStore
      .getState()
      .loadRequests(true)
      .then(() => {
        settled = true;
      });
    await Promise.resolve();
    expect(settled).toBe(false);
    expect(useFriendsStore.getState().requestsLoading).toBe(true);
    slow.resolve({ relationships: [request('r1')] });
    await load;
    expect(useFriendsStore.getState().requests).toEqual([request('r1')]);
    expect(useFriendsStore.getState().requestsLoading).toBe(false);
  });

  it('lets a refresh wait for the load already in flight instead of returning early', async () => {
    const slow = deferred<{ relationships: unknown[] }>();
    pending.mockReturnValue(slow.promise);
    const first = useFriendsStore.getState().loadRequests();
    const refresh = useFriendsStore.getState().loadRequests(true);
    expect(refresh).toBe(first);
    expect(pending).toHaveBeenCalledTimes(1);
    slow.resolve({ relationships: [request('r2')] });
    await refresh;
    expect(useFriendsStore.getState().requests).toEqual([request('r2')]);
  });

  it('drops a response that arrives after logout reset the store', async () => {
    const slow = deferred<{ relationships: unknown[] }>();
    pending.mockReturnValue(slow.promise);
    const load = useFriendsStore.getState().loadRequests(true);
    useFriendsStore.getState().reset();
    slow.resolve({ relationships: [request('old')] });
    await load;
    expect(useFriendsStore.getState().requests).toEqual([]);
    expect(useFriendsStore.getState().requestsLoaded).toBe(false);
  });
});
