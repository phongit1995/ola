export function formatKen(value: number): string {
  return value.toLocaleString('en-US');
}

export function formatVnd(value: number): string {
  return value.toLocaleString('vi-VN');
}

export function formatVndCurrency(value: number): string {
  return `${formatVnd(value)}đ`;
}

export function formatOddsPercent(value: number | undefined): string | null {
  if (value == null || value < 0) return null;
  if (value === 0) return '0%';
  const rounded = Math.round(value * 100) / 100;
  const text = rounded < 0.01 ? '<0.01' : String(rounded);
  return `${text}%`;
}
