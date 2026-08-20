import { parseVipTypeId, vipIconUrl } from '@ola/shared/lib/vip';

export const DEFAULT_AVATAR_ICON = '/ola_smiley_online.png';

export function userAvatarIconUrl(vipType?: string | null): string {
  const vipId = parseVipTypeId(vipType);
  return vipId == null ? DEFAULT_AVATAR_ICON : vipIconUrl(vipId);
}
