import type { MessageStatus } from '@app-types';
import type { ChatMessageStatus } from './types';

export const STATUS_MAP: Record<MessageStatus, ChatMessageStatus> = {
  sending: 'sending',
  uploading: 'sending',
  sent: 'sent',
  failed: 'failed',
};

export const SWIPE_TRIGGER = 56;

export const SWIPE_MAX = 88;

export const MIN_SOURCE_WIDTH = 100;

export const MAX_BALLOONS = 12;

export const KEN_TRANSFER_MIN = 1000;

export const KEN_TRANSFER_MAX = 10_000_000;
