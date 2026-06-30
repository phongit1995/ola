import { useState, type CSSProperties } from 'react';
import { useTranslation } from 'react-i18next';
import { formatVnd, toast } from '@lib';
import type { PenSide } from '@app-types';
import { penAssets, penCatchAssets } from './penAssets';

const DIRECTIONS: PenSide[] = ['left', 'right'];

interface PenCatchModalProps {
  ken: number;
  betAmount: number;
  submitting?: boolean;
  onTopUp: () => void;
  onConfirm: (side: PenSide) => void;
  onClose: () => void;
}

const stretchBg: CSSProperties = { backgroundSize: '100% 100%' };

export function PenCatchModal({
  ken,
  betAmount,
  submitting,
  onTopUp,
  onConfirm,
  onClose,
}: PenCatchModalProps) {
  const { t } = useTranslation();
  const [direction, setDirection] = useState<PenSide | null>(null);

  const handleConfirm = () => {
    if (!direction) {
      toast.error(t('penGame.errChooseCatchDirection'));
      return;
    }
    onConfirm(direction);
  };

  return (
    <div
      onClick={onClose}
      className="absolute inset-0 z-40 flex items-center justify-center bg-black/55 px-4"
    >
      <div
        onClick={(e) => e.stopPropagation()}
        className="pen-panel relative aspect-[943/1250] w-full max-w-[380px]"
      >
        <div className="absolute inset-0 flex flex-col items-center px-[8%] pt-[4%] pb-[4%] text-white">
          <div className="flex items-center justify-center gap-2">
            <img src={penCatchAssets.gloveEffect} alt="" className="h-14 w-auto object-contain" />
            <span className="text-3xl font-extrabold italic tracking-wider drop-shadow">
              {t('penGame.catchTitle')}
            </span>
          </div>

          <button
            type="button"
            aria-label={t('penGame.close')}
            onClick={onClose}
            style={{ ...stretchBg, backgroundImage: `url(${penCatchAssets.closeBtn})` }}
            className="absolute right-[5%] top-[3%] flex h-9 w-9 items-center justify-center bg-no-repeat transition active:scale-95"
          >
            <img src={penCatchAssets.closeIcon} alt="" className="h-4 w-4 object-contain" />
          </button>

          <div className="mt-[3%] flex items-center gap-2 rounded-xl bg-black/30 px-3 py-1.5">
            <img src={penAssets.kenIcon} alt="KEN" className="h-6 w-6 shrink-0" />
            <span className="min-w-[68px] text-center text-xl font-bold">{formatVnd(ken)}</span>
            <button
              type="button"
              aria-label={t('penGame.topUp')}
              onClick={onTopUp}
              style={{ ...stretchBg, backgroundImage: `url(${penAssets.plusBtn})` }}
              className="flex h-8 w-8 items-center justify-center bg-no-repeat transition active:scale-95"
            >
              <img src={penAssets.plusIcon} alt="" className="h-3.5 w-3.5 object-contain" />
            </button>
          </div>

          <p className="mt-[3%] text-base font-semibold text-white/90">
            {t('penGame.chooseCatchDirection')}
          </p>

          <div className="mt-[3%] -mx-[5%] grid w-[110%] grid-cols-2 gap-2">
            {DIRECTIONS.map((dir) => {
              const active = direction === dir;
              const skin = active ? penCatchAssets.dir.selected : penCatchAssets.dir.unselected;
              const arrow = dir === 'left' ? skin.arrowLeft : skin.arrowRight;
              const glove = dir === 'left' ? penCatchAssets.gloveLeft : penCatchAssets.gloveRight;
              const label = dir === 'left' ? t('penGame.directionLeft') : t('penGame.directionRight');
              return (
                <button
                  key={dir}
                  type="button"
                  aria-pressed={active}
                  onClick={() => setDirection(dir)}
                  style={{ ...stretchBg, backgroundImage: `url(${skin.bg})` }}
                  className="relative aspect-[1082/1220] w-full bg-no-repeat transition active:scale-95"
                >
                  <img
                    src={arrow}
                    alt=""
                    className={`pointer-events-none absolute top-[46%] w-[56%] -translate-y-1/2 object-contain ${
                      dir === 'left' ? 'left-[2%]' : 'right-[2%]'
                    }`}
                  />
                  <img
                    src={glove}
                    alt=""
                    className={`pointer-events-none absolute top-[48%] w-[40%] -translate-y-1/2 object-contain ${
                      dir === 'left' ? 'right-[4%]' : 'left-[4%]'
                    }`}
                  />
                  {active && (
                    <img
                      src={penCatchAssets.dir.selected.mark}
                      alt=""
                      className="pointer-events-none absolute bottom-[4%] left-1/2 w-[22%] -translate-x-1/2 translate-y-1/2 object-contain"
                    />
                  )}
                  <span
                    style={{ ...stretchBg, backgroundImage: `url(${skin.tab})` }}
                    className="absolute left-1/2 top-0 flex aspect-[1063/360] w-[50%] -translate-x-1/2 items-center justify-center bg-no-repeat text-sm font-extrabold tracking-wider text-white drop-shadow"
                  >
                    {label}
                  </span>
                </button>
              );
            })}
          </div>

          <div className="mt-auto flex flex-col items-center gap-1 pt-[4%]">
            <span className="text-base font-semibold text-white/90">{t('penGame.catchBet')}</span>
            <span className="flex items-center gap-2">
              <img src={penAssets.kenIcon} alt="KEN" className="h-6 w-6 shrink-0" />
              <span className="text-2xl font-bold text-white">{formatVnd(betAmount)}</span>
            </span>
          </div>

          <div className="mt-[3%] flex w-full items-center gap-3">
            <button
              type="button"
              onClick={onClose}
              style={{ ...stretchBg, backgroundImage: `url(${penCatchAssets.cancelBtn})` }}
              className="flex h-12 flex-[2] items-center justify-center bg-no-repeat text-lg font-extrabold tracking-wide text-[#ff5b5b] drop-shadow transition active:scale-95"
            >
              {t('penGame.cancel')}
            </button>
            <button
              type="button"
              onClick={handleConfirm}
              disabled={submitting}
              style={{ ...stretchBg, backgroundImage: `url(${penCatchAssets.confirmBtn})` }}
              className="flex h-12 flex-[3] items-center justify-center bg-no-repeat text-lg font-extrabold tracking-wide drop-shadow transition active:scale-95 disabled:opacity-60"
            >
              {t('penGame.confirm')}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
