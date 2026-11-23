import { useTranslation } from 'react-i18next';
import { DAILY_CHECKIN_ICONS } from '@constants';
import { dailyCheckinMonthNumber } from '@lib';
import type { DailyCheckinSlot, DailyCheckinStatus } from '@app-types';
import { DailyCheckinCell } from './DailyCheckinCell';

interface DailyCheckinCalendarProps {
  status: DailyCheckinStatus;
  onSelect: (slot: DailyCheckinSlot) => void;
  showSummary?: boolean;
  showLegend?: boolean;
}

function Legend() {
  const { t } = useTranslation();
  return (
    <p className="mt-3 flex flex-wrap items-center gap-x-3 gap-y-1 px-1 text-[11px] text-black/54">
      <span>{t('dailyCheckin.legend.plain')}</span>
      <span>✓ {t('dailyCheckin.legend.done')}</span>
      <span>✕ {t('dailyCheckin.legend.missed')}</span>
      <span className="inline-flex items-center gap-1">
        <img src={DAILY_CHECKIN_ICONS.task} alt="" className="h-3.5 w-3.5 object-contain" />
        {t('dailyCheckin.legend.pending')}
      </span>
    </p>
  );
}

export function DailyCheckinCalendar({ status, onSelect, showSummary = true, showLegend = false }: DailyCheckinCalendarProps) {
  const { t } = useTranslation();
  return (
    <div>
      {showSummary && (
        <div className="flex items-center justify-between gap-2 px-1 pb-2">
          <p className="min-w-0 truncate text-sm font-bold text-black/87">
            {t('dailyCheckin.summary', {
              month: dailyCheckinMonthNumber(status),
              count: status.count,
              total: status.slotCount,
            })}
          </p>
        </div>
      )}
      <div className="grid grid-cols-7 gap-1">
        {status.slots.map((slot) => (
          <DailyCheckinCell key={slot.slot} slot={slot} onSelect={onSelect} />
        ))}
      </div>
      {showLegend && <Legend />}
    </div>
  );
}
