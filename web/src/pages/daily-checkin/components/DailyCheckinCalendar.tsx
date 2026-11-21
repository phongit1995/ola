import { useTranslation } from 'react-i18next';
import { cn, dailyCheckinMonthNumber, dailyCheckinRestInfo, dailyCheckinRestText } from '@lib';
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
      <span>… {t('dailyCheckin.legend.pending')}</span>
      <span>🔒 {t('dailyCheckin.legend.outOfReach')}</span>
    </p>
  );
}

export function DailyCheckinCalendar({ status, onSelect, showSummary = true, showLegend = false }: DailyCheckinCalendarProps) {
  const { t } = useTranslation();
  const rest = dailyCheckinRestInfo(status);
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
          {rest != null && (
            <span
              className={cn(
                'shrink-0 rounded-full px-2 py-0.5 text-xs font-semibold',
                rest.kind === 'rest' ? 'bg-ola-primary-light text-ola-primary-dark' : 'bg-ola-warning-soft text-ola-warning-ink'
              )}
            >
              {dailyCheckinRestText(t, rest)}
            </span>
          )}
        </div>
      )}
      <div className="grid grid-cols-7 gap-1.5">
        {status.slots.map((slot) => (
          <DailyCheckinCell key={slot.slot} slot={slot} onSelect={onSelect} />
        ))}
      </div>
      {showLegend && <Legend />}
    </div>
  );
}
