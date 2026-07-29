import devicePhone from '@/assets/icons/chat/ic_device_type_phone.png';
import devicePc from '@/assets/icons/chat/ic_device_type_pc.png';
import deviceApple from '@/assets/icons/chat/ic_device_type_apple.png';
import deviceAndroid from '@/assets/icons/chat/ic_device_type_android.png';
import deviceWinphone from '@/assets/icons/chat/ic_device_type_winphone.png';

export type DeviceType = 'phone' | 'pc' | 'apple' | 'android' | 'winphone';

export const DEVICE_TYPES: DeviceType[] = [
  'phone',
  'pc',
  'apple',
  'android',
  'winphone',
];

export const DEVICE_ALIASES: Record<string, DeviceType> = {
  ios: 'apple',
  android: 'android',
  web: 'pc',
};

export const DEVICE_ICONS: Record<DeviceType, string> = {
  phone: devicePhone,
  pc: devicePc,
  apple: deviceApple,
  android: deviceAndroid,
  winphone: deviceWinphone,
};

export function normalizeDevice(value?: string): DeviceType {
  if (value == null || value === '') return 'pc';
  if (DEVICE_TYPES.includes(value as DeviceType)) return value as DeviceType;
  return DEVICE_ALIASES[value] ?? 'pc';
}
