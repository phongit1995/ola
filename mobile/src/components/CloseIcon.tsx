import { Image } from 'react-native';

const closeIcon = require('../assets/icons/ic_close.png');

export function CloseIcon({ size = 22, color = '#ffffff' }: { size?: number; color?: string }) {
  return (
    <Image
      source={closeIcon}
      style={{ width: size, height: size, tintColor: color }}
      resizeMode="contain"
    />
  );
}
