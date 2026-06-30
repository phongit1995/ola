import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { formatVnd, toast } from '@lib';
import type { PenSide } from '@app-types';
import { penAssets, penShootAssets } from './penAssets';
import {
  PenDirectionPicker,
  PenKenRow,
  PenModalActions,
  PenModalShell,
  type PenDirLayout,
} from './penModalParts';

const QUICK_BETS = [1000, 2000, 5000, 10000, 20000, 50000];

const SHOOT_DIR_LAYOUT: PenDirLayout = {
  buttonAspect: 'aspect-[1116/1332]',
  arrowClassName: 'top-[44%] w-[82%]',
  arrowInset: { left: 'left-[5%]', right: 'right-[5%]' },
  centerClassName: 'top-[48%] w-[33%]',
  centerInset: { left: 'right-[5%]', right: 'left-[5%]' },
  markClassName: 'bottom-[4%] w-[23%]',
  tabClassName: 'aspect-[1319/400] w-[50%]',
};

interface PenShootModalProps {
  ken: number;
  amount: number;
  submitting?: boolean;
  onTopUp: () => void;
  onConfirm: (payload: { side: PenSide; betAmount: number }) => void;
  onClose: () => void;
}

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
    <PenModalShell
      panelAspect="aspect-[960/1639]"
      titleIcon={penShootAssets.ball}
      title={t('penGame.shoot')}
      closeBtn={penShootAssets.closeBtn}
      closeIcon={penShootAssets.closeIcon}
      onClose={onClose}
    >
      <PenKenRow ken={ken} onTopUp={onTopUp} />

      <p className="mt-[3%] text-base font-semibold text-white/90">{t('penGame.chooseDirection')}</p>

      <PenDirectionPicker
        value={direction}
        onSelect={setDirection}
        selected={penShootAssets.dir.selected}
        unselected={penShootAssets.dir.unselected}
        center={{ left: penShootAssets.panelBall, right: penShootAssets.panelBall }}
        layout={SHOOT_DIR_LAYOUT}
      />

      <p className="mt-[2%] text-base font-semibold text-white/90">{t('penGame.kenAmount')}</p>

      <label
        className={`relative mt-[2%] flex w-[72%] cursor-text items-center justify-center rounded-xl border bg-black/20 px-4 py-1.5 ${
          overBalance ? 'border-[#ff5b5b]' : 'border-white/15'
        }`}
      >
        <img src={penAssets.kenIcon} alt="KEN" className="absolute left-4 h-7 w-7 shrink-0" />
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

      <PenModalActions
        className="mt-auto pt-[3%]"
        cancelBg={penShootAssets.cancelBtn}
        confirmBg={penShootAssets.confirmBtn}
        onCancel={onClose}
        onConfirm={handleConfirm}
        confirmDisabled={submitting || overBalance}
      />
    </PenModalShell>
  );
}
