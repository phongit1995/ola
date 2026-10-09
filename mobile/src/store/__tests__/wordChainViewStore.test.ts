import { useWordChainViewStore } from '../wordChainViewStore';

jest.mock('@ola/shared/stores/word-chain/wordChainStore', () => ({
  useWordChainStore: { subscribe: jest.fn() },
}));

function deferred() {
  let resolve!: () => void;
  let reject!: (error: Error) => void;
  const promise = new Promise<void>((res, rej) => {
    resolve = res;
    reject = rej;
  });
  return { promise, resolve, reject };
}

describe('wordChainViewStore.sendDraft', () => {
  beforeEach(() => useWordChainViewStore.getState().reset());

  it('clears the sent draft and sending flag without a mounted composer', async () => {
    const request = deferred();
    const send = jest.fn(() => request.promise);
    useWordChainViewStore.getState().setDraft(' nối từ ');

    const pending = useWordChainViewStore.getState().sendDraft(send);
    expect(send).toHaveBeenCalledWith('nối từ');
    expect(useWordChainViewStore.getState().sending).toBe(true);

    request.resolve();
    await pending;

    expect(useWordChainViewStore.getState()).toMatchObject({ draft: '', sending: false });
  });

  it('keeps a draft edited while the request was pending', async () => {
    const request = deferred();
    useWordChainViewStore.getState().setDraft('từ một');

    const pending = useWordChainViewStore.getState().sendDraft(() => request.promise);
    useWordChainViewStore.getState().setDraft('từ hai');
    request.resolve();
    await pending;

    expect(useWordChainViewStore.getState()).toMatchObject({ draft: 'từ hai', sending: false });
  });

  it('keeps the draft and rethrows when sending fails', async () => {
    const request = deferred();
    useWordChainViewStore.getState().setDraft('từ lỗi');

    const pending = useWordChainViewStore.getState().sendDraft(() => request.promise);
    request.reject(new Error('fail'));

    await expect(pending).rejects.toThrow('fail');
    expect(useWordChainViewStore.getState()).toMatchObject({ draft: 'từ lỗi', sending: false });
  });

  it('ignores a request that finishes after the room was left', async () => {
    const stale = deferred();
    useWordChainViewStore.getState().setDraft('từ cũ');
    const pending = useWordChainViewStore.getState().sendDraft(() => stale.promise);

    useWordChainViewStore.getState().reset();
    useWordChainViewStore.getState().setDraft('từ cũ');
    const fresh = deferred();
    void useWordChainViewStore.getState().sendDraft(() => fresh.promise);

    stale.resolve();
    await pending;

    expect(useWordChainViewStore.getState()).toMatchObject({ draft: 'từ cũ', sending: true });
    fresh.resolve();
  });
});
