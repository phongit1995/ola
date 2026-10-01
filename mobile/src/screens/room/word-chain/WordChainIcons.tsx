import { useTranslation } from 'react-i18next';
import { Image, type ImageSourcePropType } from 'react-native';
import Svg, { Circle, Path } from 'react-native-svg';
import type { WordChainMoveStatus } from '@ola/shared/types';
import { WORD_CHAIN_STATUS_ICONS } from './wordChainAssets';

export function WordChainImage({
  source,
  size,
}: {
  source: ImageSourcePropType;
  size: number;
}) {
  return (
    <Image
      source={source}
      style={{ width: size, height: size }}
      resizeMode="contain"
      accessibilityElementsHidden
      importantForAccessibility="no"
    />
  );
}

export function WordChainStatusIcon({
  status,
  size = 28,
  decorative = false,
}: {
  status: WordChainMoveStatus;
  size?: number;
  decorative?: boolean;
}) {
  const { t } = useTranslation();
  const icon = WORD_CHAIN_STATUS_ICONS[status];
  return (
    <Image
      source={icon.source}
      style={{ width: size, height: size }}
      resizeMode="contain"
      accessibilityLabel={decorative ? undefined : t(icon.label)}
      accessibilityElementsHidden={decorative}
      importantForAccessibility={decorative ? 'no' : 'auto'}
    />
  );
}

export function InfoIcon({ size = 20, color }: { size?: number; color: string }) {
  return (
    <Svg
      width={size}
      height={size}
      viewBox="0 0 24 24"
      fill="none"
      stroke={color}
      strokeWidth={2}
      strokeLinecap="round"
      strokeLinejoin="round"
    >
      <Circle cx="12" cy="12" r="10" />
      <Path d="M12 11v5.5M12 7.5h.01" />
    </Svg>
  );
}
