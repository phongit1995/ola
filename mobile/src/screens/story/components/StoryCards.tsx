import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, ScrollView, Text, View } from 'react-native';
import { formatCompactCount } from '@ola/shared/lib';
import type { Story, StoryIconName, StoryProgress } from '@ola/shared/types';
import { useThemeColors } from '@hooks/useThemeColors';
import { useStoryTextSize } from '../typography';
import { StoryCover } from './StoryCover';
import { StoryIcon } from './StoryIcons';
import { StoryMeta } from './StoryTags';

const PODIUM_SIZE = 3;
const CARD_WIDTH = 104;
const CARD_META_FONT = 11;
const SECTION_ICON_SIZE = 20;
const SECTION_TITLE_COLOR = 'rgba(0,0,0,0.87)';

interface StorySectionTitleProps {
  icon: StoryIconName;
  children: string;
}

export function StorySectionTitle({ icon, children }: StorySectionTitleProps) {
  const textSize = useStoryTextSize();
  return (
    <View className="flex-row items-center gap-1.5">
      <StoryIcon name={icon} size={SECTION_ICON_SIZE} color={SECTION_TITLE_COLOR} />
      <Text
        numberOfLines={1}
        className="min-w-0 flex-shrink font-bold text-ola-ink"
        style={textSize(15, 20)}
      >
        {children}
      </Text>
    </View>
  );
}

interface StoryShelfProps {
  title: string;
  icon: StoryIconName;
  children: ReactNode;
}

export function StoryShelf({ title, icon, children }: StoryShelfProps) {
  return (
    <View className="bg-white py-3">
      <View className="px-3">
        <StorySectionTitle icon={icon}>{title}</StorySectionTitle>
      </View>
      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        className="mt-2"
        contentContainerStyle={{ paddingHorizontal: 12, paddingBottom: 4, gap: 12 }}
      >
        {children}
      </ScrollView>
    </View>
  );
}

function CardTitle({ children }: { children: string }) {
  const textSize = useStoryTextSize();
  return (
    <Text numberOfLines={2} className="mt-1.5 font-medium text-ola-ink" style={textSize(13, 16)}>
      {children}
    </Text>
  );
}

interface TopStoryCardProps {
  story: Story;
  rank: number;
  onOpen: (storyId: string) => void;
}

export function TopStoryCard({ story, rank, onOpen }: TopStoryCardProps) {
  const { i18n } = useTranslation();
  const textSize = useStoryTextSize();
  return (
    <Pressable
      onPress={() => onOpen(story.id)}
      style={{ width: CARD_WIDTH }}
      className="active:opacity-80"
    >
      <StoryCover title={story.title} coverUrl={story.coverUrl} width={CARD_WIDTH}>
        <View
          className={`absolute left-0 top-0 rounded-br-md px-1.5 py-0.5 ${
            rank <= PODIUM_SIZE ? 'bg-ola-accent' : 'bg-black/55'
          }`}
        >
          <Text className="font-bold text-white" style={textSize(12, 16)}>
            {rank}
          </Text>
        </View>
      </StoryCover>
      <CardTitle>{story.title}</CardTitle>
      <StoryMeta icon="visibility" fontSize={CARD_META_FONT} className="mt-0.5">
        {formatCompactCount(story.viewCount, i18n.language)}
      </StoryMeta>
    </Pressable>
  );
}

interface ContinueCardProps {
  progress: StoryProgress;
  onOpen: (progress: StoryProgress) => void;
}

export function ContinueCard({ progress, onOpen }: ContinueCardProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const percent = Math.round(
    (progress.position / Math.max(progress.chapterCount, 1)) * 100
  );
  return (
    <Pressable
      onPress={() => onOpen(progress)}
      style={{ width: CARD_WIDTH }}
      className="active:opacity-80"
    >
      <StoryCover title={progress.storyTitle} coverUrl={progress.coverUrl} width={CARD_WIDTH}>
        <View
          style={{
            position: 'absolute',
            left: 0,
            right: 0,
            bottom: 0,
            height: 4,
            backgroundColor: 'rgba(0,0,0,0.3)',
          }}
        >
          <View style={{ height: '100%', width: `${percent}%`, backgroundColor: colors.primary }} />
        </View>
      </StoryCover>
      <CardTitle>{progress.storyTitle}</CardTitle>
      <StoryMeta icon="bookmark" fontSize={CARD_META_FONT} className="mt-0.5">
        {t('story.chapterProgress', {
          position: progress.position,
          count: progress.chapterCount,
        })}
      </StoryMeta>
    </Pressable>
  );
}
