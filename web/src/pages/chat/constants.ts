import type { MessageStatus } from '@app-types';
import type { ChatMessageStatus, SuggestedFriend } from './types';

export const STATUS_MAP: Record<MessageStatus, ChatMessageStatus> = {
  sending: 'sending',
  uploading: 'sending',
  sent: 'sent',
  failed: 'failed',
};

export const SWIPE_TRIGGER = 56;

export const SWIPE_MAX = 88;

export const MAX_BALLOONS = 12;

export const KEN_TRANSFER_MIN = 1000;

export const KEN_TRANSFER_MAX = 10_000_000;

export const SUGGESTED_FRIENDS: SuggestedFriend[] = [
  { name: 'anhthu', color: '#ec407a' },
  { name: 'baolong', color: '#26a69a' },
  { name: 'cammy', color: '#7e57c2' },
  { name: 'dunghoang', color: '#42a5f5' },
  { name: 'giangpham', color: '#ef5350' },
  { name: 'hannguyen', color: '#ab47bc' },
  { name: 'khoile', color: '#26c6da' },
  { name: 'linhdan', color: '#ffa726' },
  { name: 'minhquan', color: '#66bb6a' },
  { name: 'ngocbich', color: '#ec407a' },
  { name: 'phuongvy', color: '#5c6bc0' },
  { name: 'tuanvu', color: '#8d6e63' },
];
