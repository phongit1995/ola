import { useEffect, type RefObject } from 'react';

export function useOutsideClick<T extends HTMLElement>(
  ref: RefObject<T | null>,
  active: boolean,
  onOutside: () => void
) {
  useEffect(() => {
    if (!active) return;
    function handlePointerDown(event: PointerEvent) {
      const element = ref.current;
      if (element != null && !element.contains(event.target as Node))
        onOutside();
    }
    document.addEventListener('pointerdown', handlePointerDown);
    return () => document.removeEventListener('pointerdown', handlePointerDown);
  }, [active, ref, onOutside]);
}
