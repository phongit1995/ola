import { useRef } from 'react';
import type { GestureResponderEvent } from 'react-native';

interface HorizontalSwipeOptions {
  onSwipeLeft?: () => void;
  onSwipeRight?: () => void;
  threshold?: number;
}

export interface HorizontalSwipeHandlers {
  onTouchStart: (event: GestureResponderEvent) => void;
  onTouchMove: (event: GestureResponderEvent) => void;
  onTouchEnd: (event: GestureResponderEvent) => void;
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

  function onTouchStart(event: GestureResponderEvent) {
    origin.current = { x: event.nativeEvent.pageX, y: event.nativeEvent.pageY };
    horizontal.current = false;
  }

  function onTouchMove(event: GestureResponderEvent) {
    const start = origin.current;
    if (start == null) return;
    const dx = event.nativeEvent.pageX - start.x;
    const dy = event.nativeEvent.pageY - start.y;
    if (Math.abs(dx) > DIRECTION_LOCK && Math.abs(dx) > Math.abs(dy)) {
      horizontal.current = true;
    }
  }

  function onTouchEnd(event: GestureResponderEvent) {
    const start = origin.current;
    const wasHorizontal = horizontal.current;
    reset();
    if (start == null || !wasHorizontal) return;
    const dx = event.nativeEvent.pageX - start.x;
    if (dx <= -threshold) onSwipeLeft?.();
    else if (dx >= threshold) onSwipeRight?.();
  }

  return { onTouchStart, onTouchMove, onTouchEnd, onTouchCancel: reset };
}
