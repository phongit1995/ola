import { describe, expect, it } from 'vitest';
import { avatarTone, DEFAULT_AVATAR_ICON, userAvatarIconUrl } from './avatar';

describe('Thirteen user avatar icon', () => {
  it.each([null, undefined, '', '0', '999'])('uses the Ola fallback for %s', (vipType) => {
    expect(userAvatarIconUrl(vipType)).toBe(DEFAULT_AVATAR_ICON);
  });

  it('uses the selected VIP icon', () => {
    expect(userAvatarIconUrl('3')).toBe('/vip-icons/vip_003.png');
  });

  it('keeps avatar tones deterministic', () => {
    expect(avatarTone('lananh')).toBe(avatarTone('lananh'));
    expect(['coral', 'violet', 'sun', 'blue']).toContain(avatarTone('quocbao'));
  });
});
