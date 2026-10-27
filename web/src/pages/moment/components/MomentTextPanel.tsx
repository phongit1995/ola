import {
  useEffect,
  useLayoutEffect,
  useRef,
  useState,
  type MouseEvent,
  type ReactNode,
} from 'react';
import { useTranslation } from 'react-i18next';
import { ConfirmDialog } from '@components';
import {
  MOMENT_FONT_CAPS,
  MOMENT_MAX_OVERLAY_CHARS,
  MOMENT_OVERLAY_STYLE,
  MOMENT_TEXT_ALIGN,
  MOMENT_TEXT_COLORS,
} from '@constants';
import { cn, nextMomentOption, resolveMomentTextFace } from '@lib';
import type { MomentOverlay } from '@app-types';
import { overlayFontStyle, overlayTextStyle } from '../utils';
import {
  MomentAlignIcon,
  MomentTextStyleIcon,
  MomentTrashIcon,
} from './MomentIcons';
import { MomentTextQuickBar } from './MomentTextTools';

const OVERLAY_STYLES = Object.values(MOMENT_OVERLAY_STYLE);
const TEXT_ALIGNS = Object.values(MOMENT_TEXT_ALIGN);

function ToolButton({
  label,
  active,
  disabled,
  onClick,
  children,
}: {
  label: string;
  active?: boolean;
  disabled?: boolean;
  onClick: () => void;
  children: ReactNode;
}) {
  return (
    <button
      type="button"
      aria-label={label}
      aria-pressed={active}
      title={label}
      disabled={disabled}
      onClick={onClick}
      className={cn(
        'flex h-9 min-w-9 items-center justify-center rounded-full px-2.5 text-sm font-semibold transition-colors disabled:opacity-35',
        active
          ? 'bg-white text-black'
          : 'bg-black/40 text-white enabled:hover:bg-black/60'
      )}
    >
      {children}
    </button>
  );
}

interface MomentTextPanelProps {
  overlay: MomentOverlay;
  onChange: (patch: Partial<MomentOverlay>) => void;
  onDone: () => void;
  onDelete: () => void;
}

export function MomentTextPanel({
  overlay,
  onChange,
  onDone,
  onDelete,
}: MomentTextPanelProps) {
  const { t } = useTranslation();
  const inputRef = useRef<HTMLTextAreaElement>(null);
  const paletteRef = useRef<HTMLDivElement>(null);
  const [colorsOpen, setColorsOpen] = useState(false);
  const [deleteOpen, setDeleteOpen] = useState(false);
  const face = resolveMomentTextFace(overlay);
  const caps = MOMENT_FONT_CAPS[face.font];

  useEffect(() => {
    inputRef.current?.focus();
  }, []);

  useEffect(() => {
    if (colorsOpen) paletteRef.current?.scrollIntoView({ block: 'nearest' });
  }, [colorsOpen]);

  function doneOnBackdrop(event: MouseEvent<HTMLDivElement>) {
    if (event.target === event.currentTarget) onDone();
  }

  useLayoutEffect(() => {
    const input = inputRef.current;
    if (input == null) return;
    input.style.height = 'auto';
    input.style.height = `${input.scrollHeight}px`;
  }, [
    overlay.text,
    overlay.scale,
    overlay.font,
    overlay.bold,
    overlay.italic,
    overlay.style,
  ]);

  return (
    <div
      className="absolute inset-0 flex flex-col bg-black/55"
      onPointerDown={(event) => event.stopPropagation()}
    >
      <div className="flex justify-end p-3">
        <button
          type="button"
          onClick={onDone}
          className="rounded-full bg-white px-4 py-1.5 text-sm font-semibold text-black"
        >
          {t('moment.done')}
        </button>
      </div>

      <div
        className="flex min-h-0 flex-1 flex-col items-center overflow-y-auto px-[5%] pb-3 scrollbar-none"
        onClick={doneOnBackdrop}
      >
        <div
          className="my-auto flex w-full flex-col items-center"
          onClick={doneOnBackdrop}
        >
          <textarea
            ref={inputRef}
            value={overlay.text}
            rows={1}
            maxLength={MOMENT_MAX_OVERLAY_CHARS}
            placeholder={t('moment.textPlaceholder')}
            onChange={(event) => onChange({ text: event.target.value })}
            onKeyDown={(event) => {
              if (event.key === 'Escape') {
                event.stopPropagation();
                onDone();
              }
            }}
            className="shrink-0 resize-none overflow-hidden border-none outline-none placeholder:text-white/60"
            style={{
              ...overlayFontStyle(overlay),
              ...overlayTextStyle(overlay),
              width: `${overlay.w * 100}%`,
            }}
          />
          <div className="mt-1.5 flex w-full shrink-0 flex-col items-center gap-2">
            <div className="flex max-w-full flex-wrap items-center justify-center gap-1.5">
              <ToolButton
                label={t('moment.bold')}
                active={face.bold}
                disabled={!caps.bold}
                onClick={() => onChange({ font: face.font, bold: !face.bold })}
              >
                <span className="text-base font-extrabold">B</span>
              </ToolButton>
              <ToolButton
                label={t('moment.italic')}
                active={face.italic}
                disabled={!caps.italic}
                onClick={() =>
                  onChange({ font: face.font, italic: !face.italic })
                }
              >
                <span className="font-serif text-base italic">I</span>
              </ToolButton>
              <ToolButton
                label={t('moment.textStyle')}
                onClick={() =>
                  onChange({
                    style: nextMomentOption(OVERLAY_STYLES, overlay.style),
                  })
                }
              >
                <MomentTextStyleIcon />
              </ToolButton>
              <ToolButton
                label={t('moment.align')}
                onClick={() =>
                  onChange({
                    align: nextMomentOption(TEXT_ALIGNS, overlay.align),
                  })
                }
              >
                <MomentAlignIcon align={overlay.align} />
              </ToolButton>
              <button
                type="button"
                aria-label={t('moment.textColor')}
                aria-expanded={colorsOpen}
                title={t('moment.textColor')}
                onClick={() => setColorsOpen((open) => !open)}
                className={cn(
                  'h-8 w-8 rounded-full border-2 border-white/80 shadow transition-transform',
                  colorsOpen && 'scale-110 border-white'
                )}
                style={{ backgroundColor: overlay.color }}
              />
            </div>
            <div className="flex max-w-full flex-wrap items-center justify-center gap-1.5">
              <MomentTextQuickBar overlay={overlay} onChange={onChange} />
              <ToolButton
                label={t('moment.deleteText')}
                onClick={() => setDeleteOpen(true)}
              >
                <MomentTrashIcon className="h-5 w-5" />
              </ToolButton>
            </div>
            {colorsOpen && (
              <div
                ref={paletteRef}
                className="flex justify-center"
                role="radiogroup"
                aria-label={t('moment.textColor')}
              >
                <div className="flex flex-wrap justify-center gap-1.5 rounded-3xl bg-black/80 p-1.5 shadow-lg backdrop-blur-sm">
                  {MOMENT_TEXT_COLORS.map((color) => (
                    <button
                      key={color}
                      type="button"
                      role="radio"
                      aria-checked={color === overlay.color}
                      aria-label={color}
                      onClick={() => {
                        onChange({ color });
                        setColorsOpen(false);
                      }}
                      className={cn(
                        'h-7 w-7 shrink-0 rounded-full border-2 transition',
                        color === overlay.color
                          ? 'scale-110 border-white'
                          : 'border-white/40'
                      )}
                      style={{ backgroundColor: color }}
                    />
                  ))}
                </div>
              </div>
            )}
          </div>
        </div>
      </div>

      <ConfirmDialog
        open={deleteOpen}
        title={t('moment.deleteTextTitle')}
        message={t('moment.deleteTextMessage')}
        confirmLabel={t('common.delete')}
        cancelLabel={t('common.cancel')}
        danger
        onConfirm={() => {
          setDeleteOpen(false);
          onDelete();
        }}
        onCancel={() => setDeleteOpen(false)}
      />
    </div>
  );
}
