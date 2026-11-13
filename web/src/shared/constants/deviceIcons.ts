import devicePhone from '@/assets/icons/chat/ic_device_type_phone.png';
import devicePc from '@/assets/icons/chat/ic_device_type_pc.png';
import deviceApple from '@/assets/icons/chat/ic_device_type_apple.png';
import deviceAndroid from '@/assets/icons/chat/ic_device_type_android.png';
import deviceWinphone from '@/assets/icons/chat/ic_device_type_winphone.png';
import type { DeviceType } from '@ola/shared/types';

export const DEVICE_ICONS: Record<DeviceType, string> = {
  phone: devicePhone,
  pc: devicePc,
  apple: deviceApple,
  android: deviceAndroid,
  winphone: deviceWinphone,
};
