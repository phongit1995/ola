import { vipIconUrl } from '@ola/shared/lib/vip';
import type { BotLevel } from './logic/battle';

export { avatarIconUrl, DEFAULT_AVATAR_URL } from '../src/sdk/avatar';

// Ba cấp đầu giữ đúng bảng của Caro; SIÊU KHÓ dùng gương mặt kế tiếp để dễ nhận diện.
const BOT_VIP_ID: Record<BotLevel, number> = {
  easy: 1,
  normal: 2,
  hard: 3,
  expert: 4,
};

export function botAvatarIconUrl(level: BotLevel): string {
  return vipIconUrl(BOT_VIP_ID[level]);
}
