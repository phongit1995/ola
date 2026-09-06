import { useCallback, useEffect, useLayoutEffect, useRef } from 'react';

interface UseStickyScrollOptions {
  count: number;
  lastId: string | null;
  hasMore?: boolean;
  loadingMore?: boolean;
  onLoadMore?: () => void;
  enabled?: boolean;
  loadMoreAtTop?: number;
  bottomThreshold?: number;
  onStickyChange?: (sticky: boolean) => void;
}

export function useStickyScroll({
  count,
  lastId,
  hasMore = false,
  loadingMore = false,
  onLoadMore,
  enabled = true,
  loadMoreAtTop = 0,
  bottomThreshold = 80,
  onStickyChange,
}: UseStickyScrollOptions) {
  const scrollRef = useRef<HTMLDivElement>(null);
  const stickyRef = useRef(true);
  const onStickyChangeRef = useRef(onStickyChange);
  const lastIdRef = useRef<string | null>(null);
  const prependAnchorRef = useRef<number | null>(null);
  const wasEnabledRef = useRef(enabled);
  const savedScrollTopRef = useRef<number | null>(null);

  useLayoutEffect(() => {
    onStickyChangeRef.current = onStickyChange;
  }, [onStickyChange]);

  useLayoutEffect(() => {
    onStickyChangeRef.current?.(stickyRef.current);
  }, []);

  useLayoutEffect(() => {
    const element = scrollRef.current;
    if (element == null) return;
    const becameVisible = enabled && !wasEnabledRef.current;
    wasEnabledRef.current = enabled;

    if (becameVisible) {
      if (stickyRef.current) {
        element.scrollTop = element.scrollHeight;
      } else if (savedScrollTopRef.current != null) {
        element.scrollTop = savedScrollTopRef.current;
      }
      lastIdRef.current = lastId;
      return;
    }

    if (prependAnchorRef.current != null) {
      element.scrollTop =
        element.scrollTop + element.scrollHeight - prependAnchorRef.current;
      prependAnchorRef.current = null;
    } else if (enabled && lastId !== lastIdRef.current && stickyRef.current) {
      element.scrollTop = element.scrollHeight;
    }
    lastIdRef.current = lastId;
  }, [count, lastId, enabled]);

  useEffect(() => {
    const element = scrollRef.current;
    if (element == null) return;
    function scrollToBottomIfPinned() {
      const target = scrollRef.current;
      if (
        target != null &&
        stickyRef.current &&
        prependAnchorRef.current == null
      ) {
        target.scrollTop = target.scrollHeight;
      }
    }
    element.addEventListener('load', scrollToBottomIfPinned, true);
    return () =>
      element.removeEventListener('load', scrollToBottomIfPinned, true);
  }, []);

  useEffect(() => {
    const viewport = window.visualViewport;
    function repinBottom() {
      const element = scrollRef.current;
      if (
        element != null &&
        stickyRef.current &&
        prependAnchorRef.current == null
      ) {
        element.scrollTop = element.scrollHeight;
      }
    }
    const target: Window | VisualViewport = viewport ?? window;
    target.addEventListener('resize', repinBottom);
    return () => target.removeEventListener('resize', repinBottom);
  }, []);

  const setSticky = useCallback((sticky: boolean) => {
    if (stickyRef.current === sticky) return;
    stickyRef.current = sticky;
    onStickyChangeRef.current?.(sticky);
  }, []);

  const handleScroll = useCallback(() => {
    const element = scrollRef.current;
    if (element == null || !enabled) return;
    const distanceFromBottom =
      element.scrollHeight - element.scrollTop - element.clientHeight;
    setSticky(distanceFromBottom < bottomThreshold);
    savedScrollTopRef.current = element.scrollTop;
    if (
      element.scrollTop <= loadMoreAtTop &&
      hasMore &&
      !loadingMore &&
      onLoadMore != null
    ) {
      prependAnchorRef.current = element.scrollHeight;
      setSticky(false);
      onLoadMore();
    }
  }, [
    enabled,
    hasMore,
    loadingMore,
    onLoadMore,
    bottomThreshold,
    loadMoreAtTop,
    setSticky,
  ]);

  const pin = useCallback(() => {
    setSticky(true);
  }, [setSticky]);

  const unpin = useCallback(() => {
    setSticky(false);
  }, [setSticky]);

  const scrollToBottomIfPinned = useCallback(() => {
    const element = scrollRef.current;
    if (element != null && stickyRef.current)
      element.scrollTop = element.scrollHeight;
  }, []);

  return { scrollRef, handleScroll, pin, unpin, scrollToBottomIfPinned };
}
