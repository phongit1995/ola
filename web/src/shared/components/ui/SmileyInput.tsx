import {
  forwardRef,
  useEffect,
  useImperativeHandle,
  useRef,
  type ClipboardEvent as ReactClipboardEvent,
  type KeyboardEvent as ReactKeyboardEvent,
} from 'react';
import { smileyImageForCode, splitSmileys } from '@lib';

export interface SmileyInputHandle {
  focus: () => void;
  insertCode: (code: string) => void;
  insertText: (text: string) => void;
  backspace: () => void;
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

const SMILEY_IMG_CLASS = 'inline-block h-[1.25em] w-auto align-text-bottom';

function makeSmileyImg(code: string, src: string): HTMLImageElement {
  const img = document.createElement('img');
  img.src = src;
  img.alt = code;
  img.dataset.code = code;
  img.className = SMILEY_IMG_CLASS;
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

  useEffect(() => {
    const el = editorRef.current;
    if (el == null || composing.current || value === lastEmitted.current) return;
    fillFromValue(el, value);
    lastEmitted.current = value;
  }, [value]);

  function emit() {
    const el = editorRef.current;
    if (el == null) return;
    const hasContent = el.textContent !== '' || el.querySelector('img') != null;
    if (!hasContent && el.childNodes.length > 0) el.replaceChildren();
    const next = hasContent ? serialize(el) : '';
    lastEmitted.current = next;
    onChange(next);
  }

  function insertNode(node: Node) {
    const el = editorRef.current;
    if (el == null) return;
    el.focus();
    const selection = window.getSelection();
    if (selection == null || selection.rangeCount === 0 || !el.contains(selection.anchorNode)) {
      el.appendChild(node);
    } else {
      const range = selection.getRangeAt(0);
      range.deleteContents();
      range.insertNode(node);
      range.setStartAfter(node);
      range.collapse(true);
      selection.removeAllRanges();
      selection.addRange(range);
    }
    emit();
  }

  useImperativeHandle(ref, () => ({
    focus: () => editorRef.current?.focus(),
    insertCode: (code: string) => {
      const src = smileyImageForCode(code);
      insertNode(src == null ? document.createTextNode(code) : makeSmileyImg(code, src));
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
      emit();
      el.focus();
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
