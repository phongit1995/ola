import { Image } from 'react-native';
import { VIP_ICONS } from '@lib/vipImages';

const defaultSmiley = require('@assets/icons/chat/ola_smiley_online.png');

interface VipAvatarProps {
  typeId?: number | null;
  size?: number;
}

export function VipAvatar({ typeId, size = 40 }: VipAvatarProps) {
  const source =
    typeId != null && typeId >= 1 && typeId <= VIP_ICONS.length
      ? VIP_ICONS[typeId - 1]
      : defaultSmiley;
  return <Image source={source} style={{ width: size, height: size }} resizeMode="contain" />;
}
