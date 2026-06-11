const PALETTE = [
  '#ef5350',
  '#ec407a',
  '#5c6bc0',
  '#26a69a',
  '#7e57c2',
  '#ffa726',
  '#42a5f5',
  '#66bb6a',
];

export function colorForName(name: string): string {
  let hash = 0;
  for (let index = 0; index < name.length; index += 1) {
    hash = (hash * 31 + name.charCodeAt(index)) | 0;
  }
  return PALETTE[Math.abs(hash) % PALETTE.length];
}
