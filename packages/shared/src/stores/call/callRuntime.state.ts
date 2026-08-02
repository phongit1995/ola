let ringTimer: ReturnType<typeof setTimeout> | null = null;

export function clearRingTimeout(): void {
  if (ringTimer == null) return;
  clearTimeout(ringTimer);
  ringTimer = null;
}

export function armRingTimeout(handler: () => void, delayMs: number): void {
  clearRingTimeout();
  ringTimer = setTimeout(() => {
    ringTimer = null;
    handler();
  }, delayMs);
}
