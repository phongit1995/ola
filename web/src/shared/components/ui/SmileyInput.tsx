import {
  forwardRef,
  useEffect,
  useImperativeHandle,
  useRef,
  type ClipboardEvent as ReactClipboardEvent,
  type KeyboardEvent as ReactKeyboardEvent,
} from 'react';
import { isEmojiToken, smileyImageForCode, smileyImgClass, splitSmileys, type SmileyVariant } from '@lib';

export interface SmileyInputHandle {
  focus: () => void;
  insertCode: (code: string, trailingSpace?: boolean, focusAfter?: boolean) => void;
  insertText: (text: string) => void;
  backspace: () => void;
  reset: () => void;
}

interface SmileyInputProps {
  value: string;
  onChange: (value: string) => void;
  onEnter?: () => void;
  onFocus?: () => void;
  placeholder?: string;
  disabled?: boolean;
  multiline?: boolean;
  className?: string;
}

function variantForCode(code: string): SmileyVariant {
  return isEmojiToken(code) ? 'emoji' : 'smiley';
}

function makeSmileyImg(code: string, src: string): HTMLImageElement {
  const img = document.createElement('img');
  img.src = src;
  img.alt = code;
  img.dataset.code = code;
  img.className = smileyImgClass(variantForCode(code));
  img.contentEditable = 'false';
  return img;
}

function fillFromValue(root: HTMLElement, value: string) {
  root.replaceChildren();
  for (const segment of splitSmileys(value)) {
    if (segment.kind === 'image') {
      root.appendChild(makeSmileyImg(segment.code, segment.src));
    } else if (segment.value !== '') {
      root.appendChild(document.createTextNode(segment.value));
    }
  }
}

function serialize(root: HTMLElement): string {
  let out = '';
  root.childNodes.forEach((node) => {
    if (node.nodeType === Node.TEXT_NODE) {
      out += node.textContent ?? '';
    } else if (node instanceof HTMLImageElement) {
      out += node.dataset.code ?? '';
    } else if (node instanceof HTMLBRElement) {
      out += '\n';
    } else if (node instanceof HTMLElement) {
      out += serialize(node);
    }
  });
  return out;
}

export const SmileyInput = forwardRef<SmileyInputHandle, SmileyInputProps>(function SmileyInput(
  { value, onChange, onEnter, onFocus, placeholder, disabled = false, multiline = false, className = '' },
  ref
) {
  const editorRef = useRef<HTMLDivElement>(null);
  const lastEmitted = useRef<string | null>(null);
  const composing = useRef(false);
  const savedRange = useRef<Range | null>(null);

  useEffect(() => {
    const el = editorRef.current;
    if (el == null || value === lastEmitted.current) return;
    if (composing.current && value !== '') return;
    composing.current = false;
    fillFromValue(el, value);
    lastEmitted.current = value;
  }, [value]);

  useEffect(() => {
    function rememberSelection() {
      const el = editorRef.current;
      const selection = window.getSelection();
      if (el == null || selection == null || selection.rangeCount === 0) return;
      const range = selection.getRangeAt(0);
      if (el.contains(range.commonAncestorContainer)) savedRange.current = range.cloneRange();
    }
    document.addEventListener('selectionchange', rememberSelection);
    return () => document.removeEventListener('selectionchange', rememberSelection);
  }, []);

  function emit() {
    const el = editorRef.current;
    if (el == null) return;
    const hasContent = el.textContent !== '' || el.querySelector('img') != null;
    if (!hasContent && el.childNodes.length > 0) el.replaceChildren();
    const next = hasContent ? serialize(el) : '';
    lastEmitted.current = next;
    onChange(next);
  }

  function rangeAtEnd(el: HTMLElement): Range {
    const range = document.createRange();
    range.selectNodeContents(el);
    range.collapse(false);
    return range;
  }

  function caretRange(el: HTMLElement): Range | null {
    const selection = window.getSelection();
    if (selection != null && selection.rangeCount > 0 && el.contains(selection.anchorNode)) {
      return selection.getRangeAt(0);
    }
    const saved = savedRange.current;
    if (saved != null && el.contains(saved.commonAncestorContainer)) return saved;
    return null;
  }

  function insertNode(node: Node) {
    const el = editorRef.current;
    if (el == null) return;
    const range = caretRange(el) ?? rangeAtEnd(el);
    try {
      range.deleteContents();
      range.insertNode(node);
      range.setStartAfter(node);
      range.collapse(true);
    } catch {
      el.appendChild(node);
      savedRange.current = rangeAtEnd(el);
      emit();
      return;
    }
    savedRange.current = range.cloneRange();
    const selection = window.getSelection();
    if (selection != null && el.ownerDocument.activeElement === el) {
      selection.removeAllRanges();
      selection.addRange(range);
    }
    emit();
  }

  function focusEditor() {
    const el = editorRef.current;
    if (el == null) return;
    el.focus();
    const saved = savedRange.current;
    const range = saved != null && el.contains(saved.commonAncestorContainer) ? saved : rangeAtEnd(el);
    savedRange.current = range;
    const selection = window.getSelection();
    selection?.removeAllRanges();
    selection?.addRange(range);
  }

  useImperativeHandle(ref, () => ({
    focus: focusEditor,
    insertCode: (code: string, trailingSpace = false, focusAfter = true) => {
      const src = smileyImageForCode(code);
      insertNode(src == null ? document.createTextNode(code) : makeSmileyImg(code, src));
      if (trailingSpace) insertNode(document.createTextNode(' '));
      if (focusAfter) focusEditor();
    },
    insertText: (text: string) => insertNode(document.createTextNode(text)),
    backspace: () => {
      const el = editorRef.current;
      if (el == null) return;
      const last = el.lastChild;
      if (last == null) return;
      if (last.nodeType === Node.TEXT_NODE) {
        const text = last.textContent ?? '';
        const trimmed = Array.from(text).slice(0, -1).join('');
        if (trimmed === '') el.removeChild(last);
        else last.textContent = trimmed;
      } else {
        el.removeChild(last);
      }
      savedRange.current = rangeAtEnd(el);
      emit();
    },
    reset: () => {
      const el = editorRef.current;
      if (el == null) return;
      const wasComposing = composing.current;
      composing.current = false;
      fillFromValue(el, '');
      lastEmitted.current = '';
      savedRange.current = null;
      if (wasComposing && el.ownerDocument.activeElement === el) {
        el.blur();
        el.focus();
        savedRange.current = rangeAtEnd(el);
      }
    },
  }));

  function onKeyDown(event: ReactKeyboardEvent<HTMLDivElement>) {
    if (event.key !== 'Enter' || event.nativeEvent.isComposing) return;
    if (onEnter != null && !event.shiftKey) {
      event.preventDefault();
      onEnter();
      return;
    }
    if (multiline) {
      event.preventDefault();
      insertNode(document.createTextNode('\n'));
    } else {
      event.preventDefault();
    }
  }

  function onPaste(event: ReactClipboardEvent<HTMLDivElement>) {
    event.preventDefault();
    const text = event.clipboardData.getData('text/plain');
    if (text !== '') insertNode(document.createTextNode(text));
  }

  return (
    <div
      ref={editorRef}
      role="textbox"
      aria-multiline={multiline}
      contentEditable={!disabled}
      suppressContentEditableWarning
      data-placeholder={placeholder}
      onInput={emit}
      onFocus={onFocus}
      onKeyDown={onKeyDown}
      onPaste={onPaste}
      onCompositionStart={() => {
        composing.current = true;
      }}
      onCompositionEnd={() => {
        composing.current = false;
        emit();
      }}
      className={`smiley-input break-words whitespace-pre-wrap outline-none ${className}`}
    />
  );
});
