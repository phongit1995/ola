import type { ImageSourcePropType, ViewStyle } from 'react-native';
import {
  DAILY_CHECKIN_BOX,
  DAILY_CHECKIN_REWARD_TYPE,
  DAILY_CHECKIN_SLOT_STATUS,
} from '@ola/shared/constants';
import { avatarFrameById } from '@ola/shared/lib/avatarFrame';
import type { DailyCheckinBox, DailyCheckinReward, DailyCheckinSlot, ThemeColors } from '@ola/shared/types';
import { MEGAPHONE_TICKET_IMAGE } from '@components/megaphone/megaphoneAssets';
import { WARNING, WARNING_SOFT } from '@constants';
import { CHECKIN_GOLD_LINE, CHECKIN_GOLD_SOFT, CHECKIN_SURFACE, CHECKIN_SURFACE_DIM } from './constants';
import { DAILY_CHECKIN_IMAGES } from './dailyCheckinAssets';

export function rewardImageSource(reward: DailyCheckinReward): ImageSourcePropType {
  switch (reward.type) {
    case DAILY_CHECKIN_REWARD_TYPE.avatarFrame: {
      const url = avatarFrameById(reward.frameId)?.url;
      return url != null ? { uri: url } : DAILY_CHECKIN_IMAGES.box;
    }
    case DAILY_CHECKIN_REWARD_TYPE.megaphoneTicket:
      return MEGAPHONE_TICKET_IMAGE;
    case DAILY_CHECKIN_REWARD_TYPE.ken:
      return DAILY_CHECKIN_IMAGES.ken;
    default:
      return DAILY_CHECKIN_IMAGES.vipDays;
  }
}

export function boxImage(box: DailyCheckinBox, missed = false): ImageSourcePropType {
  if (missed) return DAILY_CHECKIN_IMAGES.boxMissed;
  return box === DAILY_CHECKIN_BOX.big ? DAILY_CHECKIN_IMAGES.boxBig : DAILY_CHECKIN_IMAGES.box;
}

export function openedBoxImage(box: DailyCheckinBox): ImageSourcePropType {
  return box === DAILY_CHECKIN_BOX.big ? DAILY_CHECKIN_IMAGES.boxBigOpened : DAILY_CHECKIN_IMAGES.boxOpened;
}

export function cellToneStyle(slot: DailyCheckinSlot, colors: ThemeColors): ViewStyle {
  switch (slot.status) {
    case DAILY_CHECKIN_SLOT_STATUS.claimed:
    case DAILY_CHECKIN_SLOT_STATUS.none:
      return { borderWidth: 1, borderColor: colors.button, backgroundColor: colors.primaryLight };
    case DAILY_CHECKIN_SLOT_STATUS.missed:
      return { borderWidth: 1, borderColor: 'rgba(0,0,0,0.1)', backgroundColor: CHECKIN_SURFACE };
    case DAILY_CHECKIN_SLOT_STATUS.pending:
      return { borderWidth: 2, borderStyle: 'dashed', borderColor: WARNING, backgroundColor: WARNING_SOFT };
    case DAILY_CHECKIN_SLOT_STATUS.today:
      return { borderWidth: 2, borderColor: colors.primary, backgroundColor: '#ffffff' };
    case DAILY_CHECKIN_SLOT_STATUS.outOfReach:
      return { borderWidth: 1, borderColor: 'rgba(0,0,0,0.05)', backgroundColor: CHECKIN_SURFACE_DIM };
    default:
      return slot.box === DAILY_CHECKIN_BOX.big
        ? { borderWidth: 1, borderColor: CHECKIN_GOLD_LINE, backgroundColor: CHECKIN_GOLD_SOFT }
        : { borderWidth: 1, borderColor: 'rgba(0,0,0,0.1)', backgroundColor: '#ffffff' };
  }
}
