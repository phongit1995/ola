import { useEffect, useState, type RefObject } from 'react';

const EDGE_TOLERANCE_PX = 1;

interface ScrollEdges {
  canScrollPrev: boolean;
  canScrollNext: boolean;
}

function readEdges(element: HTMLElement): ScrollEdges {
  const maxScrollLeft = element.scrollWidth - element.clientWidth;
  return {
    canScrollPrev: element.scrollLeft > EDGE_TOLERANCE_PX,
    canScrollNext: element.scrollLeft < maxScrollLeft - EDGE_TOLERANCE_PX,
  };
}

export function useScrollEdges(
  ref: RefObject<HTMLElement | null>,
  itemCount: number
): ScrollEdges {
  const [edges, setEdges] = useState<ScrollEdges>({
    canScrollPrev: false,
    canScrollNext: false,
  });

  useEffect(() => {
    const element = ref.current;
    if (element == null) return;
    const update = () =>
      setEdges((current) => {
        const next = readEdges(element);
        return next.canScrollPrev === current.canScrollPrev &&
          next.canScrollNext === current.canScrollNext
          ? current
          : next;
      });
    const observer = new ResizeObserver(update);
    observer.observe(element);
    Array.from(element.children).forEach((child) => observer.observe(child));
    element.addEventListener('scroll', update, { passive: true });
    return () => {
      observer.disconnect();
      element.removeEventListener('scroll', update);
    };
  }, [ref, itemCount]);

  return edges;
}
