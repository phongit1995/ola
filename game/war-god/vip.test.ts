import { describe, expect, it } from 'vitest';
import { avatarIconUrl, botAvatarIconUrl, DEFAULT_AVATAR_URL } from './vip';

describe('War God avatar icon URL', () => {
  it.each([
    [null, DEFAULT_AVATAR_URL],
    ['', DEFAULT_AVATAR_URL],
    ['0', DEFAULT_AVATAR_URL],
    ['1', '/vip-icons/vip_001.png'],
    ['132', '/vip-icons/vip_132.png'],
    ['133', '/vip-icons/vip_133.png'],
    ['134', '/vip-icons/vip_134.png'],
    ['135', '/vip-icons/vip_135.png'],
    ['136', '/vip-icons/vip_136.png'],
    ['137', '/vip-icons/vip_137.png'],
    ['138', '/vip-icons/vip_138.png'],
    ['139', DEFAULT_AVATAR_URL],
    ['1.5', DEFAULT_AVATAR_URL],
  ])('maps %s consistently with the shared VIP catalog', (vipType, expected) => {
    expect(avatarIconUrl(vipType)).toBe(expected);
  });
});

describe('War God bot avatar icon URL', () => {
  it.each([
    ['easy', '/vip-icons/vip_001.png'],
    ['normal', '/vip-icons/vip_002.png'],
    ['hard', '/vip-icons/vip_003.png'],
    ['expert', '/vip-icons/vip_004.png'],
  ] as const)('gives %s a stable difficulty icon', (level, expected) => {
    expect(botAvatarIconUrl(level)).toBe(expected);
  });
});
