import { Image } from 'react-native';
import { VIP_ICONS } from '@lib/vipImages';

const smileyIcon = require('@assets/icons/chat/ola_smiley_online.png');

interface VipBadgeProps {
  typeId?: number | null;
  size?: number;
}

export function VipBadge({ typeId, size = 24 }: VipBadgeProps) {
  const source =
    typeId != null && typeId >= 1 && typeId <= VIP_ICONS.length
      ? VIP_ICONS[typeId - 1]
      : smileyIcon;
  return <Image source={source} style={{ width: size, height: size }} resizeMode="contain" />;
}
