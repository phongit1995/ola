import { Image, View } from 'react-native';
import { VIP_ICONS } from '@lib/vipImages';

interface VipIconImageProps {
  typeId: number;
  size?: number;
  rounded?: boolean;
}

export function VipIconImage({ typeId, size = 40, rounded = false }: VipIconImageProps) {
  const source =
    typeId >= 1 && typeId <= VIP_ICONS.length ? VIP_ICONS[typeId - 1] : null;
  const borderRadius = rounded ? 4 : 0;
  if (source == null) {
    return (
      <View
        style={{ width: size, height: size, borderRadius, backgroundColor: 'rgba(0,0,0,0.12)' }}
      />
    );
  }
  return (
    <Image source={source} style={{ width: size, height: size, borderRadius }} resizeMode="contain" />
  );
}
