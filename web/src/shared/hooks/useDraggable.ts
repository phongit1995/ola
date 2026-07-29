import { useCallback, useEffect, useRef, type PointerEvent } from 'react';

interface UseDraggableOptions {
  onClick?: () => void;
  threshold?: number;
}

export interface DraggableHandlers<T extends HTMLElement> {
  ref: (node: T | null) => void;
  onPointerDown: (event: PointerEvent<T>) => void;
  onPointerMove: (event: PointerEvent<T>) => void;
  onPointerUp: (event: PointerEvent<T>) => void;
}

interface ActiveDrag {
  startX: number;
  startY: number;
  baseX: number;
  baseY: number;
  minDx: number;
  maxDx: number;
  minDy: number;
  maxDy: number;
  moved: boolean;
}

const DEFAULT_THRESHOLD = 4;

function clamp(value: number, min: number, max: number): number {
  return Math.min(Math.max(value, min), Math.max(min, max));
}

export function useDraggable<T extends HTMLElement>({
  onClick,
  threshold = DEFAULT_THRESHOLD,
}: UseDraggableOptions = {}): DraggableHandlers<T> {
  const elRef = useRef<T | null>(null);
  const offset = useRef({ x: 0, y: 0 });
  const pending = useRef({ x: 0, y: 0 });
  const drag = useRef<ActiveDrag | null>(null);
  const frame = useRef<number | null>(null);

  const paint = useCallback(() => {
    frame.current = null;
    const el = elRef.current;
    if (el != null) {
      el.style.transform = `translate3d(${pending.current.x}px, ${pending.current.y}px, 0)`;
    }
  }, []);

  const schedule = useCallback(() => {
    if (frame.current == null) frame.current = requestAnimationFrame(paint);
  }, [paint]);

  const ref = useCallback((node: T | null) => {
    elRef.current = node;
    if (node != null) {
      node.style.willChange = 'transform';
      node.style.transform = `translate3d(${offset.current.x}px, ${offset.current.y}px, 0)`;
    }
  }, []);

  const onPointerDown = useCallback((event: PointerEvent<T>) => {
    const el = event.currentTarget;
    const container = el.offsetParent as HTMLElement | null;
    const elRect = el.getBoundingClientRect();
    const bounds = container?.getBoundingClientRect();
    const left = bounds?.left ?? 0;
    const top = bounds?.top ?? 0;
    const width = bounds?.width ?? window.innerWidth;
    const height = bounds?.height ?? window.innerHeight;
    const startLeft = elRect.left - left;
    const startTop = elRect.top - top;
    drag.current = {
      startX: event.clientX,
      startY: event.clientY,
      baseX: offset.current.x,
      baseY: offset.current.y,
      minDx: -startLeft,
      maxDx: width - elRect.width - startLeft,
      minDy: -startTop,
      maxDy: height - elRect.height - startTop,
      moved: false,
    };
    el.setPointerCapture(event.pointerId);
  }, []);

  const onPointerMove = useCallback(
    (event: PointerEvent<T>) => {
      const current = drag.current;
      if (current == null) return;
      const dx = event.clientX - current.startX;
      const dy = event.clientY - current.startY;
      if (Math.abs(dx) > threshold || Math.abs(dy) > threshold)
        current.moved = true;
      if (!current.moved) return;
      pending.current = {
        x: current.baseX + clamp(dx, current.minDx, current.maxDx),
        y: current.baseY + clamp(dy, current.minDy, current.maxDy),
      };
      schedule();
    },
    [schedule, threshold]
  );

  const onPointerUp = useCallback(
    (event: PointerEvent<T>) => {
      const current = drag.current;
      if (current == null) return;
      drag.current = null;
      event.currentTarget.releasePointerCapture(event.pointerId);
      if (current.moved) offset.current = { ...pending.current };
      else onClick?.();
    },
    [onClick]
  );

  useEffect(
    () => () => {
      if (frame.current != null) cancelAnimationFrame(frame.current);
    },
    []
  );

  return { ref, onPointerDown, onPointerMove, onPointerUp };
}
