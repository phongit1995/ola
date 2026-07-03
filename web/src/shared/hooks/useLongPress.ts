import { useRef, type PointerEvent as ReactPointerEvent, type MouseEvent as ReactMouseEvent } from 'react';

const LONG_PRESS_MS = 450;
const MOVE_THRESHOLD = 10;

export function useLongPress(onLongPress: (anchor: DOMRect | null) => void) {
  const timer = useRef<ReturnType<typeof setTimeout> | null>(null);
  const origin = useRef<{ x: number; y: number } | null>(null);
  const target = useRef<HTMLElement | null>(null);

  function clear() {
    if (timer.current != null) {
      clearTimeout(timer.current);
      timer.current = null;
    }
    origin.current = null;
    target.current = null;
  }

  return {
    onPointerDown: (event: ReactPointerEvent) => {
      clear();
      origin.current = { x: event.clientX, y: event.clientY };
      target.current = event.currentTarget as HTMLElement;
      timer.current = setTimeout(() => {
        timer.current = null;
        onLongPress(target.current?.getBoundingClientRect() ?? null);
      }, LONG_PRESS_MS);
    },
    onPointerMove: (event: ReactPointerEvent) => {
      const start = origin.current;
      if (start == null) return;
      if (
        Math.abs(event.clientX - start.x) > MOVE_THRESHOLD ||
        Math.abs(event.clientY - start.y) > MOVE_THRESHOLD
      ) {
        clear();
      }
    },
    onPointerUp: clear,
    onPointerLeave: clear,
    onContextMenu: (event: ReactMouseEvent) => {
      event.preventDefault();
      const rect = (event.currentTarget as HTMLElement).getBoundingClientRect();
      clear();
      onLongPress(rect);
    },
  };
}
