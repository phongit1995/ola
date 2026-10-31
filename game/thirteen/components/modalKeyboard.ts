import type { KeyboardEvent } from 'react';

const TABBABLE_SELECTOR = 'button:not(:disabled), input:not(:disabled), [href], [tabindex]';

export function tabbableIn(container: HTMLElement): HTMLElement[] {
  return Array.from(container.querySelectorAll<HTMLElement>(TABBABLE_SELECTOR)).filter(
    (element) => element.tabIndex >= 0 && element.getClientRects().length > 0,
  );
}

export function handleModalKeyDown(event: KeyboardEvent<HTMLElement>, onClose: () => void) {
  if (event.key === 'Escape') {
    event.preventDefault();
    onClose();
    return;
  }

  if (event.key !== 'Tab') return;

  const focusable = tabbableIn(event.currentTarget);
  const first = focusable[0];
  const last = focusable[focusable.length - 1];
  if (!first || !last) {
    event.preventDefault();
    return;
  }

  const index = focusable.indexOf(document.activeElement as HTMLElement);
  if (index === -1) {
    event.preventDefault();
    (event.shiftKey ? last : first).focus();
  } else if (event.shiftKey && index === 0) {
    event.preventDefault();
    last.focus();
  } else if (!event.shiftKey && index === focusable.length - 1) {
    event.preventDefault();
    first.focus();
  }
}
