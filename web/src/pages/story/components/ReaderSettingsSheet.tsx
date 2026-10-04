import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { cn, STORY_FONT_SIZE, STORY_LINE_HEIGHTS } from '@lib';
import { useStoryPrefsStore } from '@ola/shared/stores/story/storyPrefsStore';
import type { StoryReaderFont } from '@app-types';
import {
  READER_FONTS,
  READER_PALETTES,
  READER_THEME_ORDER,
} from '../constants';
import type { ReaderPalette } from '../interface';
import { ReaderSheet } from './ReaderSheet';

const FONT_ORDER: StoryReaderFont[] = ['serif', 'sans'];

interface SettingRowProps {
  label: string;
  palette: ReaderPalette;
  children: ReactNode;
}

function SettingRow({ label, palette, children }: SettingRowProps) {
  return (
    <div
      className="flex flex-col gap-2 border-t py-3 first:border-t-0"
      style={{ borderColor: palette.border }}
    >
      <span className="text-[13px]" style={{ color: palette.muted }}>
        {label}
      </span>
      {children}
    </div>
  );
}

interface SegmentProps {
  active: boolean;
  palette: ReaderPalette;
  onClick: () => void;
  children: ReactNode;
  fontFamily?: string;
}

function Segment({
  active,
  palette,
  onClick,
  children,
  fontFamily,
}: SegmentProps) {
  return (
    <button
      type="button"
      aria-pressed={active}
      onClick={onClick}
      className={cn(
        'h-9 flex-1 rounded-lg border text-sm',
        active && 'border-ola-primary font-semibold text-ola-primary-ink'
      )}
      style={{
        borderColor: active ? undefined : palette.border,
        backgroundColor: palette.background,
        fontFamily,
      }}
    >
      {children}
    </button>
  );
}

interface ReaderSettingsSheetProps {
  palette: ReaderPalette;
  onClose: () => void;
}

export function ReaderSettingsSheet({
  palette,
  onClose,
}: ReaderSettingsSheetProps) {
  const { t } = useTranslation();
  const reader = useStoryPrefsStore((state) => state.reader);
  const setReader = useStoryPrefsStore((state) => state.setReader);

  return (
    <ReaderSheet
      title={t('story.displayOptions')}
      palette={palette}
      onClose={onClose}
    >
      <div className="overflow-y-auto px-4 pb-5">
        <SettingRow label={t('story.theme')} palette={palette}>
          <div className="flex gap-3">
            {READER_THEME_ORDER.map((theme) => {
              const swatch = READER_PALETTES[theme];
              const active = reader.theme === theme;
              return (
                <button
                  key={theme}
                  type="button"
                  aria-pressed={active}
                  onClick={() => setReader({ theme })}
                  className="flex flex-col items-center gap-1 text-[11px]"
                >
                  <span
                    className={cn(
                      'h-9 w-9 rounded-full border',
                      active && 'ring-2 ring-ola-primary ring-offset-2'
                    )}
                    style={{
                      backgroundColor: swatch.background,
                      borderColor: swatch.border,
                    }}
                  />
                  {t(swatch.labelKey)}
                </button>
              );
            })}
          </div>
        </SettingRow>
        <SettingRow label={t('story.font')} palette={palette}>
          <div className="flex gap-2">
            {FONT_ORDER.map((font) => (
              <Segment
                key={font}
                active={reader.font === font}
                palette={palette}
                fontFamily={READER_FONTS[font].family}
                onClick={() => setReader({ font })}
              >
                {t(READER_FONTS[font].labelKey)}
              </Segment>
            ))}
          </div>
        </SettingRow>
        <SettingRow label={t('story.fontSize')} palette={palette}>
          <div className="flex items-center gap-3">
            <button
              type="button"
              aria-label={t('story.decreaseFont')}
              disabled={reader.fontSize <= STORY_FONT_SIZE.min}
              onClick={() =>
                setReader({ fontSize: reader.fontSize - STORY_FONT_SIZE.step })
              }
              className="h-9 w-12 rounded-lg border text-sm disabled:opacity-40"
              style={{
                borderColor: palette.border,
                backgroundColor: palette.background,
              }}
            >
              A−
            </button>
            <span className="min-w-10 flex-1 text-center text-base font-semibold">
              {reader.fontSize}
            </span>
            <button
              type="button"
              aria-label={t('story.increaseFont')}
              disabled={reader.fontSize >= STORY_FONT_SIZE.max}
              onClick={() =>
                setReader({ fontSize: reader.fontSize + STORY_FONT_SIZE.step })
              }
              className="h-9 w-12 rounded-lg border text-base disabled:opacity-40"
              style={{
                borderColor: palette.border,
                backgroundColor: palette.background,
              }}
            >
              A+
            </button>
          </div>
        </SettingRow>
        <SettingRow label={t('story.lineHeight')} palette={palette}>
          <div className="flex gap-2">
            {STORY_LINE_HEIGHTS.map((lineHeight) => (
              <Segment
                key={lineHeight}
                active={reader.lineHeight === lineHeight}
                palette={palette}
                onClick={() => setReader({ lineHeight })}
              >
                {lineHeight.toFixed(1)}
              </Segment>
            ))}
          </div>
        </SettingRow>
      </div>
    </ReaderSheet>
  );
}
