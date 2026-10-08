import { useCallback, useEffect, useRef, useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Platform,
  Pressable,
  ScrollView,
  StatusBar,
  Text,
  View,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { splitStoryParagraphs, storyChapterKey } from '@ola/shared/lib';
import { useStoryConfigStore } from '@ola/shared/stores/story/storyConfigStore';
import { useStoryStore } from '@ola/shared/stores/story/storyStore';
import { useStoryPrefsStore } from '@ola/shared/stores/story/storyPrefsStore';
import type { RootStackParamList } from '@navigation/types';
import type { ROOT_ROUTES } from '@navigation/routes';
import { useThemeColors } from '@hooks/useThemeColors';
import { READER_FONTS, READER_PALETTES } from './constants';
import { ChapterPickerSheet } from './components/ChapterPickerSheet';
import { ReaderSettingsSheet } from './components/ReaderSettingsSheet';
import { StoryIcon } from './components/StoryIcons';
import { useStoryTextSize } from './typography';

type ReaderSheetKind = 'settings' | 'toc';

type Props = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.StoryReader>;

const ARTICLE_MAX_WIDTH = 672;
const TITLE_SCALE = 1.25;
const PARAGRAPH_GAP = 0.9;
const BAR_HEIGHT = 48;
const NAV_ICON_SIZE = 20;

interface HeaderButtonProps {
  accessibilityLabel: string;
  disabled?: boolean;
  onPress: () => void;
  children: ReactNode;
}

function HeaderButton({ accessibilityLabel, disabled = false, onPress, children }: HeaderButtonProps) {
  return (
    <Pressable
      accessibilityRole="button"
      accessibilityLabel={accessibilityLabel}
      disabled={disabled}
      onPress={onPress}
      className="h-10 w-10 items-center justify-center rounded-full"
      style={{ opacity: disabled ? 0.4 : 1 }}
    >
      {children}
    </Pressable>
  );
}

export function StoryReaderScreen({ route, navigation }: Props) {
  const { storyId, position } = route.params;
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const colors = useThemeColors();
  const textSize = useStoryTextSize();
  const key = storyChapterKey(storyId, position);
  const storyEnabled = useStoryConfigStore((state) => state.enabled);
  const story = useStoryStore((state) => state.stories[storyId]);
  const chapters = useStoryStore((state) => state.chapters[storyId]);
  const chapter = useStoryStore((state) => state.chapterContents[key]);
  const chapterStatus = useStoryStore((state) => state.chapterStatus[key]);
  const loadStory = useStoryStore((state) => state.loadStory);
  const loadChapter = useStoryStore((state) => state.loadChapter);
  const reader = useStoryPrefsStore((state) => state.reader);
  const saveProgress = useStoryPrefsStore((state) => state.saveProgress);
  const [sheet, setSheet] = useState<ReaderSheetKind | null>(null);
  const scrollRef = useRef<ScrollView>(null);
  const palette = READER_PALETTES[reader.theme];
  const lightStatusIcons = Platform.OS === 'android' || reader.theme === 'dark';

  const onBack = useCallback(() => navigation.goBack(), [navigation]);
  const onChangeChapter = useCallback(
    (next: number) => navigation.setParams({ position: next }),
    [navigation]
  );

  useEffect(() => {
    if (storyEnabled === false) navigation.popToTop();
  }, [storyEnabled, navigation]);

  useEffect(() => {
    if (!useStoryStore.getState().chapters[storyId]) void loadStory(storyId);
  }, [storyId, loadStory]);

  useEffect(() => {
    void loadChapter(storyId, position);
  }, [storyId, position, loadChapter]);

  const chapterReady = chapter != null;

  useEffect(() => {
    scrollRef.current?.scrollTo({ y: 0, animated: false });
  }, [storyId, position, chapterReady]);

  useEffect(() => {
    if (!chapter || !story) return;
    saveProgress({
      storyId,
      storyTitle: story.title,
      coverUrl: story.coverUrl,
      position: chapter.position,
      chapterTitle: chapter.title,
      chapterCount: story.chapterCount,
    });
    if (chapter.nextPosition != null) {
      void loadChapter(storyId, chapter.nextPosition);
    }
  }, [chapter, story, storyId, saveProgress, loadChapter]);

  const prevPosition = chapter?.prevPosition ?? null;
  const nextPosition = chapter?.nextPosition ?? null;

  function pickChapter(next: number) {
    setSheet(null);
    onChangeChapter(next);
  }

  const bodyStyle = {
    fontFamily: READER_FONTS[reader.font].family,
    fontSize: reader.fontSize,
    lineHeight: reader.fontSize * reader.lineHeight,
    color: palette.text,
  };

  function renderBody() {
    if (!chapter) {
      return (
        <View className="flex-1 items-center justify-center gap-3 py-20">
          {chapterStatus === 'error' ? (
            <>
              <Text style={[textSize(14, 20), { color: palette.text }]}>
                {t('story.loadError')}
              </Text>
              <Pressable
                onPress={() => void loadChapter(storyId, position)}
                className="rounded-full bg-ola-button px-4 py-1.5"
              >
                <Text style={[textSize(14, 20), { color: colors.onPrimary }]}>
                  {t('story.retry')}
                </Text>
              </Pressable>
            </>
          ) : (
            <ActivityIndicator color={palette.muted} />
          )}
        </View>
      );
    }
    return (
      <View
        className="w-full self-center px-5 pb-10 pt-6"
        style={{ maxWidth: ARTICLE_MAX_WIDTH }}
      >
        <Text
          className="text-center font-bold"
          style={{
            fontFamily: bodyStyle.fontFamily,
            color: palette.text,
            fontSize: reader.fontSize * TITLE_SCALE,
            lineHeight: reader.fontSize * TITLE_SCALE * 1.375,
          }}
        >
          {chapter.title}
        </Text>
        <View
          className="mb-6 mt-4 self-center"
          style={{ height: 1, width: 96, backgroundColor: palette.border }}
        />
        {splitStoryParagraphs(chapter.content).map((paragraph, index) => (
          <Text
            key={index}
            style={[bodyStyle, { marginBottom: reader.fontSize * PARAGRAPH_GAP }]}
          >
            {paragraph}
          </Text>
        ))}
        <View
          className="mt-10 items-center gap-3 pt-6"
          style={{ borderTopWidth: 1, borderTopColor: palette.border }}
        >
          {nextPosition != null ? (
            <Pressable
              onPress={() => onChangeChapter(nextPosition)}
              className="h-11 w-full flex-row items-center justify-center gap-1 rounded-full bg-ola-button"
              style={{ maxWidth: 320 }}
            >
              <Text className="font-semibold" style={[textSize(14, 20), { color: colors.onPrimary }]}>
                {t('story.nextChapter')}
              </Text>
              <StoryIcon name="chevronRight" size={NAV_ICON_SIZE} color={colors.onPrimary} />
            </Pressable>
          ) : (
            <>
              <Text style={[textSize(14, 20), { color: palette.muted }]}>
                {t('story.endOfStory')}
              </Text>
              <Pressable
                onPress={onBack}
                className="h-10 items-center justify-center rounded-full px-5"
                style={{ borderWidth: 1, borderColor: colors.primary }}
              >
                <Text style={[textSize(14, 20), { color: colors.primaryInk }]}>
                  {t('story.backToStory')}
                </Text>
              </Pressable>
            </>
          )}
        </View>
      </View>
    );
  }

  return (
    <View className="flex-1" style={{ backgroundColor: palette.background }}>
      <StatusBar translucent barStyle={lightStatusIcons ? 'light-content' : 'dark-content'} />
      <View
        className="flex-row items-center gap-1 px-1"
        style={{
          paddingTop: insets.top,
          borderBottomWidth: 1,
          borderBottomColor: palette.border,
        }}
      >
        <View className="h-12 flex-1 flex-row items-center gap-1">
          <HeaderButton accessibilityLabel={t('chat.back')} onPress={onBack}>
            <StoryIcon name="chevronLeft" color={palette.text} />
          </HeaderButton>
          <View className="min-w-0 flex-1">
            <Text numberOfLines={1} style={[textSize(11, 16), { color: palette.muted }]}>
              {story?.title}
            </Text>
            <Text
              numberOfLines={1}
              className="font-semibold"
              style={[textSize(14, 20), { color: palette.text }]}
            >
              {chapter?.title ?? story?.title}
            </Text>
          </View>
          <HeaderButton
            accessibilityLabel={t('story.toc')}
            disabled={!chapters}
            onPress={() => setSheet('toc')}
          >
            <StoryIcon name="list" color={palette.text} />
          </HeaderButton>
          <HeaderButton
            accessibilityLabel={t('story.displayOptions')}
            onPress={() => setSheet('settings')}
          >
            <StoryIcon name="formatSize" color={palette.text} />
          </HeaderButton>
        </View>
      </View>

      <ScrollView ref={scrollRef} className="flex-1" contentContainerStyle={{ flexGrow: 1 }}>
        {renderBody()}
      </ScrollView>

      <View
        className="flex-row items-center"
        style={{
          height: BAR_HEIGHT + insets.bottom,
          paddingBottom: insets.bottom,
          borderTopWidth: 1,
          borderTopColor: palette.border,
        }}
      >
        <Pressable
          disabled={prevPosition == null}
          onPress={() => prevPosition != null && onChangeChapter(prevPosition)}
          className="h-full flex-1 flex-row items-center justify-center gap-1"
          style={{ opacity: prevPosition == null ? 0.35 : 1 }}
        >
          <StoryIcon name="chevronLeft" size={NAV_ICON_SIZE} color={palette.text} />
          <Text style={[textSize(14, 20), { color: palette.text }]}>
            {t('story.prevChapter')}
          </Text>
        </Pressable>
        <Text
          className="px-2"
          style={[textSize(12, 16), { color: palette.muted, fontVariant: ['tabular-nums'] }]}
        >
          {story ? `${position}/${story.chapterCount}` : ''}
        </Text>
        <Pressable
          disabled={nextPosition == null}
          onPress={() => nextPosition != null && onChangeChapter(nextPosition)}
          className="h-full flex-1 flex-row items-center justify-center gap-1"
          style={{ opacity: nextPosition == null ? 0.35 : 1 }}
        >
          <Text style={[textSize(14, 20), { color: palette.text }]}>
            {t('story.nextChapter')}
          </Text>
          <StoryIcon name="chevronRight" size={NAV_ICON_SIZE} color={palette.text} />
        </Pressable>
      </View>

      {sheet === 'settings' && (
        <ReaderSettingsSheet palette={palette} onClose={() => setSheet(null)} />
      )}
      {sheet === 'toc' && chapters && (
        <ChapterPickerSheet
          chapters={chapters}
          currentPosition={position}
          palette={palette}
          onPick={pickChapter}
          onClose={() => setSheet(null)}
        />
      )}
    </View>
  );
}
