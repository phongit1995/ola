import { useCallback, useEffect, useState } from 'react';

export interface OffsetPage<T> {
  items: T[];
  total: number;
}

interface UseOffsetPageOptions {
  pageSize?: number;
}

interface OffsetPageState<T> {
  items: T[];
  total: number;
  reachedEnd: boolean;
}

export function useOffsetPage<T>(
  fetchPage: (offset: number) => Promise<OffsetPage<T>>,
  { pageSize }: UseOffsetPageOptions = {}
) {
  const [page, setPage] = useState<OffsetPageState<T>>({ items: [], total: 0, reachedEnd: false });
  const [loading, setLoading] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);
  const [error, setError] = useState<unknown>(null);

  const isLastPage = useCallback(
    (result: OffsetPage<T>) => pageSize != null && result.items.length < pageSize,
    [pageSize]
  );

  useEffect(() => {
    let active = true;
    fetchPage(0)
      .then((result) => {
        if (!active) return;
        setPage({ items: result.items, total: result.total, reachedEnd: isLastPage(result) });
        setError(null);
      })
      .catch((err: unknown) => {
        if (active) setError(err);
      })
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, [fetchPage, isLastPage]);

  const hasMore = !page.reachedEnd && page.items.length < page.total;

  const loadMore = useCallback(async () => {
    if (loading || loadingMore || !hasMore) return;
    setLoadingMore(true);
    try {
      const result = await fetchPage(page.items.length);
      setPage((current) => ({
        items: [...current.items, ...result.items],
        total: result.total,
        reachedEnd: isLastPage(result),
      }));
    } catch {
      return;
    } finally {
      setLoadingMore(false);
    }
  }, [fetchPage, isLastPage, loading, loadingMore, hasMore, page.items.length]);

  const setItems = useCallback((update: (items: T[]) => T[]) => {
    setPage((current) => ({ ...current, items: update(current.items) }));
  }, []);

  return {
    items: page.items,
    total: page.total,
    loading,
    loadingMore,
    error,
    hasMore,
    loadMore,
    setItems,
  };
}
