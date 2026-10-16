import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import { FlashList } from '@shopify/flash-list';
import { useNavigation } from '@react-navigation/native';
import type {
  NativeStackNavigationProp,
  NativeStackScreenProps,
} from '@react-navigation/native-stack';
import { STORY_KIND } from '@ola/shared/constants';
import { splitStoryParagraphs, storyReadPercent } from '@ola/shared/lib';
import { useStoryStore } from '@ola/shared/stores/story/storyStore';
import { useStoryPrefsStore } from '@ola/shared/stores/story/storyPrefsStore';
import type { StoryChapterItem } from '@ola/shared/types';
import type { RootStackParamList, StoryStackParamList } from '@navigation/types';
import { ROOT_ROUTES, STORY_ROUTES } from '@navigation/routes';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { useThemeColors } from '@hooks/useThemeColors';
import { StoryChapterRow, StoryChapterRowsSkeleton } from './components/StoryChapterRow';
import { StoryCommentSheet } from './components/StoryCommentSheet';
import { StoryDetailHeading } from './components/StoryDetailHeading';
import { StoryDetailHero } from './components/StoryDetailHero';
import { StoryDetailSkeleton } from './components/StoryDetailSkeleton';
import { StoryFreeReadsBadge } from './components/StoryFreeReadsBadge';
import { StoryIcon } from './components/StoryIcons';
import { StoryStateMessage } from './components/StoryStateMessage';
import { commentUnlockMinChars, useStoryAccess } from './useStoryAccess';
import { useStoryTextSize } from './useStoryTextSize';

const INTRO_COLLAPSED_HEIGHT = 104;
const INTRO_FADE_HEIGHT = 40;
const INTRO_COLOR = 'rgba(0,0,0,0.7)';
const COUNT_COLOR = 'rgba(0,0,0,0.4)';
const TOGGLE_ICON_SIZE = 20;
const INTRO_FADE = ['rgba(255,255,255,0)', 'rgba(255,255,255,0.7)', '#ffffff'];
const ORDER_OPTIONS = [false, true] as const;
const LIST_BOTTOM_SPACE = 16;

const SEGMENT_SHADOW = {
  shadowColor: '#000',
  shadowOpacity: 0.1,
  shadowRadius: 2,
  shadowOffset: { width: 0, height: 1 },
  elevation: 1,
};

type Props = NativeStackScreenProps<StoryStackParamList, typeof STORY_ROUTES.StoryDetail>;

interface ChapterOrderToggleProps {
  newestFirst: boolean;
  onChange: (newestFirst: boolean) => void;
}

function ChapterOrderToggle({ newestFirst, onChange }: ChapterOrderToggleProps) {
  const { t } = useTranslation();
  const textSize = useStoryTextSize();
  return (
    <View className="flex-row rounded-full p-0.5" style={{ backgroundColor: 'rgba(0,0,0,0.05)' }}>
      {ORDER_OPTIONS.map((newest) => {
        const active = newestFirst === newest;
        return (
          <Pressable
            key={String(newest)}
            accessibilityRole="button"
            accessibilityState={{ selected: active }}
            onPress={() => onChange(newest)}
            className="rounded-full px-2.5 py-1"
            style={active ? [{ backgroundColor: '#ffffff' }, SEGMENT_SHADOW] : undefined}
          >
            <Text
              className={active ? 'font-semibold' : ''}
              style={[textSize(12, 16), { color: active ? 'rgba(0,0,0,0.87)' : 'rgba(0,0,0,0.5)' }]}
            >
              {t(newest ? 'story.orderNewest' : 'story.orderOldest')}
            </Text>
          </Pressable>
        );
      })}
    </View>
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

  if (!story) {
    return (
      <View className="flex-1 bg-ola-surface">
        <ScreenHeader title="" onBack={navigation.goBack} />
        {status === 'error' ? (
          <View className="flex-1 items-center justify-center">
            <StoryStateMessage
              kind="error"
              text={t('story.loadError')}
              onRetry={() => void loadStory(storyId)}
            />
          </View>
        ) : (
          <StoryDetailSkeleton />
        )}
      </View>
    );
  }

  const isShort = story.kind === STORY_KIND.short;
  const introParagraphs = splitStoryParagraphs(story.intro);
  const showFreeReads = access != null && commentUnlockMinChars(access) != null;
  const readingProgress = isShort ? undefined : progress;
  const readPosition = readingProgress?.position ?? null;
  const readLabel =
    readPosition != null
      ? t('story.readContinue', { position: readPosition })
      : t(isShort ? 'story.readShort' : 'story.readFromStart');
  const percent = readingProgress
    ? storyReadPercent(readingProgress.position, story.chapterCount)
    : null;
  const chaptersFailed = chapters == null && status === 'error';

  const header = (
    <View>
      <StoryDetailHero
        story={story}
        isShort={isShort}
        readLabel={readLabel}
        percent={percent}
        onRead={() => onRead(readPosition ?? 1)}
        onComments={() => setCommentsOpen(true)}
      />

      <View className="mt-2 bg-white px-4 py-3">
        <StoryDetailHeading>{t('story.intro')}</StoryDetailHeading>
        <View
          className="mt-2"
          style={introExpanded ? undefined : { maxHeight: INTRO_COLLAPSED_HEIGHT, overflow: 'hidden' }}
        >
          <View className="gap-2">
            {introParagraphs.map((paragraph, index) => (
              <Text key={index} style={[textSize(14, 26), { color: INTRO_COLOR }]}>
                {paragraph}
              </Text>
            ))}
          </View>
          {!introExpanded && (
            <LinearGradient
              pointerEvents="none"
              colors={INTRO_FADE}
              style={{ position: 'absolute', left: 0, right: 0, bottom: 0, height: INTRO_FADE_HEIGHT }}
            />
          )}
        </View>
        <Pressable
          accessibilityRole="button"
          accessibilityState={{ expanded: introExpanded }}
          onPress={() => setIntroExpanded((value) => !value)}
          className="mt-1 flex-row items-center self-start"
        >
          <Text className="font-medium" style={[textSize(14, 20), { color: colors.primaryDark }]}>
            {t(introExpanded ? 'story.showLess' : 'story.showMore')}
          </Text>
          <View style={{ transform: [{ rotate: introExpanded ? '180deg' : '0deg' }] }}>
            <StoryIcon name="arrowDropDown" size={TOGGLE_ICON_SIZE} color={colors.primaryDark} />
          </View>
        </Pressable>
      </View>

      {!isShort && (
        <View className="mt-2 bg-white">
          <View className="flex-row items-center justify-between gap-2 px-4 pb-2 pt-3">
            <StoryDetailHeading>
              {t('story.chapterList')}
              <Text className="font-normal" style={{ color: COUNT_COLOR }}>
                {` (${story.chapterCount.toLocaleString(i18n.language)})`}
              </Text>
            </StoryDetailHeading>
            <ChapterOrderToggle newestFirst={newestFirst} onChange={setNewestFirst} />
          </View>
          {chaptersFailed && (
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

  const footer = isShort ? null : chapters || chaptersFailed ? (
    <View className="bg-white" style={{ height: LIST_BOTTOM_SPACE }} />
  ) : (
    <StoryChapterRowsSkeleton />
  );

  return (
    <View className="flex-1 bg-ola-surface">
      <ScreenHeader
        title={story.title}
        onBack={navigation.goBack}
        right={showFreeReads ? <StoryFreeReadsBadge access={access} /> : undefined}
      />
      <FlashList<StoryChapterItem>
        data={isShort ? [] : orderedChapters}
        keyExtractor={(chapter) => chapter.id}
        extraData={readPosition}
        renderItem={({ item }) => (
          <StoryChapterRow chapter={item} readPosition={readPosition} onOpen={onRead} />
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
