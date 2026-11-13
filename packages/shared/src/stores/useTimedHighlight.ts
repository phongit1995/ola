import { useCallback, useEffect, useRef, useState } from 'react';

const DEFAULT_HIGHLIGHT_MS = 1500;

export function useTimedHighlight(durationMs = DEFAULT_HIGHLIGHT_MS) {
  const [highlightedId, setHighlightedId] = useState<string | null>(null);
  const timerRef = useRef<ReturnType<typeof setTimeout> | null>(null);

  useEffect(() => {
    return () => {
      if (timerRef.current != null) clearTimeout(timerRef.current);
    };
  }, []);

  const highlight = useCallback(
    (id: string) => {
      setHighlightedId(id);
      if (timerRef.current != null) clearTimeout(timerRef.current);
      timerRef.current = setTimeout(() => setHighlightedId(null), durationMs);
    },
    [durationMs]
  );

  const clearHighlight = useCallback(() => setHighlightedId(null), []);

  return { highlightedId, highlight, clearHighlight };
}
