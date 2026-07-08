import { useTranslation } from 'react-i18next';
import { VipIcon } from '@components';
import type { WheelSpinResult } from '@app-types';
import {
  closeButtonUrl,
  resultPopupFrameUrl,
  rewardMissUrl,
  rewardVipDaysUrl,
  spinCoinUrl,
} from './spinWheelAssets';
import { formatRewardKen, isKenKind, isVipDaysKind, isVipItemKind } from './spinWheelReward';

interface SpinResultDialogProps {
  result: WheelSpinResult;
  onClose: () => void;
}

export function SpinResultDialog({ result, onClose }: SpinResultDialogProps) {
  const { t } = useTranslation();
  const isKen = isKenKind(result.segmentKind);
  const isVipDays = isVipDaysKind(result.segmentKind);
  const isVipItem = isVipItemKind(result.segmentKind);

  return (
    <div
      className="font-game fixed inset-0 z-70 flex items-center justify-center bg-black/55 px-6"
      onClick={onClose}
    >
      <div
        className="relative w-[320px] max-w-[82vw]"
        style={{ aspectRatio: '1086 / 1448' }}
        onClick={(event) => event.stopPropagation()}
      >
        <img src={resultPopupFrameUrl} alt="" className="absolute inset-0 h-full w-full" />
        <button
          type="button"
          onClick={onClose}
          aria-label={t('wheelGame.close')}
          className="absolute right-[1%] top-[7%] z-10 h-9 w-9 active:scale-95"
        >
          <img src={closeButtonUrl} alt="" className="h-full w-full" />
        </button>
        <div className="absolute inset-x-0 top-[19%] px-10 text-center text-xl font-extrabold uppercase leading-tight text-[#e0348b]">
          {result.isWin ? t('wheelGame.rewardTitle') : t('wheelGame.missTitle')}
        </div>
        <div className="absolute inset-x-0 top-[45%] flex flex-col items-center gap-2 px-8">
          {isKen && (
            <>
              <img src={spinCoinUrl} alt="" className="h-24 w-24 drop-shadow" />
              <span className="text-2xl font-extrabold text-[#e0348b]">
                {formatRewardKen(result.kenAmount ?? 0)} KEN
              </span>
            </>
          )}
          {isVipDays && (
            <>
              <img src={rewardVipDaysUrl} alt="" className="h-24 w-24 drop-shadow" />
              <span className="text-2xl font-extrabold text-[#e0348b]">
                {t('wheelGame.vipDays', { n: result.vipDays ?? 0 })}
              </span>
            </>
          )}
          {isVipItem && (
            <>
              {typeof result.vipTypeId === 'number' ? (
                <VipIcon typeId={result.vipTypeId} className="h-24 w-24" rounded />
              ) : (
                <img src={rewardVipDaysUrl} alt="" className="h-24 w-24 drop-shadow" />
              )}
              <span className="text-xl font-extrabold text-[#e0348b]">
                {result.rewardLabel ?? t('wheelGame.rewardTitle')}
              </span>
            </>
          )}
          {!result.isWin && (
            <>
              <img src={rewardMissUrl} alt="" className="h-24 w-24 drop-shadow" />
              <span className="text-2xl font-extrabold text-[#e0348b]">{t('wheelGame.miss')}</span>
            </>
          )}
        </div>
      </div>
    </div>
  );
}
