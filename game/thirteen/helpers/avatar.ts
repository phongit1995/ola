export { avatarIconUrl as userAvatarIconUrl, DEFAULT_AVATAR_URL as DEFAULT_AVATAR_ICON } from '../../src/sdk/avatar';

export const AVATAR_TONES = ['coral', 'violet', 'sun', 'blue'] as const;

export type AvatarTone = (typeof AVATAR_TONES)[number];

export function avatarTone(value: string): AvatarTone {
  const hash = Array.from(value).reduce((total, character) => total + (character.codePointAt(0) ?? 0), 0);
  return AVATAR_TONES[hash % AVATAR_TONES.length] ?? 'violet';
}
