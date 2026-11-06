const COVER_SELECTOR = '[data-megaphone-cover]';

function isShown(element: Element): boolean {
  return element.getClientRects().length > 0 && getComputedStyle(element).visibility !== 'hidden';
}

export function isMegaphoneCovered(): boolean {
  if (document.visibilityState === 'hidden') return true;
  return Array.from(document.querySelectorAll(COVER_SELECTOR)).some(isShown);
}
