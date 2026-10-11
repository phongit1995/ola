import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, Text, View } from 'react-native';
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
import type { StoryChapterItem, StoryIconName } from '@ola/shared/types';
import type { RootStackParamList, StoryStackParamList } from '@navigation/types';
import { ROOT_ROUTES, STORY_ROUTES } from '@navigation/routes';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { ERROR } from '@constants';
import { useThemeColors } from '@hooks/useThemeColors';
import { ROW_SEPARATOR } from './constants';
import { StoryCommentSheet } from './components/StoryCommentSheet';
import { StoryCover } from './components/StoryCover';
import { StoryIcon } from './components/StoryIcons';
import { StoryStateMessage } from './components/StoryStateMessage';
import { NewBadge, StoryStatusBadge, StoryTag } from './components/StoryTags';
import { storyAccessLine, useStoryAccess, type StoryAccessTone } from './storyAccess';
import { useStoryTextSize } from './typography';

const INTRO_PREVIEW_LINES = 4;
const DETAIL_COVER_WIDTH = 112;
const MUTED = 'rgba(0,0,0,0.54)';
const STAT_ICON_COLOR = 'rgba(0,0,0,0.7)';
const ORDER_COLOR = 'rgba(0,0,0,0.6)';
const SMALL_ICON_SIZE = 16;
const READING_ICON_SIZE = 14;
const SECTION_ICON_SIZE = 20;
const CHEVRON_COLOR = 'rgba(0,0,0,0.4)';

type Props = NativeStackScreenProps<StoryStackParamList, typeof STORY_ROUTES.StoryDetail>;

interface StatProps {
  icon: StoryIconName;
  label: string;
  value: string;
  onPress?: () => void;
}

function Stat({ icon, label, value, onPress }: StatProps) {
  const textSize = useStoryTextSize();
  const content = (
    <>
      <View className="flex-row items-center gap-1">
        <StoryIcon name={icon} size={SMALL_ICON_SIZE} color={STAT_ICON_COLOR} />
        <Text className="font-bold text-ola-ink" style={textSize(16, 24)}>
          {value}
        </Text>
      </View>
      <Text style={[textSize(11, 16), { color: MUTED }]}>{label}</Text>
    </>
  );
  if (onPress) {
    return (
      <Pressable
        accessibilityRole="button"
        onPress={onPress}
        className="flex-1 items-center gap-0.5 rounded-lg active:bg-black/5"
      >
        {content}
      </Pressable>
    );
  }
  return <View className="flex-1 items-center gap-0.5">{content}</View>;
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
        <View className="flex-row items-center gap-0.5">
          <StoryIcon name="bookmark" size={READING_ICON_SIZE} color={colors.primaryInk} />
          <Text style={[textSize(11, 16), { color: colors.primaryInk }]}>
            {t('story.reading')}
          </Text>
        </View>
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
  const access = useStoryAccess(storyId);
  const [introExpanded, setIntroExpanded] = useState(false);
  const [newestFirst, setNewestFirst] = useState(false);
  const [commentsOpen, setCommentsOpen] = useState(false);

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
  const openComments = useCallback(() => setCommentsOpen(true), []);

  if (!story) {
    return (
      <View className="flex-1 bg-ola-surface">
        <ScreenHeader title="" onBack={navigation.goBack} />
        <View className="flex-1 items-center justify-center">
          {status === 'error' ? (
            <StoryStateMessage
              kind="error"
              text={t('story.loadError')}
              onRetry={() => void loadStory(storyId)}
            />
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
  const commentCount = formatCompactCount(story.commentCount, locale);
  const accessLine = storyAccessLine(t, access);
  const accessColor: Record<StoryAccessTone, string> = {
    positive: colors.primaryInk,
    neutral: MUTED,
    warning: ERROR,
  };

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
          <Stat
            icon="menuBook"
            label={t('story.statChapters')}
            value={story.chapterCount.toLocaleString(locale)}
          />
          <Stat
            icon="visibility"
            label={t('story.statViews')}
            value={formatCompactCount(story.viewCount, locale)}
          />
          <Stat
            icon="article"
            label={t('story.statWords')}
            value={formatCompactCount(story.wordCount, locale)}
          />
          <Stat
            icon="chatBubble"
            label={t('story.statComments')}
            value={commentCount}
            onPress={openComments}
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
        {accessLine && (
          <Text
            className="mt-2 text-center"
            style={[textSize(12, 16), { color: accessColor[accessLine.tone] }]}
          >
            {accessLine.label}
          </Text>
        )}
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
      </View>

      <Pressable
        accessibilityRole="button"
        onPress={openComments}
        className="mt-2 flex-row items-center gap-2 bg-white px-4 py-3 active:bg-black/5"
      >
        <StoryIcon name="chatBubble" size={SECTION_ICON_SIZE} color={ORDER_COLOR} />
        <Text className="min-w-0 flex-1 font-bold text-ola-ink" style={textSize(15, 20)}>
          {t('story.comments')}
          <Text className="font-normal" style={{ color: MUTED }}>
            {` (${commentCount})`}
          </Text>
        </Text>
        <StoryIcon name="chevronRight" size={SECTION_ICON_SIZE} color={CHEVRON_COLOR} />
      </Pressable>

      {!isShort && (
        <View className="mt-2 bg-white">
          <View className="flex-row items-center justify-between px-4 pb-1 pt-3">
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
              <StoryIcon name="importExport" size={SMALL_ICON_SIZE} color={ORDER_COLOR} />
              <Text style={[textSize(13, 18), { color: ORDER_COLOR }]}>
                {t(newestFirst ? 'story.orderNewest' : 'story.orderOldest')}
              </Text>
            </Pressable>
          </View>
          {status === 'error' && (
            <StoryStateMessage
              kind="error"
              text={t('story.loadError')}
              onRetry={() => void loadStory(storyId)}
              className="py-6"
            />
          )}
        </View>
      )}
    </View>
  );

  const footer = isShort ? null : chapters || status === 'error' ? (
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
      {commentsOpen && (
        <StoryCommentSheet storyId={storyId} onClose={() => setCommentsOpen(false)} />
      )}
    </View>
  );
}
