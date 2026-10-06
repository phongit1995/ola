import { useEffect, useRef, useState, type CSSProperties } from 'react';
import { useTranslation } from 'react-i18next';
import { Spinner } from '@components';
import { splitStoryParagraphs, storyChapterKey } from '@lib';
import { useStoryStore } from '@ola/shared/stores/story/storyStore';
import { useStoryPrefsStore } from '@ola/shared/stores/story/storyPrefsStore';
import { READER_FONTS, READER_PALETTES } from './constants';
import { ChapterPickerSheet } from './components/ChapterPickerSheet';
import { ReaderSettingsSheet } from './components/ReaderSettingsSheet';
import {
  ChevronLeftIcon,
  ChevronRightIcon,
  ListIcon,
  TextSizeIcon,
} from './components/StoryIcons';

type ReaderSheetKind = 'settings' | 'toc';

interface StoryReaderPageProps {
  storyId: string;
  position: number;
  active: boolean;
  onBack: () => void;
  onChangeChapter: (position: number) => void;
}

function isTypingTarget(target: EventTarget | null): boolean {
  return (
    target instanceof HTMLElement &&
    (target.isContentEditable ||
      target instanceof HTMLInputElement ||
      target instanceof HTMLTextAreaElement ||
      target instanceof HTMLSelectElement)
  );
}

export function StoryReaderPage({
  storyId,
  position,
  active,
  onBack,
  onChangeChapter,
}: StoryReaderPageProps) {
  const { t } = useTranslation();
  const key = storyChapterKey(storyId, position);
  const story = useStoryStore((state) => state.stories[storyId]);
  const chapters = useStoryStore((state) => state.chapters[storyId]);
  const chapter = useStoryStore((state) => state.chapterContents[key]);
  const chapterStatus = useStoryStore((state) => state.chapterStatus[key]);
  const loadStory = useStoryStore((state) => state.loadStory);
  const loadChapter = useStoryStore((state) => state.loadChapter);
  const reader = useStoryPrefsStore((state) => state.reader);
  const saveProgress = useStoryPrefsStore((state) => state.saveProgress);
  const [sheet, setSheet] = useState<ReaderSheetKind | null>(null);
  const scrollRef = useRef<HTMLDivElement>(null);
  const palette = READER_PALETTES[reader.theme];

  useEffect(() => {
    if (!useStoryStore.getState().chapters[storyId]) void loadStory(storyId);
  }, [storyId, loadStory]);

  useEffect(() => {
    void loadChapter(storyId, position);
    scrollRef.current?.scrollTo({ top: 0 });
  }, [storyId, position, loadChapter]);

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

  useEffect(() => {
    if (!active) return;
    function onKeyDown(event: KeyboardEvent) {
      if (sheet != null || isTypingTarget(event.target)) return;
      if (event.key === 'ArrowLeft' && prevPosition != null) {
        onChangeChapter(prevPosition);
      }
      if (event.key === 'ArrowRight' && nextPosition != null) {
        onChangeChapter(nextPosition);
      }
    }
    window.addEventListener('keydown', onKeyDown);
    return () => window.removeEventListener('keydown', onKeyDown);
  }, [active, sheet, prevPosition, nextPosition, onChangeChapter]);

  function pickChapter(next: number) {
    setSheet(null);
    onChangeChapter(next);
  }

  const articleStyle: CSSProperties = {
    fontFamily: READER_FONTS[reader.font].family,
    fontSize: reader.fontSize,
    lineHeight: reader.lineHeight,
  };

  function renderBody() {
    if (!chapter) {
      return (
        <div className="flex flex-1 flex-col items-center justify-center gap-3 py-20 text-sm">
          {chapterStatus === 'error' ? (
            <>
              {t('story.loadError')}
              <button
                type="button"
                onClick={() => void loadChapter(storyId, position)}
                className="rounded-full bg-ola-button px-4 py-1.5 text-ola-on-primary"
              >
                {t('story.retry')}
              </button>
            </>
          ) : (
            <Spinner tone="muted" />
          )}
        </div>
      );
    }
    return (
      <article
        className="mx-auto w-full max-w-2xl px-5 pt-6 pb-10"
        style={articleStyle}
      >
        <h1
          className="text-center leading-snug font-bold"
          style={{ fontSize: reader.fontSize * 1.25 }}
        >
          {chapter.title}
        </h1>
        <div
          className="mx-auto mt-4 mb-6 h-px w-24"
          style={{ backgroundColor: palette.border }}
        />
        {splitStoryParagraphs(chapter.content).map((paragraph, index) => (
          <p key={index} className="mb-[0.9em]">
            {paragraph}
          </p>
        ))}
        <div
          className="mt-10 flex flex-col items-center gap-3 border-t pt-6 font-sans text-sm"
          style={{ borderColor: palette.border }}
        >
          {nextPosition != null ? (
            <button
              type="button"
              onClick={() => onChangeChapter(nextPosition)}
              className="flex h-11 w-full max-w-xs items-center justify-center gap-1 rounded-full bg-ola-button font-semibold text-ola-on-primary"
            >
              {t('story.nextChapter')}
              <ChevronRightIcon className="h-5 w-5" />
            </button>
          ) : (
            <>
              <span style={{ color: palette.muted }}>
                {t('story.endOfStory')}
              </span>
              <button
                type="button"
                onClick={onBack}
                className="h-10 rounded-full border border-ola-primary px-5 text-ola-primary-ink"
              >
                {t('story.backToStory')}
              </button>
            </>
          )}
        </div>
      </article>
    );
  }

  return (
    <div
      className="fixed inset-0 z-40 flex flex-col"
      style={{ backgroundColor: palette.background, color: palette.text }}
    >
      <header
        className="flex h-12 shrink-0 items-center gap-1 border-b px-1"
        style={{ borderColor: palette.border }}
      >
        <button
          type="button"
          aria-label={t('chat.back')}
          onClick={onBack}
          className="flex h-10 w-10 items-center justify-center rounded-full"
        >
          <ChevronLeftIcon />
        </button>
        <div className="flex min-w-0 flex-1 flex-col">
          <span
            className="truncate text-[11px] leading-4"
            style={{ color: palette.muted }}
          >
            {story?.title}
          </span>
          <span className="truncate text-sm leading-5 font-semibold">
            {chapter?.title ?? story?.title}
          </span>
        </div>
        <button
          type="button"
          aria-label={t('story.toc')}
          disabled={!chapters}
          onClick={() => setSheet('toc')}
          className="flex h-10 w-10 items-center justify-center rounded-full disabled:opacity-40"
        >
          <ListIcon />
        </button>
        <button
          type="button"
          aria-label={t('story.displayOptions')}
          onClick={() => setSheet('settings')}
          className="flex h-10 w-10 items-center justify-center rounded-full"
        >
          <TextSizeIcon />
        </button>
      </header>

      <div ref={scrollRef} className="flex flex-1 flex-col overflow-y-auto">
        {renderBody()}
      </div>

      <nav
        className="flex h-12 shrink-0 items-center border-t font-sans text-sm"
        style={{ borderColor: palette.border }}
      >
        <button
          type="button"
          disabled={prevPosition == null}
          onClick={() => prevPosition != null && onChangeChapter(prevPosition)}
          className="flex h-full flex-1 items-center justify-center gap-1 disabled:opacity-35"
        >
          <ChevronLeftIcon className="h-5 w-5" />
          {t('story.prevChapter')}
        </button>
        <span
          className="shrink-0 px-2 text-xs tabular-nums"
          style={{ color: palette.muted }}
        >
          {story ? `${position}/${story.chapterCount}` : ''}
        </span>
        <button
          type="button"
          disabled={nextPosition == null}
          onClick={() => nextPosition != null && onChangeChapter(nextPosition)}
          className="flex h-full flex-1 items-center justify-center gap-1 disabled:opacity-35"
        >
          {t('story.nextChapter')}
          <ChevronRightIcon className="h-5 w-5" />
        </button>
      </nav>

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
    </div>
  );
}
