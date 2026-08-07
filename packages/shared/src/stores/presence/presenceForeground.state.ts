const webDocument = (
  globalThis as { document?: { visibilityState?: string } }
).document;

let foregroundCheck: () => boolean = () =>
  webDocument == null || webDocument.visibilityState === 'visible';

export function configurePresenceForegroundCheck(check: () => boolean): void {
  foregroundCheck = check;
}

export function isPresenceForeground(): boolean {
  return foregroundCheck();
}
