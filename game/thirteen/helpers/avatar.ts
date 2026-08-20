import { parseVipTypeId, vipIconUrl } from '@ola/shared/lib/vip';

export const DEFAULT_AVATAR_ICON = '/ola_smiley_online.png';
export const AVATAR_TONES = ['coral', 'violet', 'sun', 'blue'] as const;

export type AvatarTone = (typeof AVATAR_TONES)[number];

export function avatarTone(value: string): AvatarTone {
  const hash = Array.from(value).reduce((total, character) => total + (character.codePointAt(0) ?? 0), 0);
  return AVATAR_TONES[hash % AVATAR_TONES.length] ?? 'violet';
}

export function userAvatarIconUrl(vipType?: string | null): string {
  const vipId = parseVipTypeId(vipType);
  return vipId == null ? DEFAULT_AVATAR_ICON : vipIconUrl(vipId);
}
