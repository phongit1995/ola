import { useTranslation } from 'react-i18next';
import { CloseIcon } from '@components';
import { DAILY_CHECKIN_ICONS } from '@constants';
import { cn } from '@lib';
import { useDailyCheckinFab } from '@ola/shared/stores/daily-checkin/useDailyCheckinFab';

export function DailyCheckinFab({ className }: { className?: string }) {
  const { t } = useTranslation();
  const { kind, open, hide } = useDailyCheckinFab();
  if (kind == null) return null;
  const label = t(`dailyCheckin.fab.${kind}`);

  return (
    <div className={cn('absolute h-14 w-14', className)}>
      <button
        type="button"
        onClick={open}
        aria-label={label}
        className="flex h-14 w-14 items-center justify-center rounded-full border-2 border-red-100 bg-white shadow-lg transition active:scale-95"
      >
        <img src={DAILY_CHECKIN_ICONS.menu} alt="" className="h-10 w-10 origin-bottom object-contain motion-safe:animate-checkin-wiggle" />
      </button>
      <span
        className={cn(
          'pointer-events-none absolute -bottom-2 left-1/2 -translate-x-1/2 whitespace-nowrap rounded-full border-[1.5px] border-white px-2 py-px text-[10.5px] font-bold leading-tight text-white shadow-sm',
          kind === 'checkin' ? 'bg-ola-error' : 'bg-ola-warning'
        )}
      >
        {label}
      </span>
      <button
        type="button"
        onClick={hide}
        aria-label={t('dailyCheckin.fab.hide')}
        className="absolute -right-1.5 -top-1.5 flex h-5 w-5 items-center justify-center rounded-full border border-black/10 bg-white text-black/40 shadow"
      >
        <CloseIcon className="h-2.5 w-2.5" strokeWidth={3} />
      </button>
    </div>
  );
}
