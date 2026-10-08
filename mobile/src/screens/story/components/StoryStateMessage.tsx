import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import type { StoryIconName } from '@ola/shared/types';
import { ERROR } from '@constants';
import { useThemeColors } from '@hooks/useThemeColors';
import { useStoryTextSize } from '../typography';
import { StoryIcon } from './StoryIcons';

type StoryStateKind = 'empty' | 'error';

const MUTED = 'rgba(0,0,0,0.54)';
const ART_SIZE = 56;
const ART_OPACITY = 0.3;
const BADGE_SIZE = 24;
const BADGE_ICON_SIZE = 16;

const BADGE_ICON: Record<StoryStateKind, StoryIconName> = {
  empty: 'search',
  error: 'priorityHigh',
};

interface StoryStateMessageProps {
  kind: StoryStateKind;
  text: string;
  onRetry?: () => void;
  className?: string;
}

export function StoryStateMessage({
  kind,
  text,
  onRetry,
  className = 'py-10',
}: StoryStateMessageProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const textSize = useStoryTextSize();
  return (
    <View
      accessibilityRole={kind === 'error' ? 'alert' : undefined}
      className={`items-center gap-3 px-6 ${className}`}
    >
      <View>
        <View style={{ opacity: ART_OPACITY }}>
          <StoryIcon name="menuBook" size={ART_SIZE} color={MUTED} />
        </View>
        <View
          className="items-center justify-center rounded-full"
          style={{
            position: 'absolute',
            right: -6,
            bottom: -2,
            width: BADGE_SIZE,
            height: BADGE_SIZE,
            backgroundColor: kind === 'error' ? ERROR : colors.primary,
          }}
        >
          <StoryIcon name={BADGE_ICON[kind]} size={BADGE_ICON_SIZE} color="#ffffff" />
        </View>
      </View>
      <Text className="text-center" style={[textSize(14, 20), { color: MUTED }]}>
        {text}
      </Text>
      {onRetry && (
        <Pressable onPress={onRetry} className="rounded-full bg-ola-button px-4 py-1.5">
          <Text style={[textSize(14, 20), { color: colors.onPrimary }]}>{t('story.retry')}</Text>
        </Pressable>
      )}
    </View>
  );
}
