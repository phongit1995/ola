import { parseVipTypeId, vipIconUrl } from '@ola/shared/lib/vip';
import type { BotLevel } from './logic/battle';

export const DEFAULT_AVATAR_URL = '/ola_smiley_online.png';

// Ba cấp đầu giữ đúng bảng của Caro; SIÊU KHÓ dùng gương mặt kế tiếp để dễ nhận diện.
const BOT_VIP_ID: Record<BotLevel, number> = {
  easy: 1,
  normal: 2,
  hard: 3,
  expert: 4,
};

export function avatarIconUrl(vipType?: string | null): string {
  const id = parseVipTypeId(vipType);
  return id == null ? DEFAULT_AVATAR_URL : vipIconUrl(id);
}

export function botAvatarIconUrl(level: BotLevel): string {
  return vipIconUrl(BOT_VIP_ID[level]);
}
