import type { useAppUpdateStore as UseAppUpdateStore } from '@store/appUpdateStore';

const mockCheckStore = jest.fn();
const mockFetchRequired = jest.fn();

jest.mock('@lib/appUpdate', () => ({
  STORE_CHECK: { newer: 'newer', latest: 'latest', unknown: 'unknown' },
  checkStoreForUpdate: () => mockCheckStore(),
  fetchUpdateRequired: () => mockFetchRequired(),
}));

function loadStore(): typeof UseAppUpdateStore {
  let store: typeof UseAppUpdateStore | undefined;
  jest.isolateModules(() => {
    store = require('@store/appUpdateStore').useAppUpdateStore;
  });
  return store!;
}

describe('appUpdateStore', () => {
  beforeEach(() => {
    mockCheckStore.mockReset();
    mockFetchRequired.mockReset();
  });

  it('does not call the API when the store has nothing newer', async () => {
    const store = loadStore();
    store.setState({ required: true });
    mockCheckStore.mockResolvedValue('latest');
    await store.getState().check();
    expect(mockFetchRequired).not.toHaveBeenCalled();
    expect(store.getState().required).toBe(false);
  });

  it('asks the API once the store has a newer version', async () => {
    const store = loadStore();
    mockCheckStore.mockResolvedValue('newer');
    mockFetchRequired.mockResolvedValue(true);
    await store.getState().check();
    expect(mockFetchRequired).toHaveBeenCalledTimes(1);
    expect(store.getState().required).toBe(true);
  });

  it('still asks the API when the store cannot be reached', async () => {
    const store = loadStore();
    mockCheckStore.mockResolvedValue('unknown');
    mockFetchRequired.mockResolvedValue(true);
    await store.getState().check();
    expect(store.getState().required).toBe(true);
  });

  it('keeps the dialog and retries right away when the API fails', async () => {
    const store = loadStore();
    store.setState({ required: true });
    mockCheckStore.mockResolvedValue('newer');
    mockFetchRequired.mockResolvedValueOnce(null).mockResolvedValueOnce(false);
    await store.getState().check();
    expect(store.getState().required).toBe(true);
    await store.getState().check();
    expect(mockFetchRequired).toHaveBeenCalledTimes(2);
    expect(store.getState().required).toBe(false);
  });

  it('waits before checking again after a successful check', async () => {
    const store = loadStore();
    mockCheckStore.mockResolvedValue('latest');
    await Promise.all([store.getState().check(), store.getState().check()]);
    await store.getState().check();
    expect(mockCheckStore).toHaveBeenCalledTimes(1);
  });
});
