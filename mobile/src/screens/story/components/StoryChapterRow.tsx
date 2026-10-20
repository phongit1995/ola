import { memo } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import { formatDateSlashDMY, withAlpha } from '@ola/shared/lib';
import type { StoryChapterItem } from '@ola/shared/types';
import { useThemeColors } from '@hooks/useThemeColors';
import { ROW_SEPARATOR } from '../constants';
import { useStoryTextSize } from '../useStoryTextSize';
import { StoryIcon } from './StoryIcons';

const READ_TITLE_COLOR = '#7c3aed';
const READ_DATE_COLOR = '#a78bfa';
const UNREAD_TITLE_COLOR = 'rgba(0,0,0,0.8)';
const UNREAD_DATE_COLOR = 'rgba(0,0,0,0.4)';
const ACCENT_WIDTH = 3;
const ROW_PADDING = 16;
const READING_ICON_SIZE = 12;
const SKELETON_WIDTHS = ['72%', '58%', '66%', '80%', '61%', '70%'] as const;

interface StoryChapterRowProps {
  chapter: StoryChapterItem;
  readPosition: number | null;
  onOpen: (position: number) => void;
}

function StoryChapterRowComponent({ chapter, readPosition, onOpen }: StoryChapterRowProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const textSize = useStoryTextSize();
  const current = readPosition === chapter.position;
  const read = readPosition != null && chapter.position < readPosition;
  const titleColor = current ? colors.primaryDark : read ? READ_TITLE_COLOR : UNREAD_TITLE_COLOR;

  return (
    <Pressable
      accessibilityRole="button"
      accessibilityState={{ selected: current }}
      onPress={() => onOpen(chapter.position)}
      className={`flex-row items-center gap-2 py-3 pr-4 ${current ? '' : 'bg-white active:bg-black/5'}`}
      style={[
        {
          paddingLeft: ROW_PADDING - ACCENT_WIDTH,
          borderLeftWidth: ACCENT_WIDTH,
          borderLeftColor: current ? colors.primary : 'transparent',
          borderTopWidth: 1,
          borderTopColor: ROW_SEPARATOR,
        },
        current && { backgroundColor: colors.primaryLight },
      ]}
    >
      <Text
        numberOfLines={1}
        className={`min-w-0 flex-1 ${current ? 'font-semibold' : ''}`}
        style={[textSize(14, 20), { color: titleColor }]}
      >
        {chapter.title}
      </Text>
      {chapter.isNew && (
        <View className="rounded-full bg-ola-accent px-1.5">
          <Text className="font-bold uppercase text-white" style={textSize(10, 16)}>
            {t('story.newBadge')}
          </Text>
        </View>
      )}
      {current && (
        <View
          className="flex-row items-center gap-0.5 rounded-full px-2 py-0.5"
          style={{ backgroundColor: withAlpha(colors.primary, 0.15) }}
        >
          <StoryIcon name="bookmark" size={READING_ICON_SIZE} color={colors.primaryDark} />
          <Text className="font-medium" style={[textSize(11, 16), { color: colors.primaryDark }]}>
            {t('story.reading')}
          </Text>
        </View>
      )}
      <Text
        style={[
          textSize(12, 16),
          { color: read ? READ_DATE_COLOR : UNREAD_DATE_COLOR, fontVariant: ['tabular-nums'] },
        ]}
      >
        {formatDateSlashDMY(chapter.publishedAt ?? '')}
      </Text>
    </Pressable>
  );
}

export const StoryChapterRow = memo(StoryChapterRowComponent);

export function StoryChapterRowsSkeleton() {
  return (
    <View accessibilityState={{ busy: true }} className="bg-white">
      {SKELETON_WIDTHS.map((width, index) => (
        <View
          key={index}
          className="flex-row items-center gap-3 px-4 py-3.5"
          style={{ borderTopWidth: 1, borderTopColor: ROW_SEPARATOR }}
        >
          <View className="h-3.5 rounded" style={{ width, backgroundColor: 'rgba(0,0,0,0.08)' }} />
          <View
            className="ml-auto h-3 w-16 rounded"
            style={{ backgroundColor: 'rgba(0,0,0,0.06)' }}
          />
        </View>
      ))}
    </View>
  );
}
