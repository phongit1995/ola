import type { ImageSourcePropType } from 'react-native';
import type { DeviceType } from '@ola/shared/types';

export const DEVICE_ICONS: Record<DeviceType, ImageSourcePropType> = {
  phone: require('@assets/icons/chat/ic_device_type_phone.png'),
  pc: require('@assets/icons/chat/ic_device_type_pc.png'),
  apple: require('@assets/icons/chat/ic_device_type_apple.png'),
  android: require('@assets/icons/chat/ic_device_type_android.png'),
  winphone: require('@assets/icons/chat/ic_device_type_winphone.png'),
};
