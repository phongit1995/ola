import { Image } from 'react-native';
import { VIP_ICONS } from '../lib/vipImages';

interface VipBadgeProps {
  typeId?: number | null;
  size?: number;
}

export function VipBadge({ typeId, size = 16 }: VipBadgeProps) {
  const source =
    typeId != null && typeId >= 1 && typeId <= VIP_ICONS.length ? VIP_ICONS[typeId - 1] : null;
  if (source == null) return null;
  return <Image source={source} style={{ width: size, height: size }} resizeMode="contain" />;
}
