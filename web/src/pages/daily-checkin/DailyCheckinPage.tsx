import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { FullScreenOverlay, ScreenHeader, Spinner } from '@components';
import { formatDailyCheckinCountdown } from '@lib';
import { useDailyCheckinStore } from '@ola/shared/stores/daily-checkin/dailyCheckinStore';
import type { DailyCheckinSlot } from '@app-types';
import { DailyCheckinCalendar } from './components/DailyCheckinCalendar';
import { DailyCheckinSlotDialog } from './components/DailyCheckinSlotDialog';
import { DailyCheckinTodayCard } from './components/DailyCheckinTodayCard';
import { useDailyCheckinCountdown } from '@ola/shared/stores/daily-checkin/useDailyCheckinCountdown';
import { useDailyCheckinTask } from './useDailyCheckinTask';

interface DailyCheckinPageProps {
  onClose: () => void;
}

export function DailyCheckinPage({ onClose }: DailyCheckinPageProps) {
  const { t } = useTranslation();
  const status = useDailyCheckinStore((s) => s.status);
  const loading = useDailyCheckinStore((s) => s.loading);
  const acting = useDailyCheckinStore((s) => s.acting);
  const remainingMs = useDailyCheckinCountdown(status);
  const goTask = useDailyCheckinTask();
  const [selected, setSelected] = useState<DailyCheckinSlot | null>(null);

  useEffect(() => {
    const store = useDailyCheckinStore.getState();
    void store.load({ force: true });
    const reload = () => void useDailyCheckinStore.getState().load({ force: true });
    window.addEventListener('focus', reload);
    return () => window.removeEventListener('focus', reload);
  }, []);

  const enabled = status?.enabled === true;

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('dailyCheckin.title')} onBack={onClose}>
        {enabled && (
          <span className="shrink-0 rounded-full bg-white/20 px-2.5 py-1 text-xs font-semibold tabular-nums">
            {t('dailyCheckin.countdown', { time: formatDailyCheckinCountdown(remainingMs) })}
          </span>
        )}
      </ScreenHeader>
      <div className="flex-1 overflow-y-auto bg-ola-surface p-3">
        {status == null || !enabled ? (
          <div className="flex h-full items-center justify-center">
            {loading ? <Spinner /> : <p className="text-sm text-black/54">{t('dailyCheckin.errors.disabled')}</p>}
          </div>
        ) : (
          <div className="mx-auto max-w-lg">
            <section className="rounded-xl bg-white p-3 shadow-sm">
              <DailyCheckinCalendar status={status} onSelect={setSelected} showLegend />
            </section>
            <div className="mt-3">
              <DailyCheckinTodayCard
                status={status}
                busy={acting}
                onCheckIn={() => void useDailyCheckinStore.getState().checkIn()}
                onOpen={() => void useDailyCheckinStore.getState().open()}
                onGoTask={() => goTask(status.todayTask?.code)}
              />
            </div>
          </div>
        )}
      </div>
      <DailyCheckinSlotDialog slot={selected} onClose={() => setSelected(null)} />
    </FullScreenOverlay>
  );
}
