import { useTranslation } from 'react-i18next';
import { Text, View } from 'react-native';
import { STORY_STATUS } from '@ola/shared/constants';
import { withAlpha } from '@ola/shared/lib';
import type { StoryStatus, ThemeColors } from '@ola/shared/types';
import { WARNING } from '@constants';
import { useThemeColors } from '@hooks/useThemeColors';
import { STATUS_LABEL } from '../constants';
import { useStoryTextSize } from '../typography';

const TAG_FONT = 11;

function statusStyle(status: StoryStatus, colors: ThemeColors) {
  switch (status) {
    case STORY_STATUS.ongoing:
      return { backgroundColor: withAlpha(WARNING, 0.15), color: WARNING };
    case STORY_STATUS.completed:
      return { backgroundColor: withAlpha(colors.primary, 0.15), color: colors.primaryDark };
    default:
      return { backgroundColor: 'rgba(0,0,0,0.05)', color: 'rgba(0,0,0,0.54)' };
  }
}

export function StoryStatusBadge({ status }: { status: StoryStatus }) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const textSize = useStoryTextSize();
  const { backgroundColor, color } = statusStyle(status, colors);
  return (
    <View className="rounded px-1.5 py-0.5" style={{ backgroundColor }}>
      <Text className="font-medium" style={[textSize(TAG_FONT, TAG_FONT + 2), { color }]}>
        {t(STATUS_LABEL[status])}
      </Text>
    </View>
  );
}

export function StoryTag({ children }: { children: string }) {
  const textSize = useStoryTextSize();
  return (
    <View className="rounded px-1.5 py-0.5" style={{ backgroundColor: 'rgba(0,0,0,0.05)' }}>
      <Text style={[textSize(TAG_FONT, TAG_FONT + 2), { color: 'rgba(0,0,0,0.6)' }]}>
        {children}
      </Text>
    </View>
  );
}

export function NewBadge({ label }: { label: string }) {
  const textSize = useStoryTextSize();
  return (
    <View className="rounded bg-ola-accent px-1">
      <Text className="font-bold uppercase text-white" style={textSize(10, 16)}>
        {label}
      </Text>
    </View>
  );
}
