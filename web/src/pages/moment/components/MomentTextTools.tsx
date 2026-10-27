import type { CSSProperties, ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import {
  MOMENT_FONT_LABEL,
  MOMENT_FONTS,
  type MomentFontKey,
} from '@constants';
import {
  cn,
  momentFontSizeLabel,
  momentFontSizeOptions,
  resolveMomentTextFace,
} from '@lib';
import type { MomentOverlay } from '@app-types';
import { MOMENT_FONT_FACE } from '../constants';

function SelectPill({
  label,
  value,
  onChange,
  style,
  className,
  children,
}: {
  label: string;
  value: string;
  onChange: (value: string) => void;
  style?: CSSProperties;
  className?: string;
  children: ReactNode;
}) {
  return (
    <label className="relative flex shrink-0 items-center">
      <select
        value={value}
        aria-label={label}
        title={label}
        onChange={(event) => onChange(event.target.value)}
        className={cn(
          'h-8 cursor-pointer appearance-none truncate rounded-full bg-white/10 pr-7 pl-3 text-sm text-white outline-none transition-colors hover:bg-white/20 focus-visible:ring-2 focus-visible:ring-white/60',
          className
        )}
        style={style}
      >
        {children}
      </select>
      <span className="pointer-events-none absolute right-2.5 text-xs text-white/80">
        ▾
      </span>
    </label>
  );
}

export function MomentTextQuickBar({
  overlay,
  onChange,
  className,
}: {
  overlay: MomentOverlay;
  onChange: (patch: Partial<MomentOverlay>) => void;
  className?: string;
}) {
  const { t } = useTranslation();
  const face = resolveMomentTextFace(overlay);
  const currentScale = Math.round(overlay.scale * 100) / 100;

  return (
    <div
      className={cn(
        'flex max-w-full flex-wrap items-center justify-center gap-1 rounded-[1.25rem] bg-black/60 p-1 text-white shadow-lg backdrop-blur-sm',
        className
      )}
      onPointerDown={(event) => {
        event.stopPropagation();
        if (!(event.target instanceof HTMLSelectElement))
          event.preventDefault();
      }}
    >
      <SelectPill
        label={t('moment.fontSize')}
        value={String(currentScale)}
        onChange={(value) => onChange({ scale: Number(value) })}
      >
        {momentFontSizeOptions(overlay.scale).map((scale) => (
          <option key={scale} value={String(scale)} className="text-black">
            {momentFontSizeLabel(scale)}
          </option>
        ))}
      </SelectPill>
      <SelectPill
        label={t('moment.font')}
        value={face.font}
        onChange={(font) => onChange({ font: font as MomentFontKey })}
        className="w-28"
        style={{
          fontFamily: MOMENT_FONT_FACE[face.font].family,
          fontWeight: MOMENT_FONT_FACE[face.font].weight,
        }}
      >
        {MOMENT_FONTS.map((font) => (
          <option
            key={font}
            value={font}
            className="text-black"
            style={{ fontFamily: MOMENT_FONT_FACE[font].family }}
          >
            {t(MOMENT_FONT_LABEL[font])}
          </option>
        ))}
      </SelectPill>
    </div>
  );
}
