import { useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import {
  MOMENT_BACKGROUNDS,
  MOMENT_MAX_SLIDES,
  MOMENT_MAX_VIDEO_SECONDS,
  MOMENT_MIX_COLORS,
  MOMENT_MIX_ICON_COLORS,
  MOMENT_MIX_MAX_COLORS,
  type MomentBackgroundKey,
} from '@constants';
import {
  cn,
  formatDuration,
  parseMomentMix,
  readableTextColor,
  momentMixKey,
  resolveMomentBackground,
  toggleMomentMixColor,
} from '@lib';
import type { MomentDraftSlide } from '@app-types';
import { Dialog } from '@components';
import { momentBackgroundCss } from '../utils';
import {
  MomentChevronIcon,
  MomentCloseIcon,
  MomentImageIcon,
  MomentPlusIcon,
  MomentVideoIcon,
} from './MomentIcons';

const BACKGROUND_ENTRIES = Object.entries(MOMENT_BACKGROUNDS);
const MIX_ICON_BACKGROUND = `linear-gradient(135deg, ${MOMENT_MIX_ICON_COLORS.join(', ')})`;

function ModeRow({
  background,
  icon,
  title,
  hint,
  badge,
  onClick,
}: {
  background: MomentBackgroundKey;
  icon: ReactNode;
  title: string;
  hint: string;
  badge?: string;
  onClick: () => void;
}) {
  return (
    <button
      type="button"
      onClick={onClick}
      className="flex w-full items-center gap-3 px-3 py-3 text-left transition-colors hover:bg-gray-50 active:bg-black/[0.06]"
    >
      <span
        className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full text-base font-bold text-white shadow-sm"
        style={{
          background: momentBackgroundCss(MOMENT_BACKGROUNDS[background]),
        }}
      >
        {icon}
      </span>
      <span className="flex min-w-0 flex-1 flex-col gap-0.5">
        <span className="flex items-center gap-1.5 text-[15px] leading-tight font-medium text-black/87">
          {title}
          {badge != null && (
            <span className="rounded-full bg-amber-400 px-1.5 py-px text-[10px] font-bold leading-tight text-white">
              {badge}
            </span>
          )}
        </span>
        <span className="text-[13px] leading-snug text-black/54">{hint}</span>
      </span>
      <MomentChevronIcon
        direction="right"
        className="h-5 w-5 shrink-0 text-black/30"
      />
    </button>
  );
}

export function MomentModePicker({
  videoLocked,
  onClose,
  onPickSlides,
  onPickVideo,
}: {
  videoLocked: boolean;
  onClose: () => void;
  onPickSlides: () => void;
  onPickVideo: () => void;
}) {
  const { t } = useTranslation();
  return (
    <Dialog open onClose={onClose} title={t('moment.createTitle')} showClose>
      <div className="-mx-2 -my-1 divide-y divide-black/8">
        <ModeRow
          background="sunset"
          icon={<MomentImageIcon className="h-5 w-5" />}
          title={t('moment.modeSlides')}
          hint={t('moment.modeSlidesHint', { count: MOMENT_MAX_SLIDES })}
          onClick={onPickSlides}
        />
        <ModeRow
          background="grape"
          icon={<MomentVideoIcon className="h-5 w-5" />}
          title={t('moment.modeVideo')}
          hint={t('moment.modeVideoHint', {
            count: MOMENT_MAX_VIDEO_SECONDS,
          })}
          badge={videoLocked ? t('moment.videoVipBadge') : undefined}
          onClick={onPickVideo}
        />
      </div>
    </Dialog>
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
        'flex h-9 w-9 shrink-0 items-center justify-center rounded-full border-2 border-white shadow-sm transition',
        selected ? 'scale-110 ring-2 ring-ola-primary' : 'ring-1 ring-black/10'
      )}
      style={{ background }}
    >
      {children}
    </button>
  );
}

function MomentMixPalette({
  value,
  onChange,
  onDone,
}: {
  value: string;
  onChange: (key: string) => void;
  onDone: () => void;
}) {
  const { t } = useTranslation();
  const selected = parseMomentMix(value) ?? [];
  return (
    <div className="flex flex-col gap-1">
      <p className="text-center text-xs text-black/54">
        {t('moment.mixHint', { count: MOMENT_MIX_MAX_COLORS })}
      </p>
      <div className="flex flex-col items-center gap-1">
        <div
          role="group"
          aria-label={t('moment.mixBackground')}
          className="flex flex-wrap justify-center gap-2.5 px-1 py-1.5"
        >
          {MOMENT_MIX_COLORS.map((color) => {
            const order = selected.indexOf(color);
            return (
              <Swatch
                key={color}
                role="checkbox"
                label={color}
                selected={order >= 0}
                background={color}
                onClick={() =>
                  onChange(momentMixKey(toggleMomentMixColor(selected, color)))
                }
              >
                {order >= 0 && (
                  <span
                    className="text-sm font-bold"
                    style={{ color: readableTextColor(color) }}
                  >
                    {order + 1}
                  </span>
                )}
              </Swatch>
            );
          })}
        </div>
        <button
          type="button"
          onClick={onDone}
          className="shrink-0 rounded-full bg-ola-primary px-4 py-1.5 text-sm font-semibold text-ola-on-primary"
        >
          {t('moment.done')}
        </button>
      </div>
    </div>
  );
}

export function MomentBackgroundPicker({
  value,
  onChange,
}: {
  value: string;
  onChange: (key: string) => void;
}) {
  const { t } = useTranslation();
  const [mixing, setMixing] = useState(false);

  if (mixing) {
    return (
      <MomentMixPalette
        value={value}
        onChange={onChange}
        onDone={() => setMixing(false)}
      />
    );
  }

  const mixed = parseMomentMix(value) != null;
  return (
    <div className="px-1 py-1.5">
      <div
        role="radiogroup"
        aria-label={t('moment.background')}
        className="flex flex-wrap justify-center gap-2.5"
      >
        <Swatch
          role="button"
          label={t('moment.mixBackground')}
          selected={mixed}
          background={
            mixed
              ? momentBackgroundCss(resolveMomentBackground(value))
              : MIX_ICON_BACKGROUND
          }
          onClick={() => setMixing(true)}
        >
          <MomentPlusIcon className="h-4 w-4 text-white" />
        </Swatch>
        {BACKGROUND_ENTRIES.map(([key, background], index) => (
          <Swatch
            key={key}
            role="radio"
            label={`${t('moment.background')} ${index + 1}`}
            selected={key === value}
            background={momentBackgroundCss(background)}
            onClick={() => onChange(key)}
          />
        ))}
      </div>
    </div>
  );
}

interface MomentSlideStripProps {
  slides: MomentDraftSlide[];
  activeIndex: number;
  onSelect: (index: number) => void;
  onRemove: (id: string) => void;
  onAdd: () => void;
}

export function MomentSlideStrip({
  slides,
  activeIndex,
  onSelect,
  onRemove,
  onAdd,
}: MomentSlideStripProps) {
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
              index === activeIndex
                ? 'border-ola-primary'
                : 'border-transparent opacity-60'
            )}
          >
            {slide.blank ? (
              <span className="block h-full w-full bg-black/8" />
            ) : slide.media ? (
              <img
                src={slide.media.url}
                alt=""
                className="h-full w-full object-cover"
              />
            ) : (
              <span
                className="block h-full w-full"
                style={{
                  background: momentBackgroundCss(
                    resolveMomentBackground(slide.background)
                  ),
                }}
              />
            )}
          </button>
          {slides.length > 1 && (
            <button
              type="button"
              aria-label={t('moment.removeSlide')}
              onClick={() => onRemove(slide.id)}
              className="absolute -top-2 -right-2 flex h-5 w-5 items-center justify-center rounded-full bg-black/70 text-white ring-2 ring-white"
            >
              <MomentCloseIcon className="h-3 w-3" />
            </button>
          )}
        </div>
      ))}
      {slides.length < MOMENT_MAX_SLIDES && (
        <button
          type="button"
          aria-label={t('moment.addSlide')}
          onClick={onAdd}
          className="flex h-16 w-9 items-center justify-center rounded-md border-2 border-dashed border-black/20 text-black/45 transition-colors hover:border-ola-primary hover:text-ola-primary"
        >
          <MomentPlusIcon className="h-4 w-4" />
        </button>
      )}
    </div>
  );
}

export function MomentVideoBar({
  duration,
  onChange,
}: {
  duration?: number;
  onChange: () => void;
}) {
  const { t } = useTranslation();
  return (
    <div className="flex items-center justify-center gap-3 py-1.5 text-sm text-black/70">
      <span className="flex items-center gap-1.5 rounded-full bg-white px-3 py-1.5 shadow-sm ring-1 ring-black/5">
        <MomentVideoIcon className="h-4 w-4" />
        {duration == null
          ? t('moment.videoNoPreviewShort')
          : formatDuration(Math.round(duration))}
      </span>
      <button
        type="button"
        onClick={onChange}
        className="rounded-full bg-white px-3 py-1.5 font-medium text-ola-primary-ink shadow-sm ring-1 ring-black/5 transition-colors hover:bg-ola-primary-light"
      >
        {t('moment.changeVideo')}
      </button>
    </div>
  );
}

export function MomentSlideChoice({
  onPickPhoto,
  onPickColor,
}: {
  onPickPhoto: () => void;
  onPickColor: () => void;
}) {
  const { t } = useTranslation();
  return (
    <div className="absolute inset-0 flex flex-col items-center justify-center gap-3 px-8">
      <p className="mb-1 text-center text-base font-medium text-white/85">
        {t('moment.chooseHint')}
      </p>
      <button
        type="button"
        onClick={onPickPhoto}
        className="flex h-12 w-full max-w-60 items-center justify-center gap-2 rounded-full bg-white text-[15px] font-semibold text-black/80 shadow transition-colors hover:bg-white/90"
      >
        <MomentImageIcon className="h-5 w-5" />
        {t('moment.choosePhoto')}
      </button>
      <button
        type="button"
        onClick={onPickColor}
        className="flex h-12 w-full max-w-60 items-center justify-center gap-2 rounded-full bg-white text-[15px] font-semibold text-black/80 shadow transition-colors hover:bg-white/90"
      >
        <span
          className="flex h-5 w-5 items-center justify-center rounded-full text-[10px] font-bold text-white"
          style={{ background: MIX_ICON_BACKGROUND }}
        >
          Aa
        </span>
        {t('moment.chooseColor')}
      </button>
    </div>
  );
}

export function MomentPhotoBar({ onChange }: { onChange: () => void }) {
  const { t } = useTranslation();
  return (
    <div className="flex items-center justify-center py-1.5 text-sm">
      <button
        type="button"
        onClick={onChange}
        className="flex items-center gap-1.5 rounded-full bg-white px-3 py-1.5 font-medium text-ola-primary-ink shadow-sm ring-1 ring-black/5 transition-colors hover:bg-ola-primary-light"
      >
        <MomentImageIcon className="h-4 w-4" />
        {t('moment.changePhoto')}
      </button>
    </div>
  );
}
