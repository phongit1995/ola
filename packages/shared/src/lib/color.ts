const HEX_RADIX = 16;

export function withAlpha(hex: string, alpha: number): string {
  const value = hex.replace('#', '');
  const red = parseInt(value.slice(0, 2), HEX_RADIX);
  const green = parseInt(value.slice(2, 4), HEX_RADIX);
  const blue = parseInt(value.slice(4, 6), HEX_RADIX);
  return `rgba(${red}, ${green}, ${blue}, ${alpha})`;
}
