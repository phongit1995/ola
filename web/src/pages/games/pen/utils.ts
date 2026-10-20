import type { CSSProperties } from 'react';

export function bgImage(url: string): CSSProperties {
  return { backgroundSize: '100% 100%', backgroundImage: `url(${url})` };
}
