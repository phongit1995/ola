import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton } from '@components';
import { DAILY_CHECKIN_BOX, DAILY_CHECKIN_ICONS, DAILY_CHECKIN_SLOT_STATUS } from '@constants';
import { dailyCheckinDayLabel, dailyCheckinSlotHint } from '@lib';
import type { DailyCheckinSlot } from '@app-types';
import { boxImageSrc } from '../utils';
import { DailyCheckinRewardList } from './DailyCheckinRewardList';

interface DailyCheckinSlotDialogProps {
  slot: DailyCheckinSlot | null;
  onClose: () => void;
}

export function DailyCheckinSlotDialog({ slot, onClose }: DailyCheckinSlotDialogProps) {
  const { t } = useTranslation();
  if (slot == null) return null;
  const hasBox = slot.box !== DAILY_CHECKIN_BOX.none;
  const claimed = slot.status === DAILY_CHECKIN_SLOT_STATUS.claimed;
  const missed = slot.status === DAILY_CHECKIN_SLOT_STATUS.missed;
  const title = !hasBox
    ? t('dailyCheckin.slot.title', { slot: slot.slot })
    : slot.box === DAILY_CHECKIN_BOX.big
      ? t('dailyCheckin.slot.bigTitle')
      : t('dailyCheckin.slot.secretTitle');

  return (
    <Dialog
      open
      onClose={onClose}
      title={t('dailyCheckin.slot.title', { slot: slot.slot })}
      footer={<DialogButton onClick={onClose}>{t('dailyCheckin.actions.close')}</DialogButton>}
    >
      <div className="flex flex-col items-center px-2 py-2 text-center">
        {hasBox && !claimed && (
          <img
            src={boxImageSrc(slot.box, missed)}
            alt=""
            className="h-20 w-20 object-contain"
          />
        )}
        {!claimed && <p className="mt-2 text-base font-bold text-black/87">{title}</p>}
        <p className="mt-1 text-sm text-black/60">{dailyCheckinSlotHint(t, slot)}</p>
        {slot.requireVip && hasBox && !claimed && (
          <p className="mt-2 inline-flex items-center gap-1 text-sm font-semibold text-ola-checkin-gold-ink">
            <img src={DAILY_CHECKIN_ICONS.vipBadge} alt="" className="h-4 w-4 object-contain" />
            {t('dailyCheckin.slot.vip')}
          </p>
        )}
        {claimed && slot.items != null && (
          <div className="mt-3 w-full">
            <DailyCheckinRewardList items={slot.items} />
          </div>
        )}
        {slot.checkedInOn != null && (
          <p className="mt-3 text-xs text-black/45">
            {t('dailyCheckin.slot.checkedInOn', { date: dailyCheckinDayLabel(slot.checkedInOn) })}
          </p>
        )}
      </div>
    </Dialog>
  );
}
