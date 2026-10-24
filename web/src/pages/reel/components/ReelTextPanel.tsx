import { useEffect, useLayoutEffect, useRef, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import {
  REEL_FONT_LABEL,
  REEL_FONTS,
  REEL_MAX_OVERLAY_CHARS,
  REEL_OVERLAY_STYLE,
  REEL_TEXT_ALIGN,
  REEL_TEXT_COLORS,
} from '@constants';
import { cn, nextReelOption, resolveReelFont } from '@lib';
import type { ReelOverlay } from '@app-types';
import { overlayFontStyle, overlayTextStyle } from '../utils';
import { ReelAlignIcon, ReelTextStyleIcon } from './ReelIcons';

const OVERLAY_STYLES = Object.values(REEL_OVERLAY_STYLE);
const TEXT_ALIGNS = Object.values(REEL_TEXT_ALIGN);

function ToolButton({
  label,
  onClick,
  children,
}: {
  label: string;
  onClick: () => void;
  children: ReactNode;
}) {
  return (
    <button
      type="button"
      aria-label={label}
      title={label}
      onClick={onClick}
      className="flex h-9 min-w-9 items-center justify-center rounded-full bg-black/40 px-2.5 text-sm font-semibold text-white hover:bg-black/60"
    >
      {children}
    </button>
  );
}

interface ReelTextPanelProps {
  overlay: ReelOverlay;
  onChange: (patch: Partial<ReelOverlay>) => void;
  onDone: () => void;
}

export function ReelTextPanel({ overlay, onChange, onDone }: ReelTextPanelProps) {
  const { t } = useTranslation();
  const inputRef = useRef<HTMLTextAreaElement>(null);
  const font = resolveReelFont(overlay.font);

  useEffect(() => {
    inputRef.current?.focus();
  }, []);

  useLayoutEffect(() => {
    const input = inputRef.current;
    if (input == null) return;
    input.style.height = 'auto';
    input.style.height = `${input.scrollHeight}px`;
  }, [overlay.text, overlay.scale, overlay.font, overlay.style]);

  return (
    <div
      className="absolute inset-0 flex flex-col bg-black/55"
      onPointerDown={(event) => event.stopPropagation()}
    >
      <div className="flex items-center gap-1.5 p-3">
        <ToolButton
          label={t('reel.font')}
          onClick={() => onChange({ font: nextReelOption(REEL_FONTS, font) })}
        >
          {t(REEL_FONT_LABEL[font])}
        </ToolButton>
        <ToolButton
          label={t('reel.textStyle')}
          onClick={() => onChange({ style: nextReelOption(OVERLAY_STYLES, overlay.style) })}
        >
          <ReelTextStyleIcon />
        </ToolButton>
        <ToolButton
          label={t('reel.align')}
          onClick={() => onChange({ align: nextReelOption(TEXT_ALIGNS, overlay.align) })}
        >
          <ReelAlignIcon align={overlay.align} />
        </ToolButton>
        <span className="flex-1" />
        <button
          type="button"
          onClick={onDone}
          className="rounded-full bg-white px-4 py-1.5 text-sm font-semibold text-black"
        >
          {t('reel.done')}
        </button>
      </div>

      <div
        className="flex min-h-0 flex-1 items-center justify-center px-[5%]"
        onClick={(event) => {
          if (event.target === event.currentTarget) onDone();
        }}
      >
        <textarea
          ref={inputRef}
          value={overlay.text}
          rows={1}
          maxLength={REEL_MAX_OVERLAY_CHARS}
          placeholder={t('reel.textPlaceholder')}
          onChange={(event) => onChange({ text: event.target.value })}
          onKeyDown={(event) => {
            if (event.key === 'Escape') {
              event.stopPropagation();
              onDone();
            }
          }}
          className="max-h-full resize-none overflow-hidden border-none outline-none placeholder:text-white/60"
          style={{
            ...overlayFontStyle(overlay),
            ...overlayTextStyle(overlay),
            width: `${overlay.w * 100}%`,
          }}
        />
      </div>

      <div
        className="flex gap-2 overflow-x-auto p-3 [scrollbar-width:none]"
        role="radiogroup"
        aria-label={t('reel.textColor')}
      >
        {REEL_TEXT_COLORS.map((color) => (
          <button
            key={color}
            type="button"
            role="radio"
            aria-checked={color === overlay.color}
            aria-label={color}
            onClick={() => onChange({ color })}
            className={cn(
              'h-7 w-7 shrink-0 rounded-full border-2 transition',
              color === overlay.color ? 'scale-110 border-white' : 'border-white/40'
            )}
            style={{ backgroundColor: color }}
          />
        ))}
      </div>
    </div>
  );
}
