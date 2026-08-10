import type { CallType } from '../types/api/call.type';
import type { CallMode } from '../types/client/call.type';

export const CALL_TYPE = {
  audio: 'audio',
  video: 'video',
} as const satisfies Record<string, CallType>;

export const CALL_MODE = {
  idle: 'idle',
  incoming: 'incoming',
  outgoing: 'outgoing',
  active: 'active',
} as const satisfies Record<string, CallMode>;

export const CALL_RING_TIMEOUT_MS = 30_000;
export const CALL_RING_TIMEOUT_GRACE_MS = 5_000;

export const CALL_MINI_WIDTH = 120;
export const CALL_MINI_HEIGHT = 180;
export const CALL_MINI_EDGE_GAP = 12;
export const CALL_MINI_BOTTOM_GAP = 84;

export function ringFallbackMs(ringTimeoutSeconds?: number): number {
  const base =
    ringTimeoutSeconds != null && ringTimeoutSeconds > 0
      ? ringTimeoutSeconds * 1000
      : CALL_RING_TIMEOUT_MS;
  return base + CALL_RING_TIMEOUT_GRACE_MS;
}
