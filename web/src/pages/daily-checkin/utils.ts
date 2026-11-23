import {
  DAILY_CHECKIN_BOX,
  DAILY_CHECKIN_ICONS,
  DAILY_CHECKIN_REWARD_TYPE,
  DAILY_CHECKIN_SLOT_STATUS,
  MEGAPHONE_TICKET_ICON,
} from '@constants';
import { avatarFrameById } from '@ola/shared/lib/avatarFrame';
import type { DailyCheckinBox, DailyCheckinReward, DailyCheckinSlot } from '@app-types';

export function rewardImageSrc(reward: DailyCheckinReward): string {
  switch (reward.type) {
    case DAILY_CHECKIN_REWARD_TYPE.avatarFrame:
      return avatarFrameById(reward.frameId)?.url ?? DAILY_CHECKIN_ICONS.box;
    case DAILY_CHECKIN_REWARD_TYPE.megaphoneTicket:
      return MEGAPHONE_TICKET_ICON;
    case DAILY_CHECKIN_REWARD_TYPE.ken:
      return DAILY_CHECKIN_ICONS.ken;
    default:
      return DAILY_CHECKIN_ICONS.vipDays;
  }
}

export function boxImageSrc(box: DailyCheckinBox, missed = false): string {
  if (missed) return DAILY_CHECKIN_ICONS.boxMissed;
  return box === DAILY_CHECKIN_BOX.big ? DAILY_CHECKIN_ICONS.boxBig : DAILY_CHECKIN_ICONS.box;
}

export function openedBoxImageSrc(box: DailyCheckinBox): string {
  return box === DAILY_CHECKIN_BOX.big ? DAILY_CHECKIN_ICONS.boxBigOpened : DAILY_CHECKIN_ICONS.boxOpened;
}

export function cellToneClass(slot: DailyCheckinSlot): string {
  switch (slot.status) {
    case DAILY_CHECKIN_SLOT_STATUS.claimed:
    case DAILY_CHECKIN_SLOT_STATUS.none:
      return 'border-ola-primary/35 bg-ola-primary-light';
    case DAILY_CHECKIN_SLOT_STATUS.missed:
      return 'border-black/10 bg-ola-surface';
    case DAILY_CHECKIN_SLOT_STATUS.pending:
      return 'border-2 border-dashed border-ola-warning bg-ola-warning-soft';
    case DAILY_CHECKIN_SLOT_STATUS.today:
      return 'border-2 border-ola-primary bg-white animate-checkin-today';
    default:
      return slot.box === DAILY_CHECKIN_BOX.big
        ? 'border-ola-checkin-gold-line bg-ola-checkin-gold-soft'
        : 'border-black/10 bg-white';
  }
}
