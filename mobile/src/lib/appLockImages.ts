import type { ImageSourcePropType } from 'react-native';
import { isFaceBiometry, type BiometryType } from './appLock';

export const APP_LOCK_ICONS = {
  lock: require('@assets/icons/applock/lock.png') as ImageSourcePropType,
  backspace: require('@assets/icons/applock/backspace.png') as ImageSourcePropType,
  face: require('@assets/icons/applock/face.png') as ImageSourcePropType,
  fingerprint: require('@assets/icons/applock/fingerprint.png') as ImageSourcePropType,
};

export function biometryIcon(type: BiometryType): ImageSourcePropType {
  return isFaceBiometry(type) ? APP_LOCK_ICONS.face : APP_LOCK_ICONS.fingerprint;
}
