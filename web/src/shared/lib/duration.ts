export function formatDuration(seconds?: number): string {
  const total = Math.max(0, Math.round(seconds ?? 0));
  const minutes = Math.floor(total / 60);
  return `${minutes}:${String(total % 60).padStart(2, '0')}`;
}

export function formatDurationMs(ms: number): string {
  return formatDuration(Math.floor(ms / 1000));
}
