import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { formatVnd, toast } from '@lib';
import type { PenSide } from '@app-types';
import { penAssets, penCatchAssets } from './penAssets';
import {
  PenDirectionPicker,
  PenKenRow,
  PenModalActions,
  PenModalShell,
  type PenDirLayout,
} from './penModalParts';

const CATCH_DIR_LAYOUT: PenDirLayout = {
  buttonAspect: 'aspect-[1082/1220]',
  arrowClassName: 'top-[46%] w-[56%]',
  arrowInset: { left: 'left-[2%]', right: 'right-[2%]' },
  centerClassName: 'top-[48%] w-[40%]',
  centerInset: { left: 'right-[4%]', right: 'left-[4%]' },
  markClassName: 'bottom-[4%] w-[22%]',
  tabClassName: 'aspect-[1063/360] w-[50%]',
};

interface PenCatchModalProps {
  ken: number;
  betAmount: number;
  submitting?: boolean;
  onTopUp: () => void;
  onConfirm: (side: PenSide) => void;
  onClose: () => void;
}

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
    <PenModalShell
      panelAspect="aspect-[943/1250]"
      titleIcon={penCatchAssets.gloveEffect}
      titleIconClassName="h-14"
      title={t('penGame.catchTitle')}
      closeBtn={penCatchAssets.closeBtn}
      closeIcon={penCatchAssets.closeIcon}
      onClose={onClose}
    >
      <PenKenRow ken={ken} onTopUp={onTopUp} />

      <p className="mt-[3%] text-base font-semibold text-white/90">
        {t('penGame.chooseCatchDirection')}
      </p>

      <PenDirectionPicker
        value={direction}
        onSelect={setDirection}
        selected={penCatchAssets.dir.selected}
        unselected={penCatchAssets.dir.unselected}
        center={{ left: penCatchAssets.gloveLeft, right: penCatchAssets.gloveRight }}
        layout={CATCH_DIR_LAYOUT}
      />

      <div className="mt-auto flex flex-col items-center gap-1 pt-[4%]">
        <span className="text-base font-semibold text-white/90">{t('penGame.catchBet')}</span>
        <span className="flex items-center gap-2">
          <img src={penAssets.kenIcon} alt="KEN" className="h-6 w-6 shrink-0" />
          <span className="text-2xl font-bold text-white">{formatVnd(betAmount)}</span>
        </span>
      </div>

      <PenModalActions
        className="mt-[3%]"
        cancelBg={penCatchAssets.cancelBtn}
        confirmBg={penCatchAssets.confirmBtn}
        onCancel={onClose}
        onConfirm={handleConfirm}
        confirmDisabled={submitting}
      />
    </PenModalShell>
  );
}
