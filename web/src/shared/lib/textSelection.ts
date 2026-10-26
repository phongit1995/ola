import type { ClipboardEvent, PointerEvent } from 'react';

const SELECTABLE_TEXT_SELECTOR = '[data-selectable-text]';

export function shouldStartMessageLongPress(event: PointerEvent): boolean {
  if (event.button !== 0) return false;
  if (event.pointerType !== 'mouse') return true;
  return !(
    event.target instanceof Element &&
    event.target.closest(SELECTABLE_TEXT_SELECTOR) != null
  );
}

function activeSelectionRange(): Range | null {
  const selection = window.getSelection();
  if (selection == null || selection.isCollapsed || selection.rangeCount === 0)
    return null;
  return selection.getRangeAt(0);
}

export function hasTextSelectionIn(element: Element): boolean {
  return activeSelectionRange()?.intersectsNode(element) ?? false;
}

export function copySelectionWithSmileyCodes(
  event: ClipboardEvent<HTMLElement>
) {
  const range = activeSelectionRange();
  if (
    range == null ||
    !event.currentTarget.contains(range.commonAncestorContainer)
  )
    return;
  const fragment = range.cloneContents();
  fragment.querySelectorAll('img[alt]').forEach((image) => {
    image.replaceWith(image.getAttribute('alt') ?? '');
  });
  event.clipboardData.setData('text/plain', fragment.textContent ?? '');
  event.preventDefault();
}
