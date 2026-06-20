import type { MessageStatus } from '@app-types';
import devicePhone from '@/assets/icons/chat/ic_device_type_phone.png';
import devicePc from '@/assets/icons/chat/ic_device_type_pc.png';
import deviceApple from '@/assets/icons/chat/ic_device_type_apple.png';
import deviceAndroid from '@/assets/icons/chat/ic_device_type_android.png';
import deviceWinphone from '@/assets/icons/chat/ic_device_type_winphone.png';
import type { ChatMessageStatus, DeviceType } from './types';

export const DEVICE_TYPES: DeviceType[] = ['phone', 'pc', 'apple', 'android', 'winphone'];

export const STATUS_MAP: Record<MessageStatus, ChatMessageStatus> = {
  sending: 'sending',
  uploading: 'sending',
  sent: 'sent',
  failed: 'failed',
};

export const DEVICE_ICONS: Record<DeviceType, string> = {
  phone: devicePhone,
  pc: devicePc,
  apple: deviceApple,
  android: deviceAndroid,
  winphone: deviceWinphone,
};

export const SWIPE_TRIGGER = 56;

export const SWIPE_MAX = 88;

export const MIN_SOURCE_WIDTH = 100;
