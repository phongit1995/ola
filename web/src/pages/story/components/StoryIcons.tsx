import { cn } from '@lib';
import { STORY_ICON_GLYPHS, STORY_ICON_STYLE } from '@constants';
import type { StoryIconGlyph, StoryIconName } from '@app-types';
import bookIcon from '@/assets/icons/story/book.svg';
import emojiEventsIcon from '@/assets/icons/story/emoji-events.svg';
import libraryBooksIcon from '@/assets/icons/story/library-books.svg';
import searchIcon from '@/assets/icons/story/search.svg';
import filterAltIcon from '@/assets/icons/story/filter-alt.svg';

interface StoryIconProps {
  name: StoryIconName;
  className?: string;
  monochrome?: boolean;
}

const STORY_ICON_ASSETS: Partial<Record<StoryIconName, string>> = {
  book: bookIcon,
  emojiEvents: emojiEventsIcon,
  libraryBooks: libraryBooksIcon,
  search: searchIcon,
  filterAlt: filterAltIcon,
};

export function StoryIcon({
  name,
  className = 'h-6 w-6',
  monochrome = false,
}: StoryIconProps) {
  const asset = STORY_ICON_ASSETS[name];
  if (asset) {
    return (
      <span
        className={cn('inline-block', className)}
        aria-hidden="true"
        style={{
          backgroundColor: 'currentColor',
          maskImage: `url("${asset}")`,
          maskPosition: 'center',
          maskRepeat: 'no-repeat',
          maskSize: 'contain',
          WebkitMaskImage: `url("${asset}")`,
          WebkitMaskPosition: 'center',
          WebkitMaskRepeat: 'no-repeat',
          WebkitMaskSize: 'contain',
        }}
      />
    );
  }

  const glyph: StoryIconGlyph | undefined =
    STORY_ICON_GLYPHS[name as keyof typeof STORY_ICON_GLYPHS];
  if (!glyph) return null;
  const accent = monochrome
    ? 'currentColor'
    : 'var(--story-icon-accent, var(--color-ola-primary, currentColor))';
  return (
    <svg
      viewBox={glyph.viewBox}
      className={className}
      fill="none"
      aria-hidden="true"
      focusable="false"
    >
      {glyph.tint && (
        <path
          d={glyph.tint}
          fill={accent}
          opacity={STORY_ICON_STYLE.tintOpacity}
        />
      )}
      <path
        d={glyph.outline}
        fill="none"
        stroke="currentColor"
        strokeWidth={STORY_ICON_STYLE.outlineWidth}
        strokeLinecap="round"
        strokeLinejoin="round"
      />
      {glyph.detail && (
        <path
          d={glyph.detail}
          fill="none"
          stroke="currentColor"
          strokeWidth={STORY_ICON_STYLE.detailWidth}
          strokeLinecap="round"
          strokeLinejoin="round"
        />
      )}
      {glyph.accent && (
        <path
          d={glyph.accent}
          fill="none"
          stroke={accent}
          strokeWidth={STORY_ICON_STYLE.accentWidth}
          strokeLinecap="round"
          strokeLinejoin="round"
        />
      )}
      {glyph.accentFill && <path d={glyph.accentFill} fill={accent} />}
    </svg>
  );
}
