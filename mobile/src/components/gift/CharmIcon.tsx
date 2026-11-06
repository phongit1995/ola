import { Image, type ImageStyle, type StyleProp } from 'react-native';
import { GIFT_ASSETS } from './giftAssets';

interface CharmIconProps {
  size?: number;
  style?: StyleProp<ImageStyle>;
}

export function CharmIcon({ size = 16, style }: CharmIconProps) {
  return <Image source={GIFT_ASSETS.charm} style={[{ width: size, height: size }, style]} resizeMode="contain" />;
}
