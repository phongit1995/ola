import { useEffect, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import type { StoryChapterItem } from '@app-types';
import type { ReaderPalette } from '../interface';
import { ReaderSheet } from './ReaderSheet';

interface ChapterPickerSheetProps {
  chapters: StoryChapterItem[];
  currentPosition: number;
  palette: ReaderPalette;
  onPick: (position: number) => void;
  onClose: () => void;
}

export function ChapterPickerSheet({
  chapters,
  currentPosition,
  palette,
  onPick,
  onClose,
}: ChapterPickerSheetProps) {
  const { t } = useTranslation();
  const currentRef = useRef<HTMLLIElement>(null);

  useEffect(() => {
    currentRef.current?.scrollIntoView({ block: 'center' });
  }, []);

  return (
    <ReaderSheet title={t('story.toc')} palette={palette} onClose={onClose}>
      <ul className="overflow-y-auto pb-4">
        {chapters.map((chapter) => {
          const current = chapter.position === currentPosition;
          return (
            <li key={chapter.id} ref={current ? currentRef : undefined}>
              <button
                type="button"
                onClick={() => onPick(chapter.position)}
                className="flex w-full items-center gap-2 px-4 py-3 text-left text-sm"
                style={{
                  backgroundColor: current ? palette.background : undefined,
                  borderTop: `1px solid ${palette.border}`,
                }}
              >
                <span
                  className={
                    current
                      ? 'min-w-0 flex-1 truncate font-semibold text-ola-primary-ink'
                      : 'min-w-0 flex-1 truncate'
                  }
                >
                  {chapter.title}
                </span>
                {chapter.isNew && (
                  <span className="shrink-0 rounded bg-ola-accent px-1 text-[10px] leading-4 font-bold text-white uppercase">
                    {t('story.newBadge')}
                  </span>
                )}
              </button>
            </li>
          );
        })}
      </ul>
    </ReaderSheet>
  );
}
