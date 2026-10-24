import { useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import {
  REEL_BACKGROUNDS,
  REEL_MAX_IMAGES,
  REEL_MAX_VIDEO_SECONDS,
  REEL_MIX_COLORS,
  REEL_MIX_ICON_COLORS,
  REEL_MIX_MAX_COLORS,
  type ReelBackgroundKey,
} from '@constants';
import {
  cn,
  formatDuration,
  parseReelMix,
  readableTextColor,
  reelMixKey,
  resolveReelBackground,
  toggleReelMixColor,
} from '@lib';
import type { ReelDraftSlide } from '@app-types';
import { reelBackgroundCss } from '../utils';
import {
  ReelCloseIcon,
  ReelImageIcon,
  ReelPlusIcon,
  ReelVideoIcon,
} from './ReelIcons';

const BACKGROUND_ENTRIES = Object.entries(REEL_BACKGROUNDS);
const MIX_ICON_BACKGROUND = `linear-gradient(135deg, ${REEL_MIX_ICON_COLORS.join(', ')})`;

function ModeCard({
  background,
  icon,
  title,
  hint,
  onClick,
}: {
  background: ReelBackgroundKey;
  icon: ReactNode;
  title: string;
  hint: string;
  onClick: () => void;
}) {
  return (
    <button
      type="button"
      onClick={onClick}
      className="flex aspect-[9/14] w-full flex-col items-center justify-center gap-2.5 rounded-2xl px-2 text-center text-white shadow-lg transition hover:brightness-110"
      style={{ background: reelBackgroundCss(REEL_BACKGROUNDS[background]) }}
    >
      <span className="flex h-12 w-12 items-center justify-center rounded-full bg-white/25 text-xl font-bold">
        {icon}
      </span>
      <span className="text-sm font-semibold">{title}</span>
      <span className="text-[11px] leading-snug text-white/85">{hint}</span>
    </button>
  );
}

export function ReelModePicker({
  onPickText,
  onPickImage,
  onPickVideo,
}: {
  onPickText: () => void;
  onPickImage: () => void;
  onPickVideo: () => void;
}) {
  const { t } = useTranslation();
  return (
    <div className="flex min-h-0 flex-1 items-center justify-center p-4">
      <div className="grid w-full max-w-lg grid-cols-3 gap-3">
        <ModeCard
          background="sky"
          icon="Aa"
          title={t('reel.modeText')}
          hint={t('reel.modeTextHint')}
          onClick={onPickText}
        />
        <ModeCard
          background="sunset"
          icon={<ReelImageIcon className="h-6 w-6" />}
          title={t('reel.modeImage')}
          hint={t('reel.modeImageHint', { count: REEL_MAX_IMAGES })}
          onClick={onPickImage}
        />
        <ModeCard
          background="grape"
          icon={<ReelVideoIcon className="h-6 w-6" />}
          title={t('reel.modeVideo')}
          hint={t('reel.modeVideoHint', { count: REEL_MAX_VIDEO_SECONDS })}
          onClick={onPickVideo}
        />
      </div>
    </div>
  );
}

function Swatch({
  role,
  label,
  selected,
  background,
  onClick,
  children,
}: {
  role: 'radio' | 'checkbox' | 'button';
  label: string;
  selected: boolean;
  background: string;
  onClick: () => void;
  children?: ReactNode;
}) {
  return (
    <button
      type="button"
      role={role === 'button' ? undefined : role}
      aria-checked={role === 'button' ? undefined : selected}
      aria-pressed={role === 'button' ? selected : undefined}
      aria-label={label}
      onClick={onClick}
      className={cn(
        'flex h-9 w-9 shrink-0 items-center justify-center rounded-full border-2 transition',
        selected ? 'scale-110 border-white' : 'border-white/30'
      )}
      style={{ background }}
    >
      {children}
    </button>
  );
}

function ReelMixPalette({
  value,
  onChange,
  onDone,
}: {
  value: string;
  onChange: (key: string) => void;
  onDone: () => void;
}) {
  const { t } = useTranslation();
  const selected = parseReelMix(value) ?? [];
  return (
    <div className="flex flex-col gap-1">
      <p className="text-center text-xs text-white/80">
        {t('reel.mixHint', { count: REEL_MIX_MAX_COLORS })}
      </p>
      <div className="flex items-center gap-2 sm:justify-center">
        <button
          type="button"
          onClick={onDone}
          className="shrink-0 rounded-full bg-white px-3 py-1.5 text-sm font-semibold text-black"
        >
          {t('reel.done')}
        </button>
        <div
          role="group"
          aria-label={t('reel.mixBackground')}
          className="flex min-w-0 gap-2.5 overflow-x-auto px-1 py-1.5 [scrollbar-width:none]"
        >
          {REEL_MIX_COLORS.map((color) => {
            const order = selected.indexOf(color);
            return (
              <Swatch
                key={color}
                role="checkbox"
                label={color}
                selected={order >= 0}
                background={color}
                onClick={() => onChange(reelMixKey(toggleReelMixColor(selected, color)))}
              >
                {order >= 0 && (
                  <span className="text-sm font-bold" style={{ color: readableTextColor(color) }}>
                    {order + 1}
                  </span>
                )}
              </Swatch>
            );
          })}
        </div>
      </div>
    </div>
  );
}

export function ReelBackgroundPicker({
  value,
  onChange,
}: {
  value: string;
  onChange: (key: string) => void;
}) {
  const { t } = useTranslation();
  const [mixing, setMixing] = useState(false);

  if (mixing) {
    return <ReelMixPalette value={value} onChange={onChange} onDone={() => setMixing(false)} />;
  }

  const mixed = parseReelMix(value) != null;
  return (
    <div className="overflow-x-auto px-1 py-1.5 [scrollbar-width:none]">
      <div
        role="radiogroup"
        aria-label={t('reel.background')}
        className="mx-auto flex w-max gap-2.5"
      >
        <Swatch
          role="button"
          label={t('reel.mixBackground')}
          selected={mixed}
          background={mixed ? reelBackgroundCss(resolveReelBackground(value)) : MIX_ICON_BACKGROUND}
          onClick={() => setMixing(true)}
        >
          <ReelPlusIcon className="h-4 w-4 text-white" />
        </Swatch>
        {BACKGROUND_ENTRIES.map(([key, background], index) => (
          <Swatch
            key={key}
            role="radio"
            label={`${t('reel.background')} ${index + 1}`}
            selected={key === value}
            background={reelBackgroundCss(background)}
            onClick={() => onChange(key)}
          />
        ))}
      </div>
    </div>
  );
}

interface ReelSlideStripProps {
  slides: ReelDraftSlide[];
  activeIndex: number;
  onSelect: (index: number) => void;
  onRemove: (id: string) => void;
  onAdd: () => void;
}

export function ReelSlideStrip({
  slides,
  activeIndex,
  onSelect,
  onRemove,
  onAdd,
}: ReelSlideStripProps) {
  const { t } = useTranslation();
  return (
    <div className="flex items-center justify-center gap-3 py-1.5">
      {slides.map((slide, index) => (
        <div key={slide.id} className="relative">
          <button
            type="button"
            onClick={() => onSelect(index)}
            className={cn(
              'block h-16 w-9 overflow-hidden rounded-md border-2 transition',
              index === activeIndex ? 'border-white' : 'border-transparent opacity-60'
            )}
          >
            {slide.media && (
              <img src={slide.media.url} alt="" className="h-full w-full object-cover" />
            )}
          </button>
          {slides.length > 1 && (
            <button
              type="button"
              aria-label={t('reel.removeImage')}
              onClick={() => onRemove(slide.id)}
              className="absolute -top-2 -right-2 flex h-5 w-5 items-center justify-center rounded-full bg-black ring-1 ring-white/50"
            >
              <ReelCloseIcon className="h-3 w-3" />
            </button>
          )}
        </div>
      ))}
      {slides.length < REEL_MAX_IMAGES && (
        <button
          type="button"
          aria-label={t('reel.addImage')}
          onClick={onAdd}
          className="flex h-16 w-9 items-center justify-center rounded-md border-2 border-dashed border-white/40 text-white/80 hover:border-white/70"
        >
          <ReelPlusIcon className="h-4 w-4" />
        </button>
      )}
    </div>
  );
}

export function ReelVideoBar({
  duration,
  onChange,
}: {
  duration?: number;
  onChange: () => void;
}) {
  const { t } = useTranslation();
  return (
    <div className="flex items-center justify-center gap-3 py-1.5 text-sm">
      <span className="flex items-center gap-1.5 rounded-full bg-white/10 px-3 py-1.5">
        <ReelVideoIcon className="h-4 w-4" />
        {duration == null ? t('reel.videoNoPreviewShort') : formatDuration(Math.round(duration))}
      </span>
      <button
        type="button"
        onClick={onChange}
        className="rounded-full bg-white/10 px-3 py-1.5 hover:bg-white/20"
      >
        {t('reel.changeVideo')}
      </button>
    </div>
  );
}
