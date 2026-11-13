import { useCallback, useEffect, useRef, useState, type RefObject } from 'react';
import { toast } from '@lib';

const MESSAGE_HIGHLIGHT_MS = 1500;

interface UseMessageHighlightOptions {
  scrollRef: RefObject<HTMLElement | null>;
  notFoundText: string;
  onBeforeScroll?: () => void;
}

export function useMessageHighlight({
  scrollRef,
  notFoundText,
  onBeforeScroll,
}: UseMessageHighlightOptions) {
  const [highlightedId, setHighlightedId] = useState<string | null>(null);
  const timerRef = useRef<ReturnType<typeof setTimeout> | null>(null);

  useEffect(() => {
    return () => {
      if (timerRef.current != null) clearTimeout(timerRef.current);
    };
  }, []);

  const scrollToMessage = useCallback(
    (id: string) => {
      const element = scrollRef.current?.querySelector(
        `[data-message-id="${CSS.escape(id)}"]`
      );
      if (element == null) {
        toast.error(notFoundText);
        return;
      }
      onBeforeScroll?.();
      element.scrollIntoView({ behavior: 'smooth', block: 'center' });
      setHighlightedId(id);
      if (timerRef.current != null) clearTimeout(timerRef.current);
      timerRef.current = setTimeout(
        () => setHighlightedId(null),
        MESSAGE_HIGHLIGHT_MS
      );
    },
    [scrollRef, notFoundText, onBeforeScroll]
  );

  const clearHighlight = useCallback(() => setHighlightedId(null), []);

  return { highlightedId, scrollToMessage, clearHighlight };
}
