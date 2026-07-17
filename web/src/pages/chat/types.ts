import type { DeviceType } from '@constants';

export type { DeviceType };

export type ContactGroup = 'birthday' | 'new' | 'utility' | 'friend';

export type ChatMessageKind =
  | 'text'
  | 'sticker'
  | 'image'
  | 'voice'
  | 'location'
  | 'snap'
  | 'youtube'
  | 'ken'
  | 'vip'
  | 'stranger';

export type ChatMessageStatus = 'sending' | 'sent' | 'seen' | 'failed';
