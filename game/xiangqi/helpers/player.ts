import { vipIconUrl } from '@ola/shared/lib/vip';
import type { BotDifficulty } from '../logic/bot';

export { avatarIconUrl } from '../../src/sdk/avatar';

// Cùng bảng mặt máy với Caro/War God để người chơi quen mắt.
const BOT_VIP_ID: Record<BotDifficulty, number> = {
  easy: 1,
  medium: 2,
  hard: 3,
};

export function botAvatarIconUrl(difficulty: BotDifficulty): string {
  return vipIconUrl(BOT_VIP_ID[difficulty]);
}
