import { parseVipTypeId, vipIconUrl } from '@ola/shared/lib/vip';
import type { PlayerInfo } from '../../src/sdk';
import { VIP_DEFAULT_ICON } from '../assets';

export function avatarIconSrc(vipType?: string | null): string {
  const id = parseVipTypeId(vipType);
  return id != null ? vipIconUrl(id) : VIP_DEFAULT_ICON;
}

export function opponentOf(players: readonly PlayerInfo[], you: number): PlayerInfo | null {
  if (players.length !== 2 || (you !== 0 && you !== 1)) return null;
  return players[1 - you] ?? null;
}
