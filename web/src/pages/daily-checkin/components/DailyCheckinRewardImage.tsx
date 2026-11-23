import { VipIcon } from '@components';
import { cn } from '@lib';
import { DAILY_CHECKIN_REWARD_TYPE } from '@constants';
import type { DailyCheckinReward } from '@app-types';
import { rewardImageSrc } from '../utils';

interface DailyCheckinRewardImageProps {
  reward: DailyCheckinReward;
  className?: string;
}

export function DailyCheckinRewardImage({ reward, className }: DailyCheckinRewardImageProps) {
  if (reward.type === DAILY_CHECKIN_REWARD_TYPE.vipIcon && reward.vipIconId != null) {
    return <VipIcon typeId={reward.vipIconId} className={cn('object-contain', className)} />;
  }
  return <img src={rewardImageSrc(reward)} alt="" className={cn('object-contain', className)} />;
}
