import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import { STORY_KIND } from '@ola/shared/constants';
import { formatCompactCount, formatDateSlashDMY } from '@ola/shared/lib';
import type { Story } from '@ola/shared/types';
import { useStoryTextSize } from '../typography';
import { StoryCover } from './StoryCover';
import { EyeIcon } from './StoryIcons';
import { StoryStatusBadge, StoryTag } from './StoryTags';

const ROW_GENRE_LIMIT = 2;
const ROW_COVER_WIDTH = 64;
const META_COLOR = 'rgba(0,0,0,0.54)';

interface StoryRowProps {
  story: Story;
  onOpen: (storyId: string) => void;
}

export function StoryRow({ story, onOpen }: StoryRowProps) {
  const { t, i18n } = useTranslation();
  const textSize = useStoryTextSize();
  const isShort = story.kind === STORY_KIND.short;
  const meta = [textSize(12, 16), { color: META_COLOR }];

  return (
    <Pressable
      onPress={() => onOpen(story.id)}
      className="flex-row gap-3 bg-white px-3 py-3 active:bg-black/5"
    >
      <StoryCover title={story.title} coverUrl={story.coverUrl} size="sm" width={ROW_COVER_WIDTH} />
      <View className="min-w-0 flex-1">
        <Text numberOfLines={2} className="font-semibold text-ola-ink" style={textSize(15, 20)}>
          {story.title}
        </Text>
        <View className="mt-1.5 flex-row flex-wrap items-center gap-1">
          <StoryStatusBadge status={story.status} />
          {story.genres.slice(0, ROW_GENRE_LIMIT).map((genre) => (
            <StoryTag key={genre}>{genre}</StoryTag>
          ))}
        </View>
        <View className="mt-1.5 flex-row items-center gap-2">
          <Text style={meta}>
            {isShort
              ? t('story.kindShort')
              : t('story.chapterCount', { count: story.chapterCount })}
          </Text>
          <View className="flex-row items-center gap-0.5">
            <EyeIcon size={14} color={META_COLOR} />
            <Text style={meta}>{formatCompactCount(story.viewCount, i18n.language)}</Text>
          </View>
          <Text className="ml-auto" style={meta}>
            {formatDateSlashDMY(story.lastChapterAt ?? story.updatedAt)}
          </Text>
        </View>
      </View>
    </Pressable>
  );
}
