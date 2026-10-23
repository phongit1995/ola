export function formatKen(value: number): string {
  return value.toLocaleString('vi-VN');
}

export function formatMoney(value: number): string {
  return `${Math.abs(value).toLocaleString('vi-VN')} tr`;
}

export function formatDelta(value: number): string {
  return `${value < 0 ? '−' : '+'}${formatMoney(value)}`;
}

export function formatClock(ms: number): string {
  const total = Math.max(0, Math.ceil(ms / 1000));
  const minutes = Math.floor(total / 60);
  const seconds = total % 60;
  return `${minutes}:${String(seconds).padStart(2, '0')}`;
}

export function formatHistoryTime(playedAt: number): string {
  const date = new Date(playedAt);
  const now = new Date();
  const sameDay = date.toDateString() === now.toDateString();
  const time = date.toLocaleTimeString('vi-VN', { hour: '2-digit', minute: '2-digit' });
  if (sameDay) return time;
  return `${String(date.getDate()).padStart(2, '0')}/${String(date.getMonth() + 1).padStart(2, '0')} ${time}`;
}
