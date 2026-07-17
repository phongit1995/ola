import type { ImageSourcePropType } from 'react-native';

export type DeviceType = 'phone' | 'pc' | 'apple' | 'android' | 'winphone';

const DEVICE_TYPES: DeviceType[] = ['phone', 'pc', 'apple', 'android', 'winphone'];

const DEVICE_ALIASES: Record<string, DeviceType> = {
  ios: 'apple',
  android: 'android',
  web: 'pc',
};

export const DEVICE_ICONS: Record<DeviceType, ImageSourcePropType> = {
  phone: require('@assets/icons/chat/ic_device_type_phone.png'),
  pc: require('@assets/icons/chat/ic_device_type_pc.png'),
  apple: require('@assets/icons/chat/ic_device_type_apple.png'),
  android: require('@assets/icons/chat/ic_device_type_android.png'),
  winphone: require('@assets/icons/chat/ic_device_type_winphone.png'),
};

export function normalizeDevice(value?: string): DeviceType {
  if (value == null || value === '') return 'pc';
  if (DEVICE_TYPES.includes(value as DeviceType)) return value as DeviceType;
  return DEVICE_ALIASES[value] ?? 'pc';
}
