import { useCallback, useLayoutEffect, useRef, type ReactNode } from 'react';

const THUMB_INSET = 6;
const THUMB_MIN = 28;

interface ScrollRowsProps {
  className: string;
  label: string;
  count: number;
  children: ReactNode;
}

export function ScrollRows({ className, label, count, children }: ScrollRowsProps) {
  const listRef = useRef<HTMLUListElement>(null);
  const thumbRef = useRef<HTMLSpanElement>(null);

  const sync = useCallback(() => {
    const list = listRef.current;
    const thumb = thumbRef.current;
    if (!list || !thumb) return;
    const { scrollTop, scrollHeight, clientHeight } = list;
    const overflow = scrollHeight - clientHeight;
    thumb.hidden = overflow <= 1;
    if (thumb.hidden) return;
    const track = clientHeight - THUMB_INSET * 2;
    const size = Math.max(THUMB_MIN, (clientHeight / scrollHeight) * track);
    thumb.style.height = `${size}px`;
    thumb.style.transform = `translateY(${THUMB_INSET + (scrollTop / overflow) * (track - size)}px)`;
  }, []);

  useLayoutEffect(() => {
    sync();
    const list = listRef.current;
    if (!list) return;
    const observer = new ResizeObserver(sync);
    observer.observe(list);
    for (const child of Array.from(list.children)) observer.observe(child);
    return () => observer.disconnect();
  }, [sync, count]);

  return (
    <div className="ty-scroll">
      <ul ref={listRef} className={`ty-scroll-list ${className}`} aria-label={label} onScroll={sync}>
        {children}
      </ul>
      <span ref={thumbRef} className="ty-scroll-thumb" aria-hidden="true" hidden />
    </div>
  );
}
