export const chatTypingTimers = new Map<
  string,
  ReturnType<typeof setTimeout>
>();

export const chatMarkReadTimers = new Map<
  string,
  { timer: ReturnType<typeof setTimeout>; firstAt: number }
>();

let lastTypingSentAt = 0;

export function resetLastTypingSentAt(): void {
  lastTypingSentAt = 0;
}

export function claimTypingSend(now: number, throttleMs: number): boolean {
  if (now - lastTypingSentAt < throttleMs) return false;
  lastTypingSentAt = now;
  return true;
}
