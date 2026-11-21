import { useTranslation } from 'react-i18next';
import { Text, View } from 'react-native';
import { dailyCheckinRewardCaption, dailyCheckinRewardLocked, dailyCheckinRewardText } from '@ola/shared/lib';
import type { DailyCheckinReward } from '@ola/shared/types';
import { ItemGrantIcon } from '@components/ui/ItemGrantMarks';
import { TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { useThemeColors } from '@hooks/useThemeColors';
import { DailyCheckinRewardImage } from './DailyCheckinRewardImage';

interface DailyCheckinRewardListProps {
  items: DailyCheckinReward[];
}

export function DailyCheckinRewardList({ items }: DailyCheckinRewardListProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  return (
    <View style={{ gap: 6 }}>
      {items.map((reward, index) => (
        <View
          key={`${reward.type}-${index}`}
          className="flex-row items-center gap-3 rounded-lg px-3 py-2"
          style={{ backgroundColor: colors.primaryLight }}
        >
          <DailyCheckinRewardImage reward={reward} size={36} />
          <View className="min-w-0 flex-1">
            <Text numberOfLines={1} className="text-sm font-semibold" style={{ color: TEXT_PRIMARY }}>
              {dailyCheckinRewardText(t, reward)}
            </Text>
            {dailyCheckinRewardLocked(reward) && (
              <View className="mt-0.5 flex-row items-center gap-1">
                <ItemGrantIcon kind="lock" size={12} />
                <Text className="text-xs" style={{ color: TEXT_SECONDARY }}>
                  {t('dailyCheckin.opened.locked')} · {dailyCheckinRewardCaption(t, reward)}
                </Text>
              </View>
            )}
          </View>
        </View>
      ))}
    </View>
  );
}
