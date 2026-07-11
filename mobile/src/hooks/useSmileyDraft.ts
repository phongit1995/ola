import { useCallback, useRef, useState, type SetStateAction } from 'react';
import type { NativeSyntheticEvent, TextInputSelectionChangeEventData } from 'react-native';
import { splitSmileys } from '../lib/chatSmiley';

interface DraftSelection {
  start: number;
  end: number;
}

export function useSmileyDraft(initialDraft = '') {
  const [draft, setDraftState] = useState(initialDraft);
  const [pendingSelection, setPendingSelection] = useState<DraftSelection | null>(null);
  const draftRef = useRef(initialDraft);
  const selectionRef = useRef<DraftSelection>({
    start: initialDraft.length,
    end: initialDraft.length,
  });

  const setDraft = useCallback((action: SetStateAction<string>) => {
    const next = typeof action === 'function' ? action(draftRef.current) : action;
    draftRef.current = next;
    setDraftState(next);
  }, []);

  const applyDraft = useCallback(
    (next: string, caret: number) => {
      selectionRef.current = { start: caret, end: caret };
      setDraft(next);
      setPendingSelection({ start: caret, end: caret });
    },
    [setDraft]
  );

  const clampedSelection = useCallback((): DraftSelection => {
    const length = draftRef.current.length;
    const start = Math.max(0, Math.min(selectionRef.current.start, length));
    const end = Math.max(start, Math.min(selectionRef.current.end, length));
    return { start, end };
  }, []);

  const insertAtCursor = useCallback(
    (text: string) => {
      const value = draftRef.current;
      const { start, end } = clampedSelection();
      applyDraft(value.slice(0, start) + text + value.slice(end), start + text.length);
    },
    [applyDraft, clampedSelection]
  );

  const backspaceAtCursor = useCallback(() => {
    const value = draftRef.current;
    const { start, end } = clampedSelection();
    if (start === end) {
      if (start === 0) return;
      const segments = splitSmileys(value.slice(0, start));
      const last = segments[segments.length - 1];
      const removeLength = last != null && last.kind === 'image' ? last.code.length : 1;
      applyDraft(value.slice(0, start - removeLength) + value.slice(end), start - removeLength);
    } else {
      applyDraft(value.slice(0, start) + value.slice(end), start);
    }
  }, [applyDraft, clampedSelection]);

  const handleSelectionChange = useCallback(
    (event: NativeSyntheticEvent<TextInputSelectionChangeEventData>) => {
      selectionRef.current = event.nativeEvent.selection;
      setPendingSelection((current) => (current != null ? null : current));
    },
    []
  );

  return {
    draft,
    setDraft,
    applyDraft,
    insertAtCursor,
    backspaceAtCursor,
    selection: pendingSelection ?? undefined,
    handleSelectionChange,
  };
}
