import { useState } from 'react';
import { createPortal } from 'react-dom';
import { useTranslation } from 'react-i18next';
import { CloseIcon } from '@components';
import {
  dailyCheckinMonthNumber,
  formatDailyCheckinCountdown,
  portalRoot,
} from '@lib';
import { useDailyCheckinStore } from '@ola/shared/stores/daily-checkin/dailyCheckinStore';
import type { DailyCheckinSlot, DailyCheckinStatus } from '@app-types';
import { DailyCheckinCalendar } from './components/DailyCheckinCalendar';
import { DailyCheckinSlotDialog } from './components/DailyCheckinSlotDialog';
import { DailyCheckinTodayCard } from './components/DailyCheckinTodayCard';
import { useDailyCheckinCountdown } from '@ola/shared/stores/daily-checkin/useDailyCheckinCountdown';
import { useDailyCheckinTask } from './useDailyCheckinTask';

interface DailyCheckinPopupProps {
  status: DailyCheckinStatus;
  onClose: () => void;
}

export function DailyCheckinPopup({ status, onClose }: DailyCheckinPopupProps) {
  const { t } = useTranslation();
  const acting = useDailyCheckinStore((s) => s.acting);
  const remainingMs = useDailyCheckinCountdown(status);
  const goTask = useDailyCheckinTask();
  const [selected, setSelected] = useState<DailyCheckinSlot | null>(null);
  const progress = t('dailyCheckin.progress', { count: status.count, total: status.slotCount });

  function goToTask() {
    onClose();
    goTask(status.todayTask?.code);
  }

  return createPortal(
    <div
      role="presentation"
      onClick={(event) => {
        if (event.target === event.currentTarget) onClose();
      }}
      data-megaphone-cover=""
      className="fixed inset-0 z-[105] grid place-items-center bg-black/60 p-3"
    >
      <div
        role="dialog"
        aria-modal="true"
        className="flex max-h-[92dvh] w-full max-w-[340px] flex-col overflow-hidden rounded-2xl bg-white shadow-[0_8px_30px_rgba(0,0,0,0.35)]"
      >
        <header className="relative shrink-0 bg-ola-primary px-3.5 py-2.5 pr-10 text-ola-on-primary">
          <p className="text-base font-bold">
            {t('dailyCheckin.popupTitle', { month: dailyCheckinMonthNumber(status) })}
          </p>
          <div className="mt-0.5 flex items-center justify-between gap-2">
            <p className="min-w-0 truncate text-xs text-ola-on-primary/85">{progress}</p>
            <span className="shrink-0 rounded-full bg-white/20 px-2 py-0.5 text-xs font-semibold tabular-nums">
              {t('dailyCheckin.countdown', { time: formatDailyCheckinCountdown(remainingMs) })}
            </span>
          </div>
          <button
            type="button"
            onClick={onClose}
            aria-label={t('dialog.close')}
            className="absolute right-2 top-2 flex h-8 w-8 items-center justify-center rounded-full hover:bg-white/15"
          >
            <CloseIcon className="h-4 w-4" strokeWidth={2.5} />
          </button>
        </header>
        <div className="min-h-0 flex-1 overflow-y-auto p-3">
          <DailyCheckinCalendar status={status} onSelect={setSelected} showSummary={false} />
          <div className="mt-2.5">
            <DailyCheckinTodayCard
              status={status}
              busy={acting}
              framed={false}
              onCheckIn={() => void useDailyCheckinStore.getState().checkIn()}
              onOpen={() => void useDailyCheckinStore.getState().open()}
              onGoTask={goToTask}
            />
          </div>
        </div>
      </div>
      <DailyCheckinSlotDialog slot={selected} onClose={() => setSelected(null)} />
    </div>,
    portalRoot()
  );
}
