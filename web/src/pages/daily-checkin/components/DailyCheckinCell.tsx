import { useTranslation } from 'react-i18next';
import { DAILY_CHECKIN_BOX, DAILY_CHECKIN_ICONS, DAILY_CHECKIN_SLOT_STATUS } from '@constants';
import { cn } from '@lib';
import type { DailyCheckinSlot } from '@app-types';
import { boxImageSrc, cellToneClass, openedBoxImageSrc } from '../utils';

interface DailyCheckinCellProps {
  slot: DailyCheckinSlot;
  onSelect: (slot: DailyCheckinSlot) => void;
}

const STATUS = DAILY_CHECKIN_SLOT_STATUS;

function CellBadge({ slot }: { slot: DailyCheckinSlot }) {
  const base = 'absolute -right-1 -top-1 flex h-[18px] w-[18px] items-center justify-center rounded-full text-[11px] font-bold leading-none text-white shadow-sm';
  if (slot.status === STATUS.claimed || slot.status === STATUS.none) {
    return <span className={cn(base, 'bg-ola-primary')}>✓</span>;
  }
  if (slot.status === STATUS.missed) return <span className={cn(base, 'bg-black/35')}>✕</span>;
  if (slot.status === STATUS.pending) {
    return (
      <span className="absolute -right-1.5 -top-1.5 flex h-5 w-5 items-center justify-center rounded-full border border-ola-warning bg-white shadow-sm">
        <img src={DAILY_CHECKIN_ICONS.task} alt="" className="h-3.5 w-3.5 object-contain" />
      </span>
    );
  }
  return null;
}

export function DailyCheckinCell({ slot, onSelect }: DailyCheckinCellProps) {
  const { t } = useTranslation();
  const hasBox = slot.box !== DAILY_CHECKIN_BOX.none;
  const opened = slot.status === STATUS.claimed;
  const missed = slot.status === STATUS.missed;
  const checked = opened || slot.status === STATUS.none;
  const big = slot.box === DAILY_CHECKIN_BOX.big;
  const waiting = slot.status === STATUS.today || slot.status === STATUS.pending;

  return (
    <button
      type="button"
      onClick={() => onSelect(slot)}
      aria-label={t('dailyCheckin.slot.title', { slot: slot.slot })}
      className={cn(
        'relative flex aspect-square min-w-0 flex-col items-center justify-center rounded-lg border transition-transform active:scale-95',
        cellToneClass(slot)
      )}
    >
      {hasBox && (
        <span className="absolute left-1 top-0.5 text-[10px] font-semibold leading-none text-black/45">
          {slot.slot}
        </span>
      )}
      {hasBox ? (
        <img
          src={opened ? openedBoxImageSrc(slot.box) : boxImageSrc(slot.box, missed)}
          alt=""
          className={cn(
            'object-contain',
            big ? 'h-[72%] w-[72%]' : 'h-[58%] w-[58%]',
            waiting && 'origin-bottom motion-safe:animate-checkin-wiggle',
          )}
        />
      ) : (
        <span
          className={cn(
            'text-sm font-bold',
            checked ? 'text-ola-primary-dark' : 'text-black/54'
          )}
        >
          {slot.slot}
        </span>
      )}
      <CellBadge slot={slot} />
    </button>
  );
}
