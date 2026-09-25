/**
 * Golden Island's countdown, read from the shipped format strings: two units at a time, biggest first —
 * `1d02h`, `2:05:09`, `05:09`. The farm clock counts one unit per real second at speed 1, so the remaining
 * units divided by the speed are the real seconds a player waits.
 */
const pad = (n: number): string => (n < 10 ? '0' : '') + n;

export function countdown(seconds: number): string {
  const total = Math.max(0, Math.ceil(Number.isFinite(seconds) ? seconds : 0));
  const days = Math.floor(total / 86400),
    hours = Math.floor(total / 3600) % 24;
  if (days > 0) return `${days}d${pad(hours)}h`;
  const minutes = Math.floor(total / 60) % 60,
    rest = total % 60;
  return hours > 0 ? `${hours}:${pad(minutes)}:${pad(rest)}` : `${pad(minutes)}:${pad(rest)}`;
}

export const remainingSeconds = (readyAt: number, now: number, speed = 1): number =>
  Math.max(0, readyAt - now) / (speed > 0 ? speed : 1);
