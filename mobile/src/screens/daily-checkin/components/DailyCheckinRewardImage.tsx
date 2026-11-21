import { Image } from 'react-native';
import { DAILY_CHECKIN_REWARD_TYPE } from '@ola/shared/constants';
import type { DailyCheckinReward } from '@ola/shared/types';
import { VipIcon } from '@components/ui/VipIcon';
import { rewardImageSource } from '../utils';

interface DailyCheckinRewardImageProps {
  reward: DailyCheckinReward;
  size: number;
}

export function DailyCheckinRewardImage({ reward, size }: DailyCheckinRewardImageProps) {
  if (reward.type === DAILY_CHECKIN_REWARD_TYPE.vipIcon && reward.vipIconId != null) {
    return <VipIcon typeId={reward.vipIconId} size={size} />;
  }
  return <Image source={rewardImageSource(reward)} style={{ width: size, height: size }} resizeMode="contain" />;
}
