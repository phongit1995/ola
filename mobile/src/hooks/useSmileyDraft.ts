import { useCallback, useMemo, useRef, useState, type SetStateAction } from 'react';
import type { NativeSyntheticEvent, TextInputSelectionChangeEventData } from 'react-native';
import {
  SMILEY_PLACEHOLDER,
  countSmileyPlaceholders,
  parseSmileyDraft,
  serializeSmileyDraft,
  splitSmileys,
  type SmileyDraftValue,
} from '../lib/chatSmiley';

interface DraftSelection {
  start: number;
  end: number;
}

function isLowSurrogate(code: number): boolean {
  return code >= 0xdc00 && code <= 0xdfff;
}

function isHighSurrogate(code: number): boolean {
  return code >= 0xd800 && code <= 0xdbff;
}

export function useSmileyDraft(initialDraft = '') {
  const [value, setValueState] = useState<SmileyDraftValue>(() => parseSmileyDraft(initialDraft));
  const [pendingSelection, setPendingSelection] = useState<DraftSelection | null>(null);
  const valueRef = useRef(value);
  const selectionRef = useRef<DraftSelection>({
    start: value.display.length,
    end: value.display.length,
  });

  const commit = useCallback((next: SmileyDraftValue) => {
    valueRef.current = next;
    setValueState(next);
  }, []);

  const applyValue = useCallback(
    (next: SmileyDraftValue, caret: number) => {
      selectionRef.current = { start: caret, end: caret };
      commit(next);
      setPendingSelection({ start: caret, end: caret });
    },
    [commit]
  );

  const applyDraft = useCallback(
    (real: string) => {
      const next = parseSmileyDraft(real);
      applyValue(next, next.display.length);
    },
    [applyValue]
  );

  const setDraft = useCallback(
    (action: SetStateAction<string>) => {
      const current = serializeSmileyDraft(valueRef.current);
      const real = typeof action === 'function' ? action(current) : action;
      if (real === current) return;
      commit(parseSmileyDraft(real));
    },
    [commit]
  );

  const handleChangeText = useCallback(
    (nextDisplay: string) => {
      const prev = valueRef.current;
      const oldDisplay = prev.display;
      if (nextDisplay === oldDisplay) return;
      let prefix = 0;
      const maxPrefix = Math.min(oldDisplay.length, nextDisplay.length);
      while (prefix < maxPrefix && oldDisplay[prefix] === nextDisplay[prefix]) prefix++;
      let suffix = 0;
      const maxSuffix = maxPrefix - prefix;
      while (
        suffix < maxSuffix &&
        oldDisplay[oldDisplay.length - 1 - suffix] === nextDisplay[nextDisplay.length - 1 - suffix]
      ) {
        suffix++;
      }
      let start = prefix;
      const removedLength = oldDisplay.length - prefix - suffix;
      const insertedRaw = nextDisplay.slice(prefix, nextDisplay.length - suffix);
      if (removedLength > 0 && insertedRaw === '') {
        const cursor = selectionRef.current;
        const biased = cursor.start === cursor.end ? cursor.end - removedLength : cursor.start;
        if (
          biased >= 0 &&
          biased + removedLength <= oldDisplay.length &&
          oldDisplay.slice(0, biased) + oldDisplay.slice(biased + removedLength) === nextDisplay
        ) {
          start = biased;
        }
      }
      const before = countSmileyPlaceholders(oldDisplay.slice(0, start));
      const removedCodes = countSmileyPlaceholders(oldDisplay.slice(start, start + removedLength));
      const codes =
        removedCodes === 0
          ? prev.codes
          : [...prev.codes.slice(0, before), ...prev.codes.slice(before + removedCodes)];
      const inserted = insertedRaw.split(SMILEY_PLACEHOLDER).join(' ');
      const display =
        inserted === insertedRaw
          ? nextDisplay
          : oldDisplay.slice(0, start) + inserted + oldDisplay.slice(start + removedLength);
      commit({ display, codes });
    },
    [commit]
  );

  const clampedSelection = useCallback((): DraftSelection => {
    const length = valueRef.current.display.length;
    const start = Math.max(0, Math.min(selectionRef.current.start, length));
    const end = Math.max(start, Math.min(selectionRef.current.end, length));
    return { start, end };
  }, []);

  const removeRange = useCallback(
    (from: number, to: number) => {
      const prev = valueRef.current;
      const before = countSmileyPlaceholders(prev.display.slice(0, from));
      const removedCodes = countSmileyPlaceholders(prev.display.slice(from, to));
      const codes =
        removedCodes === 0
          ? prev.codes
          : [...prev.codes.slice(0, before), ...prev.codes.slice(before + removedCodes)];
      applyValue({ display: prev.display.slice(0, from) + prev.display.slice(to), codes }, from);
    },
    [applyValue]
  );

  const insertAtCursor = useCallback(
    (text: string) => {
      const prev = valueRef.current;
      const insert = parseSmileyDraft(text);
      const { start, end } = clampedSelection();
      const before = countSmileyPlaceholders(prev.display.slice(0, start));
      const removedCodes = countSmileyPlaceholders(prev.display.slice(start, end));
      const codes = [
        ...prev.codes.slice(0, before),
        ...insert.codes,
        ...prev.codes.slice(before + removedCodes),
      ];
      const display = prev.display.slice(0, start) + insert.display + prev.display.slice(end);
      applyValue({ display, codes }, start + insert.display.length);
    },
    [applyValue, clampedSelection]
  );

  const backspaceAtCursor = useCallback(() => {
    const { start, end } = clampedSelection();
    if (start !== end) {
      removeRange(start, end);
      return;
    }
    if (start === 0) return;
    const beforeCursor = valueRef.current.display.slice(0, start);
    let removeLength = 1;
    if (!beforeCursor.endsWith(SMILEY_PLACEHOLDER)) {
      const segments = splitSmileys(beforeCursor);
      const last = segments[segments.length - 1];
      if (last != null && last.kind === 'image') {
        removeLength = last.code.length;
      } else if (
        start > 1 &&
        isLowSurrogate(beforeCursor.charCodeAt(start - 1)) &&
        isHighSurrogate(beforeCursor.charCodeAt(start - 2))
      ) {
        removeLength = 2;
      }
    }
    removeRange(start - removeLength, start);
  }, [clampedSelection, removeRange]);

  const handleSelectionChange = useCallback(
    (event: NativeSyntheticEvent<TextInputSelectionChangeEventData>) => {
      selectionRef.current = event.nativeEvent.selection;
      setPendingSelection((current) => (current != null ? null : current));
    },
    []
  );

  const draft = useMemo(() => serializeSmileyDraft(value), [value]);

  return {
    draft,
    inputValue: value.display,
    codes: value.codes,
    setDraft,
    applyDraft,
    handleChangeText,
    insertAtCursor,
    backspaceAtCursor,
    selection: pendingSelection ?? undefined,
    handleSelectionChange,
  };
}
