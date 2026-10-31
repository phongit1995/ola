import { describe, expect, it } from 'vitest';
import { atName, NAME_COLORS, nameColor } from './name';

describe('Thirteen player names', () => {
  it('prefixes a username with @ once', () => {
    expect(atName('lananh')).toBe('@lananh');
    expect(atName('@lananh')).toBe('@lananh');
  });

  it('keeps the same color for the same name', () => {
    expect(nameColor('hoangminh')).toBe(nameColor('hoangminh'));
    expect(NAME_COLORS).toContain(nameColor('quocbao'));
  });
});
