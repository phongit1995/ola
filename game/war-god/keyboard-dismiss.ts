const NON_KEYBOARD_INPUT_TYPES = new Set([
  'button',
  'checkbox',
  'color',
  'file',
  'hidden',
  'image',
  'radio',
  'range',
  'reset',
  'submit',
]);

interface ElementLike {
  tagName?: unknown;
  type?: unknown;
  isContentEditable?: unknown;
  blur?: unknown;
}

export function isKeyboardEditor(value: unknown): value is HTMLElement {
  if (value == null || typeof value !== 'object') return false;
  const element = value as ElementLike;
  const tagName = typeof element.tagName === 'string' ? element.tagName.toUpperCase() : '';
  if (tagName === 'TEXTAREA' || element.isContentEditable === true) {
    return typeof element.blur === 'function';
  }
  if (tagName !== 'INPUT' || typeof element.blur !== 'function') return false;
  const type = typeof element.type === 'string' ? element.type.toLowerCase() : 'text';
  return !NON_KEYBOARD_INPUT_TYPES.has(type);
}

export function shouldDismissKeyboard(active: unknown, pressedPath: readonly unknown[]): boolean {
  return isKeyboardEditor(active) && !pressedPath.some(isKeyboardEditor);
}

export function installKeyboardDismiss(doc: Document = document): () => void {
  const win = doc.defaultView;
  const dismiss = (pressedPath: readonly EventTarget[] = []): void => {
    const active = doc.activeElement;
    if (isKeyboardEditor(active) && shouldDismissKeyboard(active, pressedPath)) active.blur();
  };
  const onOutsidePress = (event: Event): void => dismiss(event.composedPath());
  const pressEvent = win && 'PointerEvent' in win ? 'pointerdown' : 'touchstart';
  const onWindowBlur = (): void => dismiss();

  doc.addEventListener(pressEvent, onOutsidePress, true);
  win?.addEventListener('blur', onWindowBlur);

  return () => {
    doc.removeEventListener(pressEvent, onOutsidePress, true);
    win?.removeEventListener('blur', onWindowBlur);
  };
}
