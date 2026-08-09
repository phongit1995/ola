import {
  useRef,
  useState,
  type CSSProperties,
  type ReactNode,
  type TouchEvent,
} from 'react';
import { cn } from '@lib';
import { Spinner } from './Spinner';

const THRESHOLD = 64;
const MAX_PULL = 96;
const RESISTANCE = 0.5;

interface PullToRefreshProps {
  onRefresh: () => void | Promise<void>;
  className?: string;
  style?: CSSProperties;
  children: ReactNode;
}

export function PullToRefresh({
  onRefresh,
  className,
  style,
  children,
}: PullToRefreshProps) {
  const scrollRef = useRef<HTMLDivElement>(null);
  const startY = useRef<number | null>(null);
  const pullRef = useRef(0);
  const [pull, setPull] = useState(0);
  const [refreshing, setRefreshing] = useState(false);
  const [snapping, setSnapping] = useState(false);

  function applyPull(value: number) {
    pullRef.current = value;
    setPull(value);
  }

  function onTouchStart(event: TouchEvent<HTMLDivElement>) {
    const el = scrollRef.current;
    if (el == null || refreshing) return;
    startY.current =
      el.scrollTop <= 0 ? event.touches[0]?.clientY ?? null : null;
  }

  function onTouchMove(event: TouchEvent<HTMLDivElement>) {
    if (startY.current == null || refreshing) return;
    const delta = (event.touches[0]?.clientY ?? 0) - startY.current;
    if (delta <= 0) {
      startY.current = null;
      if (pullRef.current !== 0) {
        setSnapping(true);
        applyPull(0);
      }
      return;
    }
    setSnapping(false);
    applyPull(Math.min(MAX_PULL, delta * RESISTANCE));
  }

  async function onTouchEnd() {
    if (startY.current == null) return;
    startY.current = null;
    if (pullRef.current >= THRESHOLD && !refreshing) {
      setSnapping(true);
      setRefreshing(true);
      applyPull(THRESHOLD);
      try {
        await onRefresh();
      } finally {
        setSnapping(true);
        setRefreshing(false);
        applyPull(0);
      }
      return;
    }
    setSnapping(true);
    applyPull(0);
  }

  const indicatorOpacity = refreshing ? 1 : Math.min(1, pull / THRESHOLD);

  return (
    <div
      ref={scrollRef}
      className={cn('overscroll-contain', className)}
      style={style}
      onTouchStart={onTouchStart}
      onTouchMove={onTouchMove}
      onTouchEnd={onTouchEnd}
      onTouchCancel={onTouchEnd}
    >
      <div
        className={cn(
          'pointer-events-none absolute inset-x-0 z-10 flex h-16 items-center justify-center',
          snapping && 'transition-all duration-200'
        )}
        style={{ top: pull - THRESHOLD, opacity: indicatorOpacity }}
      >
        <Spinner size={24} />
      </div>
      <div
        className={cn(
          'flex min-h-full flex-col',
          snapping && 'transition-transform duration-200'
        )}
        style={{ transform: `translateY(${pull}px)` }}
        onTransitionEnd={() => setSnapping(false)}
      >
        {children}
      </div>
    </div>
  );
}
