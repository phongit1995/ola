import { useCallback, type RefObject } from 'react';
import { toast } from '@lib';
import { useTimedHighlight } from '@ola/shared/stores/useTimedHighlight';

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
  const { highlightedId, highlight, clearHighlight } = useTimedHighlight();

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
      highlight(id);
    },
    [scrollRef, notFoundText, onBeforeScroll, highlight]
  );

  return { highlightedId, scrollToMessage, clearHighlight };
}
