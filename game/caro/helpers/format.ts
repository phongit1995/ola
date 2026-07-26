export function formatClock(seconds: number): string {
  const safeSeconds = Number.isFinite(seconds) ? Math.max(0, Math.floor(seconds)) : 0;
  const minutes = Math.floor(safeSeconds / 60);
  const remainingSeconds = safeSeconds % 60;
  return `${String(minutes).padStart(2, '0')}:${String(remainingSeconds).padStart(2, '0')}`;
}

export function formatKen(value: number): string {
  const safeValue = Number.isFinite(value) ? Math.round(value) : 0;
  return safeValue.toLocaleString('vi-VN');
}

export function formatHistoryTime(epochMs: number): { time: string; date: string } {
  const value = new Date(epochMs);
  if (!Number.isFinite(epochMs) || Number.isNaN(value.getTime())) {
    return { time: '--:--', date: '--/--' };
  }
  const pad = (input: number): string => String(input).padStart(2, '0');
  return {
    time: `${pad(value.getHours())}:${pad(value.getMinutes())}`,
    date: `${pad(value.getDate())}/${pad(value.getMonth() + 1)}`,
  };
}
