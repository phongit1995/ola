import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, ScrollView, Text, View } from 'react-native';
import { formatCompactCount } from '@ola/shared/lib';
import type { Story, StoryProgress } from '@ola/shared/types';
import { useThemeColors } from '@hooks/useThemeColors';
import { useStoryTextSize } from '../typography';
import { StoryCover } from './StoryCover';
import { EyeIcon } from './StoryIcons';

const PODIUM_SIZE = 3;
const CARD_WIDTH = 104;
const META_COLOR = 'rgba(0,0,0,0.54)';

interface StoryShelfProps {
  title: string;
  children: ReactNode;
}

export function StoryShelf({ title, children }: StoryShelfProps) {
  const textSize = useStoryTextSize();
  return (
    <View className="bg-white py-3">
      <Text className="px-3 font-bold text-ola-ink" style={textSize(15, 20)}>
        {title}
      </Text>
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
      <View className="mt-0.5 flex-row items-center gap-0.5">
        <EyeIcon size={12} color={META_COLOR} />
        <Text style={[textSize(11, 16), { color: META_COLOR }]}>
          {formatCompactCount(story.viewCount, i18n.language)}
        </Text>
      </View>
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
  const textSize = useStoryTextSize();
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
      <Text className="mt-0.5" style={[textSize(11, 16), { color: META_COLOR }]}>
        {t('story.chapterProgress', {
          position: progress.position,
          count: progress.chapterCount,
        })}
      </Text>
    </Pressable>
  );
}
