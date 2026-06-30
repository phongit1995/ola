import type { CSSProperties } from 'react';

export const stretchBg: CSSProperties = { backgroundSize: '100% 100%' };

export function bgImage(url: string): CSSProperties {
  return { backgroundSize: '100% 100%', backgroundImage: `url(${url})` };
}
