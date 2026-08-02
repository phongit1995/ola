import { useCallback, useEffect, useRef, type PointerEvent } from 'react';
import type { WidgetPosition } from '@app-types';

export type CallDraggableInitial = (
  bounds: DOMRect,
  element: DOMRect
) => WidgetPosition;

interface UseCallDraggableOptions {
  position: WidgetPosition | null;
  onChange: (position: WidgetPosition) => void;
  initial: CallDraggableInitial;
}

export interface CallDraggableHandlers<T extends HTMLElement> {
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
  minX: number;
  maxX: number;
  minY: number;
  maxY: number;
}

const ORIGIN: WidgetPosition = { x: 0, y: 0 };

function clamp(value: number, min: number, max: number): number {
  return Math.min(Math.max(value, min), Math.max(min, max));
}

export function useCallDraggable<T extends HTMLElement>({
  position,
  onChange,
  initial,
}: UseCallDraggableOptions): CallDraggableHandlers<T> {
  const elementRef = useRef<T | null>(null);
  const offset = useRef<WidgetPosition>(position ?? ORIGIN);
  const pending = useRef<WidgetPosition>(position ?? ORIGIN);
  const drag = useRef<ActiveDrag | null>(null);
  const frame = useRef<number | null>(null);
  const placed = useRef(position != null);

  const paint = useCallback(() => {
    frame.current = null;
    const element = elementRef.current;
    if (element == null) return;
    element.style.transform = `translate3d(${pending.current.x}px, ${pending.current.y}px, 0)`;
  }, []);

  const schedule = useCallback(() => {
    if (frame.current == null) frame.current = requestAnimationFrame(paint);
  }, [paint]);

  const ref = useCallback(
    (node: T | null) => {
      elementRef.current = node;
      if (node == null) return;
      node.style.willChange = 'transform';

      if (!placed.current) {
        const container = node.offsetParent as HTMLElement | null;
        const bounds = container?.getBoundingClientRect();
        if (bounds != null) {
          const next = initial(bounds, node.getBoundingClientRect());
          offset.current = next;
          pending.current = next;
        }
        placed.current = true;
      }

      node.style.transform = `translate3d(${offset.current.x}px, ${offset.current.y}px, 0)`;
    },
    [initial]
  );

  const onPointerDown = useCallback((event: PointerEvent<T>) => {
    const element = event.currentTarget;
    const container = element.offsetParent as HTMLElement | null;
    const bounds = container?.getBoundingClientRect();
    const rect = element.getBoundingClientRect();
    const width = bounds?.width ?? window.innerWidth;
    const height = bounds?.height ?? window.innerHeight;
    const left = rect.left - (bounds?.left ?? 0);
    const top = rect.top - (bounds?.top ?? 0);
    const base = offset.current;

    drag.current = {
      startX: event.clientX,
      startY: event.clientY,
      baseX: base.x,
      baseY: base.y,
      minX: base.x - left,
      maxX: base.x + (width - rect.width - left),
      minY: base.y - top,
      maxY: base.y + (height - rect.height - top),
    };
    element.setPointerCapture(event.pointerId);
  }, []);

  const onPointerMove = useCallback(
    (event: PointerEvent<T>) => {
      const current = drag.current;
      if (current == null) return;
      pending.current = {
        x: clamp(
          current.baseX + (event.clientX - current.startX),
          current.minX,
          current.maxX
        ),
        y: clamp(
          current.baseY + (event.clientY - current.startY),
          current.minY,
          current.maxY
        ),
      };
      schedule();
    },
    [schedule]
  );

  const onPointerUp = useCallback(
    (event: PointerEvent<T>) => {
      if (drag.current == null) return;
      drag.current = null;
      event.currentTarget.releasePointerCapture(event.pointerId);
      offset.current = pending.current;
      onChange(offset.current);
    },
    [onChange]
  );

  useEffect(
    () => () => {
      if (frame.current != null) cancelAnimationFrame(frame.current);
    },
    []
  );

  return { ref, onPointerDown, onPointerMove, onPointerUp };
}
