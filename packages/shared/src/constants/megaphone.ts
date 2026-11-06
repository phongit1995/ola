import type { MegaphoneConfig, MegaphoneType } from '../types/api/megaphone.type';
import type { MegaphoneErrorKey } from '../types/lib.type';

export const MEGAPHONE_HISTORY_PAGE_SIZE = 20;

export const MEGAPHONE_TYPE = {
  message: 'message',
  gift: 'gift',
} as const satisfies Record<string, MegaphoneType>;

export const DEFAULT_MEGAPHONE_CONFIG: MegaphoneConfig = {
  enabled: true,
  kenPrice: 5000,
  maxLength: 80,
  displaySeconds: 12,
  liveMinutes: 30,
  cooldownSeconds: 60,
  dailyLimit: 20,
  todayCount: 0,
  cooldownRemaining: 0,
  queueWaitSeconds: 0,
};

export const MEGAPHONE_ERROR_KEYS: Record<string, MegaphoneErrorKey> = {
  MEGAPHONE_DISABLED: 'megaphone.errors.disabled',
  MEGAPHONE_CONTENT_EMPTY: 'megaphone.errors.empty',
  MEGAPHONE_CONTENT_TOO_LONG: 'megaphone.errors.tooLong',
  MEGAPHONE_LINK_NOT_ALLOWED: 'megaphone.errors.link',
  MEGAPHONE_CONTENT_BLOCKED: 'megaphone.errors.blocked',
  MEGAPHONE_COOLDOWN: 'megaphone.errors.cooldown',
  MEGAPHONE_DAILY_LIMIT: 'megaphone.errors.dailyLimit',
  MEGAPHONE_QUEUE_FULL: 'megaphone.errors.queueFull',
  MEGAPHONE_INSUFFICIENT_KEN: 'megaphone.errors.insufficientKen',
  MEGAPHONE_REQUEST_CONFLICT: 'megaphone.errors.failed',
  RATE_LIMITED: 'megaphone.errors.rateLimited',
};
