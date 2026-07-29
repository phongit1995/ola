import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { formatVnd } from '@lib';
import type { PenSide } from '@app-types';
import { penAssets } from './penAssets';
import { bgImage } from './penUi';

const DIRECTIONS: PenSide[] = ['left', 'right'];

interface PenModalShellProps {
  panelAspect: string;
  titleIcon: string;
  titleIconClassName?: string;
  title: string;
  closeBtn: string;
  closeIcon: string;
  onClose: () => void;
  children: ReactNode;
}

export function PenModalShell({
  panelAspect,
  titleIcon,
  titleIconClassName = 'h-9',
  title,
  closeBtn,
  closeIcon,
  onClose,
  children,
}: PenModalShellProps) {
  const { t } = useTranslation();
  return (
    <div
      onClick={onClose}
      className="absolute inset-0 z-40 flex items-center justify-center bg-black/55 px-4"
    >
      <div
        onClick={(e) => e.stopPropagation()}
        className={`pen-panel relative w-full max-w-[380px] ${panelAspect}`}
      >
        <div className="absolute inset-0 flex flex-col items-center px-[8%] pt-[4%] pb-[4%] text-white">
          <div className="flex items-center justify-center gap-2">
            <img
              src={titleIcon}
              alt=""
              className={`w-auto object-contain ${titleIconClassName}`}
            />
            <span className="text-3xl font-extrabold italic tracking-wider drop-shadow">
              {title}
            </span>
          </div>

          <button
            type="button"
            aria-label={t('penGame.close')}
            onClick={onClose}
            style={bgImage(closeBtn)}
            className="absolute right-[5%] top-[3%] flex h-9 w-9 items-center justify-center bg-no-repeat transition active:scale-95"
          >
            <img src={closeIcon} alt="" className="h-4 w-4 object-contain" />
          </button>

          {children}
        </div>
      </div>
    </div>
  );
}

interface PenKenRowProps {
  ken: number;
  onTopUp: () => void;
}

export function PenKenRow({ ken, onTopUp }: PenKenRowProps) {
  const { t } = useTranslation();
  return (
    <div className="mt-[3%] flex items-center gap-2 rounded-xl bg-black/30 px-3 py-1.5">
      <img src={penAssets.kenIcon} alt="KEN" className="h-6 w-6 shrink-0" />
      <span className="min-w-[68px] text-center text-xl font-bold">
        {formatVnd(ken)}
      </span>
      <button
        type="button"
        aria-label={t('penGame.topUp')}
        onClick={onTopUp}
        style={bgImage(penAssets.plusBtn)}
        className="flex h-8 w-8 items-center justify-center bg-no-repeat transition active:scale-95"
      >
        <img
          src={penAssets.plusIcon}
          alt=""
          className="h-3.5 w-3.5 object-contain"
        />
      </button>
    </div>
  );
}

export interface PenDirSkin {
  bg: string;
  tab: string;
  arrowLeft: string;
  arrowRight: string;
  mark?: string;
}

export interface PenDirLayout {
  buttonAspect: string;
  arrowClassName: string;
  arrowInset: { left: string; right: string };
  centerClassName: string;
  centerInset: { left: string; right: string };
  markClassName: string;
  tabClassName: string;
}

interface PenDirectionPickerProps {
  value: PenSide | null;
  onSelect: (side: PenSide) => void;
  selected: PenDirSkin;
  unselected: PenDirSkin;
  center: { left: string; right: string };
  layout: PenDirLayout;
}

export function PenDirectionPicker({
  value,
  onSelect,
  selected,
  unselected,
  center,
  layout,
}: PenDirectionPickerProps) {
  const { t } = useTranslation();
  return (
    <div className="mt-[3%] -mx-[5%] grid w-[110%] grid-cols-2 gap-2">
      {DIRECTIONS.map((dir) => {
        const active = value === dir;
        const skin = active ? selected : unselected;
        const left = dir === 'left';
        const label = left
          ? t('penGame.directionLeft')
          : t('penGame.directionRight');
        return (
          <button
            key={dir}
            type="button"
            aria-pressed={active}
            onClick={() => onSelect(dir)}
            style={bgImage(skin.bg)}
            className={`relative w-full bg-no-repeat transition active:scale-95 ${layout.buttonAspect}`}
          >
            <img
              src={left ? skin.arrowLeft : skin.arrowRight}
              alt=""
              className={`pointer-events-none absolute -translate-y-1/2 object-contain ${
                layout.arrowClassName
              } ${left ? layout.arrowInset.left : layout.arrowInset.right}`}
            />
            <img
              src={left ? center.left : center.right}
              alt=""
              className={`pointer-events-none absolute -translate-y-1/2 object-contain ${
                layout.centerClassName
              } ${left ? layout.centerInset.left : layout.centerInset.right}`}
            />
            {skin.mark != null && (
              <img
                src={skin.mark}
                alt=""
                className={`pointer-events-none absolute left-1/2 -translate-x-1/2 translate-y-1/2 object-contain ${layout.markClassName}`}
              />
            )}
            <span
              style={bgImage(skin.tab)}
              className={`absolute left-1/2 top-0 flex -translate-x-1/2 items-center justify-center bg-no-repeat text-sm font-extrabold tracking-wider text-white drop-shadow ${layout.tabClassName}`}
            >
              {label}
            </span>
          </button>
        );
      })}
    </div>
  );
}

interface PenModalActionsProps {
  className?: string;
  cancelBg: string;
  confirmBg: string;
  onCancel: () => void;
  onConfirm: () => void;
  confirmDisabled?: boolean;
}

export function PenModalActions({
  className = '',
  cancelBg,
  confirmBg,
  onCancel,
  onConfirm,
  confirmDisabled = false,
}: PenModalActionsProps) {
  const { t } = useTranslation();
  return (
    <div className={`flex w-full items-center gap-3 ${className}`}>
      <button
        type="button"
        onClick={onCancel}
        style={bgImage(cancelBg)}
        className="flex h-12 flex-[2] items-center justify-center bg-no-repeat text-lg font-extrabold tracking-wide text-[#ff5b5b] drop-shadow transition active:scale-95"
      >
        {t('penGame.cancel')}
      </button>
      <button
        type="button"
        onClick={onConfirm}
        disabled={confirmDisabled}
        style={bgImage(confirmBg)}
        className="flex h-12 flex-[3] items-center justify-center bg-no-repeat text-lg font-extrabold tracking-wide drop-shadow transition active:scale-95 disabled:opacity-60"
      >
        {t('penGame.confirm')}
      </button>
    </div>
  );
}
