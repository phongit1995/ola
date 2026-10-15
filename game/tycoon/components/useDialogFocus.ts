import { useEffect, useRef, type RefObject } from 'react';

const FOCUSABLE_SELECTOR = [
  'button:not(:disabled)',
  'input:not(:disabled)',
  'select:not(:disabled)',
  'textarea:not(:disabled)',
  'a[href]',
  '[tabindex]:not([tabindex="-1"])',
].join(',');

interface DialogFocusOptions {
  enabled?: boolean;
  initialFocusDelayMs?: number;
  onEscape?: () => void;
}

const dialogStack: HTMLElement[] = [];

function syncDialogVisibility() {
  const top = dialogStack.at(-1);
  for (const dialog of dialogStack) {
    if (dialog === top) dialog.removeAttribute('aria-hidden');
    else dialog.setAttribute('aria-hidden', 'true');
  }
}

function focusableElements(scope: HTMLElement): HTMLElement[] {
  return Array.from(scope.querySelectorAll<HTMLElement>(FOCUSABLE_SELECTOR)).filter(
    (element) => !element.hidden && element.getAttribute('aria-hidden') !== 'true',
  );
}

/** Keeps keyboard focus inside the active overlay and restores its trigger on close. */
export function useDialogFocus<T extends HTMLElement>({
  enabled = true,
  initialFocusDelayMs = 0,
  onEscape,
}: DialogFocusOptions = {}): RefObject<T | null> {
  const scopeRef = useRef<T>(null);
  const escapeRef = useRef(onEscape);

  useEffect(() => {
    escapeRef.current = onEscape;
  }, [onEscape]);

  useEffect(() => {
    if (!enabled) return;
    const scope = scopeRef.current;
    if (!scope) return;
    const previousFocus = document.activeElement instanceof HTMLElement ? document.activeElement : null;
    dialogStack.push(scope);

    const focusInitial = () => {
      if (dialogStack.at(-1) !== scope) return;
      const preferred = scope.querySelector<HTMLElement>('[data-dialog-initial-focus]:not(:disabled)');
      (preferred ?? focusableElements(scope)[0] ?? scope).focus();
    };

    focusInitial();
    syncDialogVisibility();
    const delayedFocus = initialFocusDelayMs > 0 ? window.setTimeout(focusInitial, initialFocusDelayMs) : 0;

    const onKeyDown = (event: KeyboardEvent) => {
      if (dialogStack.at(-1) !== scope) return;
      if (event.key === 'Escape' && escapeRef.current) {
        event.preventDefault();
        event.stopImmediatePropagation();
        escapeRef.current();
        return;
      }
      if (event.key !== 'Tab') return;
      const focusable = focusableElements(scope);
      const first = focusable[0];
      const last = focusable.at(-1);
      if (!first || !last) {
        event.preventDefault();
        scope.focus();
        return;
      }
      if (!scope.contains(document.activeElement)) {
        event.preventDefault();
        (event.shiftKey ? last : first).focus();
      } else if (event.shiftKey && document.activeElement === first) {
        event.preventDefault();
        last.focus();
      } else if (!event.shiftKey && document.activeElement === last) {
        event.preventDefault();
        first.focus();
      }
    };

    document.addEventListener('keydown', onKeyDown, true);
    return () => {
      document.removeEventListener('keydown', onKeyDown, true);
      if (delayedFocus) window.clearTimeout(delayedFocus);
      const wasTop = dialogStack.at(-1) === scope;
      const stackIndex = dialogStack.lastIndexOf(scope);
      if (stackIndex >= 0) dialogStack.splice(stackIndex, 1);
      scope.removeAttribute('aria-hidden');
      syncDialogVisibility();
      if (!wasTop) return;
      const nextTop = dialogStack.at(-1);
      if (nextTop && (!previousFocus?.isConnected || !nextTop.contains(previousFocus))) {
        (focusableElements(nextTop)[0] ?? nextTop).focus();
      } else if (previousFocus?.isConnected) {
        previousFocus.focus();
      }
    };
  }, [enabled, initialFocusDelayMs]);

  return scopeRef;
}
