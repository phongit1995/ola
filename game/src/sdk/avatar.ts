import { parseVipTypeId, vipIconUrl } from '@ola/shared/lib/vip';

// Ảnh được vite copy từ packages/shared/assets (xem game/vite.config.ts).
export const DEFAULT_AVATAR_URL = '/ola_smiley_online.png';

export function avatarIconUrl(vipType?: string | null): string {
  const id = parseVipTypeId(vipType);
  return id == null ? DEFAULT_AVATAR_URL : vipIconUrl(id);
}
