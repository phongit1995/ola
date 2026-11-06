import type { ReactNode } from 'react';
import { Text, View } from 'react-native';
import { withAlpha } from '@ola/shared/lib';
import { WARNING } from '@constants';
import { GIFT_ACCENT, GIFT_ACCENT_DARK } from './constants';

const PILL_TONE = {
  charm: { background: withAlpha(GIFT_ACCENT, 0.1), color: GIFT_ACCENT_DARK },
  ken: { background: withAlpha(WARNING, 0.12), color: WARNING },
};

interface GiftPillProps {
  tone: keyof typeof PILL_TONE;
  text: string;
  leading?: ReactNode;
  trailing?: ReactNode;
}

export function GiftPill({ tone, text, leading, trailing }: GiftPillProps) {
  const { background, color } = PILL_TONE[tone];
  return (
    <View
      className="flex-row items-center rounded-full px-2 py-0.5"
      style={{ gap: 4, backgroundColor: background, alignSelf: 'flex-start', maxWidth: '100%' }}
    >
      {leading}
      <Text numberOfLines={1} className="flex-shrink text-xs font-semibold" style={{ color }}>
        {text}
      </Text>
      {trailing}
    </View>
  );
}
