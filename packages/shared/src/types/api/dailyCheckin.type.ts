import type { GiftCodeReward } from './giftCode.type';

export type DailyCheckinSlotStatus = 'claimed' | 'none' | 'missed' | 'pending' | 'today' | 'upcoming' | 'out_of_reach';

export type DailyCheckinBox = 'none' | 'normal' | 'big';

export type DailyCheckinRewardType = 'vip_days' | 'vip_icon' | 'avatar_frame' | 'megaphone_ticket' | 'ken';

export type DailyCheckinTaskCode =
  | 'me_post'
  | 'me_comment'
  | 'me_react'
  | 'moment_post'
  | 'moment_comment'
  | 'story_comment'
  | 'send_gift'
  | 'send_megaphone'
  | 'play_game';

export type DailyCheckinOpenReason = 'task_pending' | 'vip_required';

export interface DailyCheckinReward extends Omit<GiftCodeReward, 'type'> {
  type: DailyCheckinRewardType | (string & {});
  amount?: number;
}

export interface DailyCheckinSlot {
  slot: number;
  box: DailyCheckinBox;
  requireVip: boolean;
  status: DailyCheckinSlotStatus;
  items?: DailyCheckinReward[];
  checkedInOn?: string;
}

export interface DailyCheckinTask {
  code: DailyCheckinTaskCode | (string & {});
  done: boolean;
}

export interface DailyCheckinStatus {
  enabled: boolean;
  popup: boolean;
  needsEmailVerify: boolean;
  month?: string;
  slotCount: number;
  count: number;
  slot: number;
  completed: boolean;
  checkedInToday: boolean;
  reachable: number;
  canOpen: boolean;
  todayTask?: DailyCheckinTask;
  todayResult?: DailyCheckinReward[];
  endsAt: string;
  slots: DailyCheckinSlot[];
}

export interface DailyCheckinActionResult {
  status: DailyCheckinStatus;
  slot?: number;
  items?: DailyCheckinReward[];
  reason?: DailyCheckinOpenReason;
}

export interface DailyCheckinAppConfig {
  enabled: boolean;
}
