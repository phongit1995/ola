import { act, create, type ReactTestRenderer } from 'react-test-renderer';
import { UserService } from '@ola/shared/services/user.service';
import { useOffsetPage, type OffsetPage } from '@ola/shared/stores/useOffsetPage';
import { useUserSearch } from '@ola/shared/stores/user/useUserSearch';

jest.mock('@ola/shared/services/user.service', () => ({
  UserService: { search: jest.fn() },
}));

const search = UserService.search as jest.Mock;

type PageResult = ReturnType<typeof useOffsetPage<number>>;
type SearchResult = ReturnType<typeof useUserSearch>;

let page: PageResult;
let found: SearchResult;

function PageHarness({
  fetchPage,
  pageSize,
}: {
  fetchPage: (offset: number) => Promise<OffsetPage<number>>;
  pageSize?: number;
}) {
  page = useOffsetPage(fetchPage, { pageSize });
  return null;
}

function SearchHarness({
  query,
  onError,
  keepPreviousResults,
}: {
  query: string;
  onError?: () => void;
  keepPreviousResults?: boolean;
}) {
  found = useUserSearch(query, { debounceMs: 100, onError, keepPreviousResults });
  return null;
}

async function flush() {
  await act(async () => {
    await Promise.resolve();
  });
}

describe('useOffsetPage', () => {
  let renderer: ReactTestRenderer | null = null;

  afterEach(() => {
    act(() => renderer?.unmount());
    renderer = null;
  });

  it('loads the first page and appends the next pages until total', async () => {
    const fetchPage = jest.fn((offset: number) =>
      Promise.resolve({ items: [offset, offset + 1], total: 4 }),
    );
    act(() => {
      renderer = create(<PageHarness fetchPage={fetchPage} />);
    });
    expect(page.loading).toBe(true);
    await flush();
    expect(page.items).toEqual([0, 1]);
    expect(page.hasMore).toBe(true);

    await act(async () => {
      await page.loadMore();
    });
    expect(fetchPage).toHaveBeenLastCalledWith(2);
    expect(page.items).toEqual([0, 1, 2, 3]);
    expect(page.hasMore).toBe(false);
  });

  it('stops when a page is shorter than pageSize', async () => {
    const fetchPage = jest.fn(() => Promise.resolve({ items: [1], total: 50 }));
    act(() => {
      renderer = create(<PageHarness fetchPage={fetchPage} pageSize={20} />);
    });
    await flush();
    expect(page.hasMore).toBe(false);
  });

  it('exposes the first page error and keeps items empty', async () => {
    const failure = new Error('boom');
    act(() => {
      renderer = create(<PageHarness fetchPage={() => Promise.reject(failure)} />);
    });
    await flush();
    expect(page.loading).toBe(false);
    expect(page.error).toBe(failure);
    expect(page.items).toEqual([]);
  });

  it('ignores a failed next page', async () => {
    const fetchPage = jest
      .fn()
      .mockResolvedValueOnce({ items: [1], total: 3 })
      .mockRejectedValueOnce(new Error('later'));
    act(() => {
      renderer = create(<PageHarness fetchPage={fetchPage} />);
    });
    await flush();
    await act(async () => {
      await page.loadMore();
    });
    expect(page.items).toEqual([1]);
    expect(page.loadingMore).toBe(false);
    expect(page.error).toBeNull();
  });
});

describe('useUserSearch', () => {
  let renderer: ReactTestRenderer | null = null;

  beforeEach(() => {
    jest.useFakeTimers();
    search.mockReset();
  });

  afterEach(() => {
    act(() => renderer?.unmount());
    renderer = null;
    jest.useRealTimers();
  });

  it('debounces and returns users for the latest query only', async () => {
    let resolveFirst: (value: unknown) => void = () => undefined;
    search
      .mockImplementationOnce(() => new Promise((resolve) => (resolveFirst = resolve)))
      .mockResolvedValueOnce({ users: [{ id: 'b' }] });

    act(() => {
      renderer = create(<SearchHarness query="a" />);
    });
    expect(found.searching).toBe(true);
    act(() => jest.advanceTimersByTime(100));
    act(() => renderer?.update(<SearchHarness query="ab" />));
    act(() => jest.advanceTimersByTime(100));
    await flush();
    expect(found.results).toEqual([{ id: 'b' }]);

    resolveFirst({ users: [{ id: 'stale' }] });
    await flush();
    expect(found.results).toEqual([{ id: 'b' }]);
    expect(search).toHaveBeenNthCalledWith(1, 'a', 30);
    expect(search).toHaveBeenNthCalledWith(2, 'ab', 30);
  });

  it('calls onError and returns no users when the search fails', async () => {
    const onError = jest.fn();
    search.mockRejectedValueOnce(new Error('down'));
    act(() => {
      renderer = create(<SearchHarness query="x" onError={onError} />);
    });
    act(() => jest.advanceTimersByTime(100));
    await flush();
    expect(onError).toHaveBeenCalledTimes(1);
    expect(found.results).toEqual([]);
    expect(found.searching).toBe(false);
  });

  it('does not search a blank query', () => {
    act(() => {
      renderer = create(<SearchHarness query="   " />);
    });
    act(() => jest.advanceTimersByTime(500));
    expect(search).not.toHaveBeenCalled();
    expect(found.searching).toBe(false);
  });

  it('keeps previous results while debouncing and on error when asked', async () => {
    const onError = jest.fn();
    search
      .mockResolvedValueOnce({ users: [{ id: 'a' }] })
      .mockRejectedValueOnce(new Error('down'));
    act(() => {
      renderer = create(<SearchHarness query="a" keepPreviousResults onError={onError} />);
    });
    expect(found.searching).toBe(false);
    act(() => jest.advanceTimersByTime(100));
    expect(found.searching).toBe(true);
    await flush();
    expect(found.results).toEqual([{ id: 'a' }]);
    expect(found.searching).toBe(false);

    act(() => renderer?.update(<SearchHarness query="ab" keepPreviousResults onError={onError} />));
    expect(found.results).toEqual([{ id: 'a' }]);
    expect(found.searching).toBe(false);
    act(() => jest.advanceTimersByTime(100));
    await flush();
    expect(onError).toHaveBeenCalledTimes(1);
    expect(found.results).toEqual([{ id: 'a' }]);
    expect(found.searching).toBe(false);

    act(() => renderer?.update(<SearchHarness query="" keepPreviousResults onError={onError} />));
    expect(found.results).toEqual([{ id: 'a' }]);
    act(() => jest.advanceTimersByTime(100));
    expect(found.results).toEqual([]);
  });
});
