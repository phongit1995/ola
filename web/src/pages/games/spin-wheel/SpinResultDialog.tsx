import { useTranslation } from 'react-i18next';
import { formatKen } from '@lib';
import type { SpinSegment } from './spinWheel.constants';
import {
  coinUrl,
  resultCloseFrameUrl,
  resultCloseMarkUrl,
  resultPopupFrameUrl,
  rewardMissUrl,
  rewardVipDaysUrl,
} from './spinWheelAssets';

interface SpinResultDialogProps {
  segment: SpinSegment;
  onClose: () => void;
}

export function SpinResultDialog({ segment, onClose }: SpinResultDialogProps) {
  const { t } = useTranslation();
  const isMiss = segment.kind === 'miss';

  return (
    <div
      className="font-game fixed inset-0 z-[70] flex items-center justify-center bg-black/55 px-6"
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
          className="absolute right-[1%] top-[4%] z-10 h-11 w-11 active:scale-95"
        >
          <img src={resultCloseFrameUrl} alt="" className="absolute inset-0 h-full w-full" />
          <img
            src={resultCloseMarkUrl}
            alt=""
            className="absolute left-1/2 top-1/2 w-[42%] -translate-x-1/2 -translate-y-1/2"
          />
        </button>
        <div className="absolute inset-x-0 top-[19%] px-10 text-center text-xl font-extrabold uppercase leading-tight text-[#e0348b]">
          {isMiss ? t('wheelGame.missTitle') : t('wheelGame.rewardTitle')}
        </div>
        <div className="absolute inset-x-0 top-[40%] flex flex-col items-center px-8">
          {segment.kind === 'ken' && (
            <>
              <img src={coinUrl} alt="" className="h-32 w-32 drop-shadow" />
              <span className="mt-2 text-2xl font-extrabold text-[#e0348b]">
                {formatKen(segment.kenAmount ?? 0)} KEN
              </span>
            </>
          )}
          {segment.kind === 'vip' && (
            <>
              <img src={rewardVipDaysUrl} alt="" className="h-32 w-32 drop-shadow" />
              <span className="mt-2 text-2xl font-extrabold text-[#e0348b]">
                {t('wheelGame.vipDays', { n: segment.vipDays ?? 0 })}
              </span>
            </>
          )}
          {segment.kind === 'item' && (
            <span className="text-3xl font-extrabold text-[#e0348b]">{t('wheelGame.doll')}</span>
          )}
          {isMiss && (
            <>
              <img src={rewardMissUrl} alt="" className="h-32 w-32 drop-shadow" />
              <span className="mt-2 text-2xl font-extrabold text-[#e0348b]">
                {t('wheelGame.miss')}
              </span>
            </>
          )}
        </div>
      </div>
    </div>
  );
}
