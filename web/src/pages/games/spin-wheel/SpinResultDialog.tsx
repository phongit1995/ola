import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { VipIcon } from '@components';
import type { WheelSpinResult } from '@app-types';
import {
  resultCloseFrameUrl,
  resultCloseMarkUrl,
  resultPopupFrameUrl,
  rewardMissUrl,
  rewardVipDaysUrl,
  spinCoinUrl,
} from './spinWheelAssets';
import { formatRewardKen, isKenKind, isVipDaysKind } from './spinWheelReward';

const REWARD_ICON_CLASS = 'h-24 w-24 drop-shadow';

interface ResolvedReward {
  icon: ReactNode;
  label: string;
  labelClass: string;
}

interface SpinResultDialogProps {
  result: WheelSpinResult;
  onClose: () => void;
}

export function SpinResultDialog({ result, onClose }: SpinResultDialogProps) {
  const { t } = useTranslation();

  const resolveReward = (): ResolvedReward => {
    if (!result.isWin) {
      return {
        icon: <img src={rewardMissUrl} alt="" className={REWARD_ICON_CLASS} />,
        label: t('wheelGame.miss'),
        labelClass: 'text-2xl',
      };
    }
    if (isKenKind(result.segmentKind)) {
      return {
        icon: <img src={spinCoinUrl} alt="" className={REWARD_ICON_CLASS} />,
        label: `${formatRewardKen(result.kenAmount ?? 0)} KEN`,
        labelClass: 'text-2xl',
      };
    }
    if (isVipDaysKind(result.segmentKind)) {
      return {
        icon: <img src={rewardVipDaysUrl} alt="" className={REWARD_ICON_CLASS} />,
        label: t('wheelGame.vipDays', { n: result.vipDays ?? 0 }),
        labelClass: 'text-2xl',
      };
    }
    return {
      icon:
        typeof result.vipTypeId === 'number' ? (
          <VipIcon typeId={result.vipTypeId} className="h-24 w-24" rounded />
        ) : (
          <img src={rewardVipDaysUrl} alt="" className={REWARD_ICON_CLASS} />
        ),
      label: result.rewardLabel ?? t('wheelGame.rewardTitle'),
      labelClass: 'text-base',
    };
  };

  const reward = resolveReward();

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
          {result.isWin ? t('wheelGame.rewardTitle') : t('wheelGame.missTitle')}
        </div>
        <div className="absolute inset-x-0 top-[45%] flex flex-col items-center gap-2 px-8">
          {reward.icon}
          <span className={`${reward.labelClass} font-extrabold text-[#e0348b]`}>
            {reward.label}
          </span>
        </div>
      </div>
    </div>
  );
}
