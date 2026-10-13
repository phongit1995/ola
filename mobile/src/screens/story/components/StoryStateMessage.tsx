import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, View } from 'react-native';
import { useThemeColors } from '@hooks/useThemeColors';
import { STORY_STATE_ART, type StoryStateKind } from '../constants';
import { useStoryTextSize } from '../typography';

const MUTED = 'rgba(0,0,0,0.54)';
const ART_SIZE = 96;

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
      <Image
        source={STORY_STATE_ART[kind]}
        style={{ width: ART_SIZE, height: ART_SIZE }}
        resizeMode="contain"
      />
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
