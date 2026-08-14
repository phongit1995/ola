import { parseVipTypeId, vipIconUrl } from '@ola/shared/lib/vip';

export const DEFAULT_AVATAR_URL = '/ola_smiley_online.png';

export function avatarIconUrl(vipType?: string | null): string {
  const id = parseVipTypeId(vipType);
  return id == null ? DEFAULT_AVATAR_URL : vipIconUrl(id);
}
