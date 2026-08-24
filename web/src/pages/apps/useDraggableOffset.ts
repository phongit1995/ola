import {
  useCallback,
  useEffect,
  useRef,
  useState,
  type PointerEvent as ReactPointerEvent,
  type MouseEvent as ReactMouseEvent,
} from 'react';

export interface DragOffset {
  x: number;
  y: number;
}

export interface DragPointerPosition {
  clientX: number;
  clientY: number;
}

interface DragSession {
  pointerId: number;
  startX: number;
  startY: number;
  baseX: number;
  baseY: number;
  minX: number;
  maxX: number;
  minY: number;
  maxY: number;
  moved: boolean;
}

interface DragBounds {
  minX: number;
  maxX: number;
  minY: number;
  maxY: number;
}

interface UseDraggableOffsetOptions {
  initialOffset: DragOffset;
  onCommit: (offset: DragOffset) => void;
  onTap: () => void;
  visible: boolean;
  onDragChange?: (dragging: boolean) => void;
  onDragMove?: (position: DragPointerPosition) => void;
  onDrop?: (position: DragPointerPosition) => boolean;
}

const DRAG_THRESHOLD = 4;
const KEYBOARD_CLICK_DETAIL = 0;

function clamp(value: number, min: number, max: number): number {
  if (min > max) return (min + max) / 2;
  return Math.min(Math.max(value, min), max);
}

function applyOffset(element: HTMLElement | null, offset: DragOffset) {
  if (!element) return;
  element.style.transform = `translate3d(${offset.x}px, ${offset.y}px, 0)`;
}

function boundsFor(element: HTMLElement): DragBounds {
  const container = element.offsetParent as HTMLElement | null;
  const rect = element.getBoundingClientRect();
  const area = container?.getBoundingClientRect();
  const left = area?.left ?? 0;
  const top = area?.top ?? 0;
  const width = area?.width ?? window.innerWidth;
  const height = area?.height ?? window.innerHeight;
  const startLeft = rect.left - left;
  const startTop = rect.top - top;
  return {
    minX: -startLeft,
    maxX: width - rect.width - startLeft,
    minY: -startTop,
    maxY: height - rect.height - startTop,
  };
}

export function useDraggableOffset({
  initialOffset,
  onCommit,
  onTap,
  visible,
  onDragChange,
  onDragMove,
  onDrop,
}: UseDraggableOffsetOptions) {
  const elementRef = useRef<HTMLElement | null>(null);
  const [offset, setOffset] = useState(initialOffset);
  const offsetRef = useRef(offset);
  const pendingRef = useRef(offset);
  const frameRef = useRef<number | null>(null);
  const sessionRef = useRef<DragSession | null>(null);
  const commitRef = useRef(onCommit);
  const tapRef = useRef(onTap);
  const dragChangeRef = useRef(onDragChange);
  const dragMoveRef = useRef(onDragMove);
  const dropRef = useRef(onDrop);

  useEffect(() => {
    commitRef.current = onCommit;
    tapRef.current = onTap;
    dragChangeRef.current = onDragChange;
    dragMoveRef.current = onDragMove;
    dropRef.current = onDrop;
  });

  const setElement = useCallback((element: HTMLElement | null) => {
    elementRef.current = element;
    applyOffset(element, offsetRef.current);
  }, []);

  const settle = useCallback((next: DragOffset) => {
    offsetRef.current = next;
    pendingRef.current = next;
    applyOffset(elementRef.current, next);
    setOffset((current) =>
      current.x === next.x && current.y === next.y ? current : next
    );
    commitRef.current(next);
  }, []);

  const commitPending = useCallback(() => {
    if (frameRef.current != null) {
      cancelAnimationFrame(frameRef.current);
      frameRef.current = null;
    }
    settle(pendingRef.current);
  }, [settle]);

  const keepInBounds = useCallback(() => {
    if (sessionRef.current || frameRef.current != null) return;
    const element = elementRef.current;
    if (!element) return;
    const bounds = boundsFor(element);
    const next = {
      x: offsetRef.current.x + clamp(0, bounds.minX, bounds.maxX),
      y: offsetRef.current.y + clamp(0, bounds.minY, bounds.maxY),
    };
    if (next.x === offsetRef.current.x && next.y === offsetRef.current.y)
      return;
    settle(next);
  }, [settle]);

  useEffect(
    () => () => {
      if (frameRef.current != null) cancelAnimationFrame(frameRef.current);
    },
    []
  );

  useEffect(() => {
    if (!visible) return;
    const container = elementRef.current?.offsetParent as HTMLElement | null;
    const initialFrame = requestAnimationFrame(keepInBounds);
    const resizeObserver =
      typeof ResizeObserver === 'undefined'
        ? null
        : new ResizeObserver(keepInBounds);
    if (container) resizeObserver?.observe(container);
    window.addEventListener('resize', keepInBounds);
    window.visualViewport?.addEventListener('resize', keepInBounds);
    return () => {
      cancelAnimationFrame(initialFrame);
      resizeObserver?.disconnect();
      window.removeEventListener('resize', keepInBounds);
      window.visualViewport?.removeEventListener('resize', keepInBounds);
    };
  }, [visible, keepInBounds]);

  function schedule(next: DragOffset) {
    pendingRef.current = next;
    if (frameRef.current != null) return;
    frameRef.current = requestAnimationFrame(() => {
      frameRef.current = null;
      const pending = pendingRef.current;
      offsetRef.current = pending;
      applyOffset(elementRef.current, pending);
    });
  }

  function offsetFromPointer(
    session: DragSession,
    clientX: number,
    clientY: number
  ): DragOffset {
    const dx = clientX - session.startX;
    const dy = clientY - session.startY;
    return {
      x: session.baseX + clamp(dx, session.minX, session.maxX),
      y: session.baseY + clamp(dy, session.minY, session.maxY),
    };
  }

  function onPointerDown(event: ReactPointerEvent<HTMLElement>) {
    if (!event.isPrimary || event.button !== 0 || sessionRef.current) return;
    event.preventDefault();
    const element = event.currentTarget;
    sessionRef.current = {
      pointerId: event.pointerId,
      startX: event.clientX,
      startY: event.clientY,
      baseX: offsetRef.current.x,
      baseY: offsetRef.current.y,
      moved: false,
      ...boundsFor(element),
    };
    element.setPointerCapture(event.pointerId);
  }

  function onPointerMove(event: ReactPointerEvent<HTMLElement>) {
    const session = sessionRef.current;
    if (!session || session.pointerId !== event.pointerId) return;
    const dx = event.clientX - session.startX;
    const dy = event.clientY - session.startY;
    if (Math.hypot(dx, dy) > DRAG_THRESHOLD && !session.moved) {
      session.moved = true;
      dragChangeRef.current?.(true);
    }
    if (!session.moved) return;
    event.preventDefault();
    dragMoveRef.current?.({ clientX: event.clientX, clientY: event.clientY });
    schedule(offsetFromPointer(session, event.clientX, event.clientY));
  }

  function onPointerUp(event: ReactPointerEvent<HTMLElement>) {
    const session = sessionRef.current;
    if (!session || session.pointerId !== event.pointerId) return;
    const dx = event.clientX - session.startX;
    const dy = event.clientY - session.startY;
    const moved = session.moved || Math.hypot(dx, dy) > DRAG_THRESHOLD;
    sessionRef.current = null;
    if (event.currentTarget.hasPointerCapture(event.pointerId)) {
      event.currentTarget.releasePointerCapture(event.pointerId);
    }
    if (!moved) {
      tapRef.current();
      return;
    }

    const position = { clientX: event.clientX, clientY: event.clientY };
    dragMoveRef.current?.(position);
    const dropped = dropRef.current?.(position) === true;
    dragChangeRef.current?.(false);
    if (dropped) {
      if (frameRef.current != null) {
        cancelAnimationFrame(frameRef.current);
        frameRef.current = null;
      }
      const base = { x: session.baseX, y: session.baseY };
      offsetRef.current = base;
      pendingRef.current = base;
      applyOffset(elementRef.current, base);
      return;
    }

    pendingRef.current = offsetFromPointer(
      session,
      event.clientX,
      event.clientY
    );
    commitPending();
  }

  function endWithoutTap(event: ReactPointerEvent<HTMLElement>) {
    const session = sessionRef.current;
    if (!session || session.pointerId !== event.pointerId) return;
    sessionRef.current = null;
    commitPending();
    if (session.moved) dragChangeRef.current?.(false);
  }

  function onClick(event: ReactMouseEvent<HTMLElement>) {
    if (event.detail === KEYBOARD_CLICK_DETAIL) tapRef.current();
  }

  return {
    setElement,
    offset,
    keepInBounds,
    dragHandlers: {
      onPointerDown,
      onPointerMove,
      onPointerUp,
      onPointerCancel: endWithoutTap,
      onLostPointerCapture: endWithoutTap,
      onClick,
      onDragStart: (event: { preventDefault: () => void }) =>
        event.preventDefault(),
    },
  };
}
