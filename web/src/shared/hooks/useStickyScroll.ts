import { useCallback, useEffect, useLayoutEffect, useRef } from 'react';

interface AnchorCandidate {
  element: Element;
  index: number;
  top: number;
}

function childIndex(container: HTMLElement, element: Element): number {
  return Array.prototype.indexOf.call(container.children, element);
}

interface PrependAnchor {
  candidates: AnchorCandidate[];
  scrollHeight: number;
  started: boolean;
}

function captureAnchor(container: HTMLElement): PrependAnchor {
  const containerTop = container.getBoundingClientRect().top;
  const containerBottom = containerTop + container.clientHeight;
  const candidates: AnchorCandidate[] = [];
  Array.from(container.children).some((child, index) => {
    const rect = child.getBoundingClientRect();
    if (rect.bottom <= containerTop) return false;
    if (rect.top >= containerBottom) return true;
    candidates.push({ element: child, index, top: rect.top - containerTop });
    return false;
  });
  return { candidates, scrollHeight: container.scrollHeight, started: false };
}

function restoreAnchor(container: HTMLElement, anchor: PrependAnchor) {
  const kept =
    anchor.candidates.find(
      (candidate) => childIndex(container, candidate.element) > candidate.index
    ) ??
    anchor.candidates.find(
      (candidate) => candidate.element.parentElement === container
    );
  if (kept == null) {
    container.scrollTop += container.scrollHeight - anchor.scrollHeight;
    anchor.scrollHeight = container.scrollHeight;
    return;
  }
  const containerTop = container.getBoundingClientRect().top;
  const currentTop = kept.element.getBoundingClientRect().top - containerTop;
  container.scrollTop += currentTop - kept.top;
}

interface UseStickyScrollOptions {
  count: number;
  lastId: string | null;
  hasMore?: boolean;
  loadingMore?: boolean;
  onLoadMore?: () => void;
  enabled?: boolean;
  loadMoreAtTop?: number;
  loadMoreViewports?: number;
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
  loadMoreViewports = 0,
  bottomThreshold = 80,
  onStickyChange,
}: UseStickyScrollOptions) {
  const scrollRef = useRef<HTMLDivElement>(null);
  const stickyRef = useRef(true);
  const onStickyChangeRef = useRef(onStickyChange);
  const lastIdRef = useRef<string | null>(null);
  const prependAnchorRef = useRef<PrependAnchor | null>(null);
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

    if (
      prependAnchorRef.current == null &&
      enabled &&
      lastId !== lastIdRef.current &&
      stickyRef.current
    ) {
      element.scrollTop = element.scrollHeight;
    }
    lastIdRef.current = lastId;
  }, [count, lastId, enabled]);

  useLayoutEffect(() => {
    const element = scrollRef.current;
    const anchor = prependAnchorRef.current;
    if (element == null || anchor == null) return;
    if (loadingMore) {
      anchor.started = true;
      restoreAnchor(element, anchor);
      return;
    }
    if (!anchor.started) return;
    restoreAnchor(element, anchor);
    prependAnchorRef.current = null;
  }, [loadingMore, count]);

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
    const loadMoreDistance = Math.max(
      loadMoreAtTop,
      element.clientHeight * loadMoreViewports
    );
    if (
      element.scrollTop <= loadMoreDistance &&
      hasMore &&
      !loadingMore &&
      onLoadMore != null
    ) {
      prependAnchorRef.current = captureAnchor(element);
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
    loadMoreViewports,
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
