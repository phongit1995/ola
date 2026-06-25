import { useRef, type TouchEvent } from 'react';

interface HorizontalSwipeOptions {
  onSwipeLeft?: () => void;
  onSwipeRight?: () => void;
  threshold?: number;
}

export interface HorizontalSwipeHandlers {
  onTouchStart: (event: TouchEvent) => void;
  onTouchMove: (event: TouchEvent) => void;
  onTouchEnd: (event: TouchEvent) => void;
  onTouchCancel: () => void;
}

const DEFAULT_THRESHOLD = 60;
const DIRECTION_LOCK = 12;

export function useHorizontalSwipe({
  onSwipeLeft,
  onSwipeRight,
  threshold = DEFAULT_THRESHOLD,
}: HorizontalSwipeOptions): HorizontalSwipeHandlers {
  const origin = useRef<{ x: number; y: number } | null>(null);
  const horizontal = useRef(false);

  function reset() {
    origin.current = null;
    horizontal.current = false;
  }

  function onTouchStart(event: TouchEvent) {
    const touch = event.touches[0];
    if (touch == null) return;
    origin.current = { x: touch.clientX, y: touch.clientY };
    horizontal.current = false;
  }

  function onTouchMove(event: TouchEvent) {
    const start = origin.current;
    const touch = event.touches[0];
    if (start == null || touch == null) return;
    const dx = touch.clientX - start.x;
    const dy = touch.clientY - start.y;
    if (Math.abs(dx) > DIRECTION_LOCK && Math.abs(dx) > Math.abs(dy)) {
      horizontal.current = true;
    }
  }

  function onTouchEnd(event: TouchEvent) {
    const start = origin.current;
    const wasHorizontal = horizontal.current;
    reset();
    const touch = event.changedTouches[0];
    if (start == null || !wasHorizontal || touch == null) return;
    const dx = touch.clientX - start.x;
    if (dx <= -threshold) onSwipeLeft?.();
    else if (dx >= threshold) onSwipeRight?.();
  }

  return { onTouchStart, onTouchMove, onTouchEnd, onTouchCancel: reset };
}
