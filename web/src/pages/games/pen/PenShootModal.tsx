import { useState, type CSSProperties } from 'react';
import { useTranslation } from 'react-i18next';
import { formatVnd, toast } from '@lib';
import type { PenSide } from '@app-types';
import { penAssets, penShootAssets } from './penAssets';

const DIRECTIONS: PenSide[] = ['left', 'right'];

const QUICK_BETS = [1000, 2000, 5000, 10000, 20000, 50000];

interface PenShootModalProps {
  ken: number;
  amount: number;
  submitting?: boolean;
  onTopUp: () => void;
  onConfirm: (payload: { side: PenSide; betAmount: number }) => void;
  onClose: () => void;
}

const stretchBg: CSSProperties = { backgroundSize: '100% 100%' };

export function PenShootModal({
  ken,
  amount,
  submitting,
  onTopUp,
  onConfirm,
  onClose,
}: PenShootModalProps) {
  const { t } = useTranslation();
  const [direction, setDirection] = useState<PenSide | null>(null);
  const [thousands, setThousands] = useState(String(Math.floor(amount / 1000)));

  const betAmount = Number(thousands) * 1000;
  const overBalance = betAmount > ken;

  const handleConfirm = () => {
    if (!direction) {
      toast.error(t('penGame.errChooseDirection'));
      return;
    }
    if (!betAmount || betAmount < 1000) {
      toast.error(t('penGame.errBetMin'));
      return;
    }
    if (overBalance) {
      toast.error(t('penGame.errInsufficientKen'));
      return;
    }
    onConfirm({ side: direction, betAmount });
  };

  return (
    <div
      onClick={onClose}
      className="absolute inset-0 z-40 flex items-center justify-center bg-black/55 px-4"
    >
      <div
        onClick={(e) => e.stopPropagation()}
        className="pen-panel relative aspect-[960/1639] w-full max-w-[380px]"
      >
        <div className="absolute inset-0 flex flex-col items-center px-[8%] pt-[4%] pb-[4%] text-white">
          <div className="flex items-center justify-center gap-2">
            <img src={penShootAssets.ball} alt="" className="h-9 w-auto object-contain" />
            <span className="text-3xl font-extrabold italic tracking-wider drop-shadow">
              {t('penGame.shoot')}
            </span>
          </div>

          <button
            type="button"
            aria-label={t('penGame.close')}
            onClick={onClose}
            style={{ ...stretchBg, backgroundImage: `url(${penShootAssets.closeBtn})` }}
            className="absolute right-[5%] top-[3%] flex h-9 w-9 items-center justify-center bg-no-repeat transition active:scale-95"
          >
            <img src={penShootAssets.closeIcon} alt="" className="h-4 w-4 object-contain" />
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
            {t('penGame.chooseDirection')}
          </p>

          <div className="mt-[3%] -mx-[5%] grid w-[110%] grid-cols-2 gap-2">
            {DIRECTIONS.map((dir) => {
              const active = direction === dir;
              const skin = active ? penShootAssets.dir.selected : penShootAssets.dir.unselected;
              const arrow = dir === 'left' ? skin.arrowLeft : skin.arrowRight;
              const label = dir === 'left' ? t('penGame.directionLeft') : t('penGame.directionRight');
              return (
                <button
                  key={dir}
                  type="button"
                  aria-pressed={active}
                  onClick={() => setDirection(dir)}
                  style={{ ...stretchBg, backgroundImage: `url(${skin.bg})` }}
                  className="relative aspect-[1116/1332] w-full bg-no-repeat transition active:scale-95"
                >
                  <img
                    src={arrow}
                    alt=""
                    className={`pointer-events-none absolute top-[44%] w-[82%] -translate-y-1/2 object-contain ${
                      dir === 'left' ? 'left-[5%]' : 'right-[5%]'
                    }`}
                  />
                  <img
                    src={penShootAssets.panelBall}
                    alt=""
                    className={`pointer-events-none absolute top-[48%] w-[33%] -translate-y-1/2 object-contain ${
                      dir === 'left' ? 'right-[5%]' : 'left-[5%]'
                    }`}
                  />
                  <img
                    src={skin.mark}
                    alt=""
                    className="pointer-events-none absolute bottom-[4%] left-1/2 w-[23%] -translate-x-1/2 translate-y-1/2 object-contain"
                  />
                  <span
                    style={{ ...stretchBg, backgroundImage: `url(${skin.tab})` }}
                    className="absolute left-1/2 top-0 flex aspect-[1319/400] w-[50%] -translate-x-1/2 items-center justify-center bg-no-repeat text-sm font-extrabold tracking-wider text-white drop-shadow"
                  >
                    {label}
                  </span>
                </button>
              );
            })}
          </div>

          <p className="mt-[2%] text-base font-semibold text-white/90">{t('penGame.kenAmount')}</p>

          <label
            className={`relative mt-[2%] flex w-[72%] cursor-text items-center justify-center rounded-xl border bg-black/20 px-4 py-1.5 ${
              overBalance ? 'border-[#ff5b5b]' : 'border-white/15'
            }`}
          >
            <img
              src={penAssets.kenIcon}
              alt="KEN"
              className="absolute left-4 h-7 w-7 shrink-0"
            />
            <span className="flex items-baseline font-bold text-white">
              <input
                type="text"
                inputMode="numeric"
                aria-label={t('penGame.kenAmount')}
                value={thousands === '' ? '' : formatVnd(Number(thousands))}
                onChange={(e) => setThousands(e.target.value.replace(/\D/g, ''))}
                placeholder="0"
                size={Math.max(thousands.length, 2)}
                className="min-w-[2ch] bg-transparent text-right text-2xl! font-bold leading-none text-white outline-none [font-family:inherit] placeholder:text-white/40"
              />
              <span className="text-2xl font-bold leading-none">.000</span>
            </span>
          </label>

          <div className="mt-[2%] grid w-[88%] grid-cols-3 gap-2">
            {QUICK_BETS.map((bet) => {
              const active = betAmount === bet;
              const disabled = bet > ken;
              return (
                <button
                  key={bet}
                  type="button"
                  disabled={disabled}
                  onClick={() => setThousands(String(bet / 1000))}
                  className={`rounded-lg border py-1 text-sm font-bold transition active:scale-95 disabled:cursor-not-allowed disabled:opacity-35 ${
                    active
                      ? 'border-[#8dffab] bg-[#37c84f]/25 text-white'
                      : 'border-white/15 bg-black/20 text-white/80'
                  }`}
                >
                  {formatVnd(bet)}
                </button>
              );
            })}
          </div>

          <div className="mt-auto flex w-full items-center gap-3 pt-[3%]">
            <button
              type="button"
              onClick={onClose}
              style={{ ...stretchBg, backgroundImage: `url(${penShootAssets.cancelBtn})` }}
              className="flex h-12 flex-[2] items-center justify-center bg-no-repeat text-lg font-extrabold tracking-wide text-[#ff5b5b] drop-shadow transition active:scale-95"
            >
              {t('penGame.cancel')}
            </button>
            <button
              type="button"
              onClick={handleConfirm}
              disabled={submitting || overBalance}
              style={{ ...stretchBg, backgroundImage: `url(${penShootAssets.confirmBtn})` }}
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
