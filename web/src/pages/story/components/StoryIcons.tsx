import { STORY_ICON_GLYPHS, STORY_ICON_STYLE } from '@constants';
import type { StoryIconGlyph, StoryIconName } from '@app-types';

interface StoryIconProps {
  name: StoryIconName;
  className?: string;
  monochrome?: boolean;
}

export function StoryIcon({
  name,
  className = 'h-6 w-6',
  monochrome = false,
}: StoryIconProps) {
  const glyph: StoryIconGlyph = STORY_ICON_GLYPHS[name];
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
