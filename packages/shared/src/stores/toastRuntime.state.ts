let counter = 0;
let lastMessage = '';
let lastAt = 0;

export function nextToastId(): number {
  counter += 1;
  return counter;
}

export function isRecentDuplicateToast(
  message: string,
  now: number,
  throttleMs: number
): boolean {
  if (message === lastMessage && now - lastAt < throttleMs) return true;
  lastMessage = message;
  lastAt = now;
  return false;
}
