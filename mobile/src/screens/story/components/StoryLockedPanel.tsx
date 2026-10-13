import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, View } from 'react-native';
import { useThemeColors } from '@hooks/useThemeColors';
import type { ReaderPalette } from '../interface';
import { useStoryTextSize } from '../typography';

const vipCrownIcon = require('@assets/icons/apps/vip-crown.webp');

const PANEL_MAX_WIDTH = 448;
const BUTTON_MAX_WIDTH = 320;
const BUTTON_MIN_HEIGHT = 44;
const CROWN_SIZE = 64;

interface StoryLockedPanelProps {
  chapterTitle: string;
  freeLimit: number;
  palette: ReaderPalette;
  onBuyVip: () => void;
  onComment: () => void;
}

export function StoryLockedPanel({
  chapterTitle,
  freeLimit,
  palette,
  onBuyVip,
  onComment,
}: StoryLockedPanelProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const textSize = useStoryTextSize();
  return (
    <View
      className="w-full items-center self-center px-6 pb-12 pt-10"
      style={{ maxWidth: PANEL_MAX_WIDTH }}
    >
      <Text className="text-center" style={[textSize(14, 20), { color: palette.muted }]}>
        {chapterTitle}
      </Text>
      <Image
        source={vipCrownIcon}
        style={{ width: CROWN_SIZE, height: CROWN_SIZE, marginTop: 24 }}
        resizeMode="contain"
      />
      <Text
        className="mt-4 text-center font-bold"
        style={[textSize(18, 25), { color: palette.text }]}
      >
        {t('story.lockedTitle')}
      </Text>
      <Text className="mt-2 text-center" style={[textSize(14, 24), { color: palette.muted }]}>
        {t('story.lockedMessage', { count: freeLimit })}
      </Text>
      <Pressable
        accessibilityRole="button"
        onPress={onBuyVip}
        className="mt-6 w-full items-center justify-center rounded-full bg-ola-button px-4 py-2 active:opacity-90"
        style={{ maxWidth: BUTTON_MAX_WIDTH, minHeight: BUTTON_MIN_HEIGHT }}
      >
        <Text
          className="text-center font-semibold"
          style={[textSize(14, 20), { color: colors.onPrimary }]}
        >
          {t('story.lockedVip')}
        </Text>
      </Pressable>
      <Pressable
        accessibilityRole="button"
        onPress={onComment}
        className="mt-3 w-full items-center justify-center rounded-full px-4 py-2"
        style={{
          maxWidth: BUTTON_MAX_WIDTH,
          minHeight: BUTTON_MIN_HEIGHT,
          borderWidth: 1,
          borderColor: colors.primary,
        }}
      >
        <Text className="text-center" style={[textSize(14, 20), { color: colors.primaryInk }]}>
          {t('story.lockedComment')}
        </Text>
      </Pressable>
    </View>
  );
}
