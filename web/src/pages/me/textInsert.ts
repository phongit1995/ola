export function insertAtCursor(
  current: string,
  token: string,
  el: HTMLTextAreaElement | null
): string {
  if (el == null) return current + token;
  const at = el.selectionStart ?? current.length;
  return current.slice(0, at) + token + current.slice(at);
}
