import { useCallback, useRef, type PointerEvent } from 'react';
import { PIP_MAX_WIDTH, PIP_MIN_WIDTH } from '../constants';

interface UsePipResizeOptions {
  width: number;
  onChange: (width: number) => void;
}

export interface PipResizeHandlers<T extends HTMLElement> {
  onPointerDown: (event: PointerEvent<T>) => void;
  onPointerMove: (event: PointerEvent<T>) => void;
  onPointerUp: (event: PointerEvent<T>) => void;
}

interface ActiveResize {
  startX: number;
  baseWidth: number;
}

function clamp(value: number): number {
  return Math.min(Math.max(value, PIP_MIN_WIDTH), PIP_MAX_WIDTH);
}

export function usePipResize<T extends HTMLElement>({
  width,
  onChange,
}: UsePipResizeOptions): PipResizeHandlers<T> {
  const resize = useRef<ActiveResize | null>(null);
  const frame = useRef<number | null>(null);
  const pending = useRef(width);

  const flush = useCallback(() => {
    frame.current = null;
    onChange(pending.current);
  }, [onChange]);

  const onPointerDown = useCallback(
    (event: PointerEvent<T>) => {
      event.stopPropagation();
      resize.current = { startX: event.clientX, baseWidth: width };
      event.currentTarget.setPointerCapture(event.pointerId);
    },
    [width]
  );

  const onPointerMove = useCallback(
    (event: PointerEvent<T>) => {
      const current = resize.current;
      if (current == null) return;
      event.stopPropagation();
      pending.current = clamp(
        current.baseWidth - (event.clientX - current.startX)
      );
      if (frame.current == null) frame.current = requestAnimationFrame(flush);
    },
    [flush]
  );

  const onPointerUp = useCallback((event: PointerEvent<T>) => {
    if (resize.current == null) return;
    event.stopPropagation();
    resize.current = null;
    event.currentTarget.releasePointerCapture(event.pointerId);
  }, []);

  return { onPointerDown, onPointerMove, onPointerUp };
}
