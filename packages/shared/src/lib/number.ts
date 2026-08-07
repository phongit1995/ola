export function formatKen(value: number): string {
  return value.toLocaleString('en-US');
}

export function formatVnd(value: number): string {
  return value.toLocaleString('vi-VN');
}

export function formatVndCurrency(value: number): string {
  return `${formatVnd(value)}đ`;
}
