import type { MatchFoundData, UserInfoData } from '../../../src/sdk';
import { BOT_LEVEL_TITLES, type BotLevel } from '../../logic/battle';

export interface VsIntroCombatant {
  name: string;
  vipType?: string | null;
  level?: number | null;
}

export interface VsIntroData {
  left: VsIntroCombatant;
  right: VsIntroCombatant;
}

const BOT_VIP_TYPE: Record<BotLevel, string> = {
  easy: '1',
  normal: '2',
  hard: '3',
  expert: '4',
};

export function buildBotVsIntroData(user: UserInfoData | null, level: BotLevel): VsIntroData {
  return {
    left: {
      name: `Máy - ${BOT_LEVEL_TITLES[level]}`,
      vipType: BOT_VIP_TYPE[level],
    },
    right: {
      name: user?.username ?? 'bạn',
      vipType: user?.vipType ?? null,
      level: user?.level ?? null,
    },
  };
}

export function buildPvpVsIntroData(
  data: MatchFoundData<unknown>,
  user: UserInfoData | null
): VsIntroData {
  const me = data.players[data.you];
  const foe = data.players[1 - data.you];
  return {
    left: {
      name: foe?.name ?? 'đối thủ',
      vipType: foe?.vipType ?? null,
      level: foe?.level ?? null,
    },
    right: {
      name: me?.name ?? user?.username ?? 'bạn',
      vipType: me?.vipType === undefined ? user?.vipType ?? null : me.vipType,
      level: me?.level ?? user?.level ?? null,
    },
  };
}
