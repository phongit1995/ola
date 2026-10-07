import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Linking, Pressable, Text, View } from 'react-native';
import { FlashList } from '@shopify/flash-list';
import { useNavigation } from '@react-navigation/native';
import type {
  NativeStackNavigationProp,
  NativeStackScreenProps,
} from '@react-navigation/native-stack';
import { STORY_KIND } from '@ola/shared/constants';
import {
  formatCompactCount,
  formatDateSlashDMY,
  splitStoryParagraphs,
} from '@ola/shared/lib';
import { useStoryStore } from '@ola/shared/stores/story/storyStore';
import { useStoryPrefsStore } from '@ola/shared/stores/story/storyPrefsStore';
import type { StoryChapterItem } from '@ola/shared/types';
import type { RootStackParamList, StoryStackParamList } from '@navigation/types';
import { ROOT_ROUTES, STORY_ROUTES } from '@navigation/routes';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { useThemeColors } from '@hooks/useThemeColors';
import { ROW_SEPARATOR } from './constants';
import { StoryCover } from './components/StoryCover';
import { SortIcon } from './components/StoryIcons';
import { NewBadge, StoryStatusBadge, StoryTag } from './components/StoryTags';
import { useStoryTextSize } from './typography';

const INTRO_PREVIEW_LINES = 4;
const DETAIL_COVER_WIDTH = 112;
const MUTED = 'rgba(0,0,0,0.54)';
const HOST_PATTERN = /^[a-z]+:\/\/([^/?#]+)/i;

type Props = NativeStackScreenProps<StoryStackParamList, typeof STORY_ROUTES.StoryDetail>;

function hostOf(url: string): string {
  return HOST_PATTERN.exec(url)?.[1] ?? url;
}

function Stat({ label, value }: { label: string; value: string }) {
  const textSize = useStoryTextSize();
  return (
    <View className="flex-1 items-center gap-0.5">
      <Text className="font-bold text-ola-ink" style={textSize(16, 24)}>
        {value}
      </Text>
      <Text style={[textSize(11, 16), { color: MUTED }]}>{label}</Text>
    </View>
  );
}

interface ChapterRowProps {
  chapter: StoryChapterItem;
  current: boolean;
  onOpen: (position: number) => void;
}

function ChapterRow({ chapter, current, onOpen }: ChapterRowProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const textSize = useStoryTextSize();
  return (
    <Pressable
      onPress={() => onOpen(chapter.position)}
      className="flex-row items-center gap-2 bg-white px-4 py-3 active:bg-black/5"
      style={{ borderTopWidth: 1, borderTopColor: ROW_SEPARATOR }}
    >
      <Text
        numberOfLines={1}
        className={`min-w-0 flex-1 ${current ? 'font-semibold' : ''}`}
        style={[textSize(14, 20), { color: current ? colors.primaryInk : 'rgba(0,0,0,0.8)' }]}
      >
        {chapter.title}
      </Text>
      {chapter.isNew && <NewBadge label={t('story.newBadge')} />}
      {current && (
        <Text style={[textSize(11, 16), { color: colors.primaryInk }]}>
          {t('story.reading')}
        </Text>
      )}
      <Text style={[textSize(12, 16), { color: 'rgba(0,0,0,0.4)' }]}>
        {formatDateSlashDMY(chapter.publishedAt ?? '')}
      </Text>
    </Pressable>
  );
}

export function StoryDetailScreen({ route, navigation }: Props) {
  const { storyId } = route.params;
  const { t, i18n } = useTranslation();
  const colors = useThemeColors();
  const textSize = useStoryTextSize();
  const rootNavigation = useNavigation<NativeStackNavigationProp<RootStackParamList>>();
  const story = useStoryStore((state) => state.stories[storyId]);
  const status = useStoryStore((state) => state.storyStatus[storyId]);
  const chapters = useStoryStore((state) => state.chapters[storyId]);
  const loadStory = useStoryStore((state) => state.loadStory);
  const progress = useStoryPrefsStore((state) => state.progress[storyId]);
  const [introExpanded, setIntroExpanded] = useState(false);
  const [newestFirst, setNewestFirst] = useState(false);

  useEffect(() => {
    void loadStory(storyId);
  }, [storyId, loadStory]);

  const orderedChapters = useMemo(
    () => (newestFirst ? [...(chapters ?? [])].reverse() : (chapters ?? [])),
    [chapters, newestFirst]
  );

  const onRead = useCallback(
    (position: number) =>
      rootNavigation.navigate(ROOT_ROUTES.StoryReader, { storyId, position }),
    [rootNavigation, storyId]
  );

  if (!story) {
    return (
      <View className="flex-1 bg-ola-surface">
        <ScreenHeader title="" onBack={navigation.goBack} />
        <View className="flex-1 items-center justify-center gap-3">
          {status === 'error' ? (
            <>
              <Text style={[textSize(14, 20), { color: MUTED }]}>{t('story.loadError')}</Text>
              <Pressable
                onPress={() => void loadStory(storyId)}
                className="rounded-full bg-ola-button px-4 py-1.5"
              >
                <Text style={[textSize(14, 20), { color: colors.onPrimary }]}>
                  {t('story.retry')}
                </Text>
              </Pressable>
            </>
          ) : (
            <ActivityIndicator color={colors.primary} />
          )}
        </View>
      </View>
    );
  }

  const isShort = story.kind === STORY_KIND.short;
  const intro = splitStoryParagraphs(story.intro).join('\n\n');
  const locale = i18n.language;
  const primaryButton = 'h-10 flex-1 items-center justify-center rounded-full bg-ola-button active:opacity-90';

  const header = (
    <View>
      <View className="bg-white px-4 pb-3 pt-4">
        <View className="flex-row gap-4">
          <StoryCover
            title={story.title}
            coverUrl={story.coverUrl}
            size="lg"
            width={DETAIL_COVER_WIDTH}
          />
          <View className="min-w-0 flex-1">
            <Text className="font-bold text-ola-ink" style={textSize(18, 24)}>
              {story.title}
            </Text>
            <View className="mt-2 flex-row flex-wrap gap-1">
              <StoryStatusBadge status={story.status} />
              {isShort && <StoryTag>{t('story.kindShort')}</StoryTag>}
            </View>
            <View className="mt-2 flex-row flex-wrap gap-1">
              {story.genres.map((genre) => (
                <StoryTag key={genre}>{genre}</StoryTag>
              ))}
            </View>
          </View>
        </View>
        <View className="mt-4 flex-row rounded-lg bg-ola-surface py-2">
          <Stat label={t('story.statChapters')} value={story.chapterCount.toLocaleString(locale)} />
          <Stat label={t('story.statViews')} value={formatCompactCount(story.viewCount, locale)} />
          <Stat label={t('story.statWords')} value={formatCompactCount(story.wordCount, locale)} />
          <Stat
            label={t('story.statComments')}
            value={formatCompactCount(story.commentCount, locale)}
          />
        </View>
        <View className="mt-4 flex-row gap-2">
          {progress && !isShort ? (
            <>
              <Pressable onPress={() => onRead(progress.position)} className={primaryButton}>
                <Text className="font-semibold" style={[textSize(14, 20), { color: colors.onPrimary }]}>
                  {t('story.readContinue', { position: progress.position })}
                </Text>
              </Pressable>
              <Pressable
                onPress={() => onRead(1)}
                className="h-10 items-center justify-center rounded-full px-4"
                style={{ borderWidth: 1, borderColor: colors.primary }}
              >
                <Text style={[textSize(14, 20), { color: colors.primaryInk }]}>
                  {t('story.readFromStart')}
                </Text>
              </Pressable>
            </>
          ) : (
            <Pressable onPress={() => onRead(1)} className={primaryButton}>
              <Text className="font-semibold" style={[textSize(14, 20), { color: colors.onPrimary }]}>
                {t(isShort ? 'story.readShort' : 'story.readFromStart')}
              </Text>
            </Pressable>
          )}
        </View>
      </View>

      <View className="mt-2 bg-white px-4 py-3">
        <Text className="font-bold text-ola-ink" style={textSize(15, 20)}>
          {t('story.intro')}
        </Text>
        <Text
          numberOfLines={introExpanded ? undefined : INTRO_PREVIEW_LINES}
          className="mt-2"
          style={[textSize(14, 24), { color: 'rgba(0,0,0,0.75)' }]}
        >
          {intro}
        </Text>
        <Pressable onPress={() => setIntroExpanded((value) => !value)} className="mt-1 self-start">
          <Text style={[textSize(14, 20), { color: colors.primaryInk }]}>
            {t(introExpanded ? 'story.showLess' : 'story.showMore')}
          </Text>
        </Pressable>
        {story.sourceUrl !== '' && (
          <Pressable
            onPress={() => void Linking.openURL(story.sourceUrl).catch(() => undefined)}
            className="mt-2 self-start"
          >
            <Text className="underline" style={[textSize(12, 16), { color: 'rgba(0,0,0,0.45)' }]}>
              {t('story.sourceFrom', { host: hostOf(story.sourceUrl) })}
            </Text>
          </Pressable>
        )}
      </View>

      {!isShort && (
        <View className="mt-2 flex-row items-center justify-between bg-white px-4 pb-1 pt-3">
          <Text className="font-bold text-ola-ink" style={textSize(15, 20)}>
            {t('story.chapterList')}
            <Text className="font-normal" style={{ color: MUTED }}>
              {` (${story.chapterCount})`}
            </Text>
          </Text>
          <Pressable
            onPress={() => setNewestFirst((value) => !value)}
            className="flex-row items-center gap-1"
          >
            <SortIcon size={16} color="rgba(0,0,0,0.6)" />
            <Text style={[textSize(13, 18), { color: 'rgba(0,0,0,0.6)' }]}>
              {t(newestFirst ? 'story.orderNewest' : 'story.orderOldest')}
            </Text>
          </Pressable>
        </View>
      )}
    </View>
  );

  const footer = isShort ? null : chapters ? (
    <View className="bg-white" style={{ height: 16 }} />
  ) : (
    <View className="items-center bg-white py-6">
      <ActivityIndicator color={colors.primary} />
    </View>
  );

  return (
    <View className="flex-1 bg-ola-surface">
      <ScreenHeader title={story.title} onBack={navigation.goBack} />
      <FlashList<StoryChapterItem>
        data={isShort ? [] : orderedChapters}
        keyExtractor={(chapter) => chapter.id}
        extraData={progress?.position}
        renderItem={({ item }) => (
          <ChapterRow
            chapter={item}
            current={progress?.position === item.position}
            onOpen={onRead}
          />
        )}
        ListHeaderComponent={header}
        ListFooterComponent={footer}
      />
    </View>
  );
}
