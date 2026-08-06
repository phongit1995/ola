export const CALL_RING_TIMEOUT_MS = 30_000;
export const CALL_RING_TIMEOUT_GRACE_MS = 5_000;

export const CALL_MINI_WIDTH = 176;
export const CALL_MINI_HEIGHT = 116;
export const CALL_MINI_EDGE_GAP = 12;
export const CALL_MINI_BOTTOM_GAP = 84;

export function ringFallbackMs(ringTimeoutSeconds?: number): number {
  const base =
    ringTimeoutSeconds != null && ringTimeoutSeconds > 0
      ? ringTimeoutSeconds * 1000
      : CALL_RING_TIMEOUT_MS;
  return base + CALL_RING_TIMEOUT_GRACE_MS;
}
