import { useCallback, useEffect, useLayoutEffect, useRef } from 'react';

interface UseStickyScrollOptions {
  count: number;
  lastId: string | null;
  hasMore: boolean;
  loadingMore: boolean;
  onLoadMore: () => void;
  enabled?: boolean;
  loadMoreAtTop?: number;
  bottomThreshold?: number;
}

export function useStickyScroll({
  count,
  lastId,
  hasMore,
  loadingMore,
  onLoadMore,
  enabled = true,
  loadMoreAtTop = 0,
  bottomThreshold = 80,
}: UseStickyScrollOptions) {
  const scrollRef = useRef<HTMLDivElement>(null);
  const stickyRef = useRef(true);
  const lastIdRef = useRef<string | null>(null);
  const prependAnchorRef = useRef<number | null>(null);

  useLayoutEffect(() => {
    const element = scrollRef.current;
    if (element == null) return;
    if (prependAnchorRef.current != null) {
      element.scrollTop = element.scrollHeight - prependAnchorRef.current;
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
      if (target != null && stickyRef.current && prependAnchorRef.current == null) {
        target.scrollTop = target.scrollHeight;
      }
    }
    element.addEventListener('load', scrollToBottomIfPinned, true);
    return () => element.removeEventListener('load', scrollToBottomIfPinned, true);
  }, []);

  const handleScroll = useCallback(() => {
    const element = scrollRef.current;
    if (element == null) return;
    const distanceFromBottom = element.scrollHeight - element.scrollTop - element.clientHeight;
    stickyRef.current = distanceFromBottom < bottomThreshold;
    if (element.scrollTop <= loadMoreAtTop && hasMore && !loadingMore) {
      prependAnchorRef.current = element.scrollHeight;
      onLoadMore();
    }
  }, [hasMore, loadingMore, onLoadMore, bottomThreshold, loadMoreAtTop]);

  const pin = useCallback(() => {
    stickyRef.current = true;
  }, []);

  const unpin = useCallback(() => {
    stickyRef.current = false;
  }, []);

  const scrollToBottomIfPinned = useCallback(() => {
    const element = scrollRef.current;
    if (element != null && stickyRef.current) element.scrollTop = element.scrollHeight;
  }, []);

  return { scrollRef, handleScroll, pin, unpin, scrollToBottomIfPinned };
}
