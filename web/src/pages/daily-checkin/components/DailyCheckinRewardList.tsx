import { useTranslation } from 'react-i18next';
import { ItemGrantIcon } from '@components';
import { dailyCheckinRewardCaption, dailyCheckinRewardLocked, dailyCheckinRewardText } from '@lib';
import type { DailyCheckinReward } from '@app-types';
import { DailyCheckinRewardImage } from './DailyCheckinRewardImage';

interface DailyCheckinRewardListProps {
  items: DailyCheckinReward[];
}

export function DailyCheckinRewardList({ items }: DailyCheckinRewardListProps) {
  const { t } = useTranslation();
  return (
    <ul className="flex flex-col gap-1.5">
      {items.map((reward, index) => (
        <li
          key={`${reward.type}-${index}`}
          className="flex items-center gap-3 rounded-lg bg-ola-primary-light px-3 py-2 text-left"
        >
          <DailyCheckinRewardImage reward={reward} className="h-9 w-9 shrink-0" />
          <span className="min-w-0 flex-1">
            <span className="block truncate text-sm font-semibold text-black/87">
              {dailyCheckinRewardText(t, reward)}
            </span>
            {dailyCheckinRewardLocked(reward) && (
              <span className="mt-0.5 flex items-center gap-1 text-xs text-black/54">
                <ItemGrantIcon kind="lock" className="h-3 w-3" />
                {t('dailyCheckin.opened.locked')} · {dailyCheckinRewardCaption(t, reward)}
              </span>
            )}
          </span>
        </li>
      ))}
    </ul>
  );
}
