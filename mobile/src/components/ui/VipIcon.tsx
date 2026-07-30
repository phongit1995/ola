import { Image, View } from 'react-native';
import { VIP_ICONS } from '@lib/vipImages';

const fallbackIcon = require('@assets/icons/chat/ola_smiley_online.png');

export interface VipIconProps {
  typeId?: number | null;
  size: number;
  rounded?: boolean;
  fallback?: 'smiley' | 'placeholder';
}

export function VipIcon({
  typeId,
  size,
  rounded = false,
  fallback = 'smiley',
}: VipIconProps) {
  const source =
    typeId != null && typeId >= 1 && typeId <= VIP_ICONS.length
      ? VIP_ICONS[typeId - 1]
      : fallback === 'smiley'
        ? fallbackIcon
        : null;
  const borderRadius = rounded ? 4 : 0;

  if (source == null) {
    return (
      <View
        style={{
          width: size,
          height: size,
          borderRadius,
          backgroundColor: 'rgba(0,0,0,0.12)',
        }}
      />
    );
  }

  return (
    <Image
      source={source}
      style={{ width: size, height: size, borderRadius }}
      resizeMode="contain"
    />
  );
}
