import {
  useCallback,
  useLayoutEffect,
  useRef,
  type Dispatch,
  type RefObject,
  type SetStateAction,
} from 'react';

export function useCaretInsert(
  ref: RefObject<HTMLInputElement | HTMLTextAreaElement | null>,
  value: string,
  setValue: Dispatch<SetStateAction<string>>
) {
  const caretRef = useRef<number | null>(null);

  useLayoutEffect(() => {
    const caret = caretRef.current;
    if (caret == null) return;
    caretRef.current = null;
    const el = ref.current;
    if (el == null) return;
    el.focus();
    el.setSelectionRange(caret, caret);
  }, [value, ref]);

  return useCallback(
    (token: string) => {
      const el = ref.current;
      const at = el?.selectionStart ?? value.length;
      caretRef.current = at + token.length;
      setValue((current) => current.slice(0, at) + token + current.slice(at));
    },
    [ref, value, setValue]
  );
}
