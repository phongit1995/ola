import type { TFunction } from 'i18next';
import {
  DAILY_CHECKIN_BOX,
  DAILY_CHECKIN_ERROR,
  DAILY_CHECKIN_REWARD_PRIORITY,
  DAILY_CHECKIN_REWARD_TYPE,
  DAILY_CHECKIN_SLOT_STATUS,
  DAILY_CHECKIN_TASK_NAME_KEY,
  DAILY_CHECKIN_TASK_TARGET,
} from '../constants/dailyCheckin';
import { HTTP_STATUS } from '../constants/http';
import type {
  DailyCheckinReward,
  DailyCheckinSlot,
  DailyCheckinStatus,
  DailyCheckinTaskCode,
} from '../types/api/dailyCheckin.type';
import type { GiftCodeReward } from '../types/api/giftCode.type';
import type {
  DailyCheckinFabKind,
  DailyCheckinRestInfo,
  DailyCheckinTaskTarget,
  DailyCheckinTodayKind,
} from '../types/client/dailyCheckin.type';
import { toApiError } from './apiError';
import { giftCodeRewardText } from './giftCode';
import { formatKen } from './number';

export function dailyCheckinTodaySlot(status: DailyCheckinStatus): DailyCheckinSlot | undefined {
  return status.slot > 0 ? status.slots[status.slot - 1] : undefined;
}

export function dailyCheckinTodayKind(status: DailyCheckinStatus): DailyCheckinTodayKind {
  if (!status.checkedInToday) {
    if (status.completed) return 'completed';
    return 'checkin';
  }
  const today = dailyCheckinTodaySlot(status);
  if (today?.status === DAILY_CHECKIN_SLOT_STATUS.pending) {
    return status.canOpen || status.todayTask?.done ? 'open' : 'task';
  }
  if (status.completed) return 'completed';
  return today?.status === DAILY_CHECKIN_SLOT_STATUS.claimed ? 'opened' : 'noGift';
}

export function dailyCheckinFabKind(status: DailyCheckinStatus | null): DailyCheckinFabKind | null {
  if (status == null || !status.enabled) return null;
  const kind = dailyCheckinTodayKind(status);
  return kind === 'checkin' || kind === 'task' || kind === 'open' ? kind : null;
}

export function dailyCheckinNeedsAttention(status: DailyCheckinStatus | null): boolean {
  if (status == null || !status.enabled) return false;
  const kind = dailyCheckinTodayKind(status);
  return kind === 'checkin' || kind === 'task' || kind === 'open';
}

export function dailyCheckinRestInfo(status: DailyCheckinStatus): DailyCheckinRestInfo | null {
  if (status.completed) return null;
  const spare = status.reachable - status.slotCount;
  if (spare > 0) return { kind: 'rest', days: spare };
  if (spare === 0) return { kind: 'lastRest', slot: status.slotCount };
  return { kind: 'unreachable', slot: status.slotCount };
}

export function dailyCheckinRestText(t: TFunction, info: DailyCheckinRestInfo): string {
  if (info.kind === 'rest') return t('dailyCheckin.rest.days', { count: info.days });
  if (info.kind === 'lastRest') return t('dailyCheckin.rest.last', { slot: info.slot });
  return t('dailyCheckin.rest.unreachable', { slot: info.slot });
}

export function dailyCheckinNextGiftSlot(status: DailyCheckinStatus): number | null {
  const next = status.slots.find(
    (slot) =>
      slot.slot > status.slot &&
      slot.box !== DAILY_CHECKIN_BOX.none &&
      slot.status !== DAILY_CHECKIN_SLOT_STATUS.outOfReach
  );
  return next?.slot ?? null;
}

export function dailyCheckinMonthNumber(status: DailyCheckinStatus): number {
  return Number(status.month?.slice(5, 7) ?? 0);
}

export function dailyCheckinNextMonthLabel(status: DailyCheckinStatus): string {
  const month = dailyCheckinMonthNumber(status);
  const next = month >= 12 ? 1 : month + 1;
  return `01/${String(next).padStart(2, '0')}`;
}

export function dailyCheckinDayLabel(day: string): string {
  const [, month, date] = day.split('-');
  return `${date}/${month}`;
}

export function dailyCheckinBestReward(items: DailyCheckinReward[] | undefined): DailyCheckinReward | undefined {
  if (items == null || items.length === 0) return undefined;
  const rank = (item: DailyCheckinReward) => {
    const index = DAILY_CHECKIN_REWARD_PRIORITY.indexOf(item.type as (typeof DAILY_CHECKIN_REWARD_PRIORITY)[number]);
    return index < 0 ? DAILY_CHECKIN_REWARD_PRIORITY.length : index;
  };
  return [...items].sort((a, b) => rank(a) - rank(b))[0];
}

export function dailyCheckinRewardText(t: TFunction, reward: DailyCheckinReward): string {
  if (reward.type === DAILY_CHECKIN_REWARD_TYPE.ken) {
    return t('dailyCheckin.rewardKen', { amount: formatKen(reward.amount ?? 0) });
  }
  return giftCodeRewardText(t, reward as GiftCodeReward) ?? '';
}

export function dailyCheckinRewardCaption(t: TFunction, reward: DailyCheckinReward): string {
  switch (reward.type) {
    case DAILY_CHECKIN_REWARD_TYPE.ken:
      return formatKen(reward.amount ?? 0);
    case DAILY_CHECKIN_REWARD_TYPE.vipDays:
      return t('dailyCheckin.caption.vipDays', { count: reward.days ?? 0 });
    case DAILY_CHECKIN_REWARD_TYPE.megaphoneTicket:
      return t('dailyCheckin.caption.count', { count: reward.count ?? 0 });
    default:
      return (reward.expiresInDays ?? 0) > 0
        ? t('dailyCheckin.caption.days', { count: reward.expiresInDays ?? 0 })
        : t('dailyCheckin.caption.permanent');
  }
}

export function dailyCheckinRewardLocked(reward: DailyCheckinReward): boolean {
  return reward.type === DAILY_CHECKIN_REWARD_TYPE.vipIcon || reward.type === DAILY_CHECKIN_REWARD_TYPE.avatarFrame;
}

export function dailyCheckinTaskTarget(code: string | undefined): DailyCheckinTaskTarget | null {
  if (code == null) return null;
  return DAILY_CHECKIN_TASK_TARGET[code as DailyCheckinTaskCode] ?? null;
}

export function dailyCheckinTaskName(t: TFunction, code: string | undefined): string {
  const key = code != null ? DAILY_CHECKIN_TASK_NAME_KEY[code as DailyCheckinTaskCode] : undefined;
  return key != null ? t(key) : t('dailyCheckin.tasks.unknown');
}

export function dailyCheckinRowSubtitle(t: TFunction, status: DailyCheckinStatus): string {
  const kind = dailyCheckinTodayKind(status);
  if (kind === 'task' || kind === 'open') return t('dailyCheckin.row.pendingBox');
  if (kind === 'checkin') return t('dailyCheckin.row.notCheckedIn');
  if (kind === 'completed') return t('dailyCheckin.row.completed', { month: dailyCheckinMonthNumber(status) });
  return t('dailyCheckin.row.checkedIn');
}

export function dailyCheckinSlotHint(t: TFunction, slot: DailyCheckinSlot): string {
  switch (slot.status) {
    case DAILY_CHECKIN_SLOT_STATUS.missed:
      return t('dailyCheckin.slot.missed');
    case DAILY_CHECKIN_SLOT_STATUS.outOfReach:
      return t('dailyCheckin.slot.outOfReach');
    case DAILY_CHECKIN_SLOT_STATUS.pending:
      return t('dailyCheckin.slot.pending');
    case DAILY_CHECKIN_SLOT_STATUS.none:
      return t('dailyCheckin.slot.plainDone');
    case DAILY_CHECKIN_SLOT_STATUS.claimed:
      return t('dailyCheckin.slot.claimed');
    default:
      return slot.box === DAILY_CHECKIN_BOX.none ? t('dailyCheckin.slot.plain') : t('dailyCheckin.slot.secretHint');
  }
}

export function dailyCheckinRemainingMs(status: DailyCheckinStatus, nowMs: number): number {
  return Math.max(0, Date.parse(status.endsAt) - nowMs);
}

export function formatDailyCheckinCountdown(ms: number): string {
  const totalSeconds = Math.floor(ms / 1000);
  const hours = Math.floor(totalSeconds / 3600);
  const minutes = Math.floor((totalSeconds % 3600) / 60);
  const seconds = totalSeconds % 60;
  return [hours, minutes, seconds].map((part) => String(part).padStart(2, '0')).join(':');
}

export function dailyCheckinErrorText(t: TFunction, error: unknown): string {
  const apiError = toApiError(error);
  switch (apiError.code) {
    case DAILY_CHECKIN_ERROR.disabled:
      return t('dailyCheckin.errors.disabled');
    case DAILY_CHECKIN_ERROR.completed:
      return t('dailyCheckin.errors.completed');
    case DAILY_CHECKIN_ERROR.emailNotVerified:
      return t('dailyCheckin.errors.emailNotVerified');
    case DAILY_CHECKIN_ERROR.taskNotDone:
      return t('dailyCheckin.errors.taskNotDone');
    case DAILY_CHECKIN_ERROR.vipRequired:
      return t('dailyCheckin.vipDialog.title');
    case DAILY_CHECKIN_ERROR.nothingToOpen:
      return t('dailyCheckin.errors.nothingToOpen');
    default:
      if (apiError.status === HTTP_STATUS.tooManyRequests) return t('dailyCheckin.errors.rateLimited');
      return t('dailyCheckin.errors.failed');
  }
}
