import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton } from '@components';
import { DAILY_CHECKIN_BOX } from '@constants';
import { dailyCheckinBestReward } from '@lib';
import type { DailyCheckinOpened } from '@app-types';
import { boxImageSrc } from '../utils';
import { DailyCheckinRewardImage } from './DailyCheckinRewardImage';
import { DailyCheckinRewardList } from './DailyCheckinRewardList';

const SHAKE_MS = 750;

interface DailyCheckinOpenedDialogProps {
  opened: DailyCheckinOpened;
  onClose: () => void;
}

export function DailyCheckinOpenedDialog({ opened, onClose }: DailyCheckinOpenedDialogProps) {
  const { t } = useTranslation();
  const [revealed, setRevealed] = useState(false);
  const best = dailyCheckinBestReward(opened.items);
  const big = opened.box === DAILY_CHECKIN_BOX.big;

  useEffect(() => {
    const timer = window.setTimeout(() => setRevealed(true), SHAKE_MS);
    return () => window.clearTimeout(timer);
  }, []);

  return (
    <Dialog
      open
      onClose={onClose}
      dismissOnBackdrop={revealed}
      footer={
        <DialogButton variant="green" onClick={onClose} disabled={!revealed}>
          {t('dailyCheckin.actions.great')}
        </DialogButton>
      }
    >
      <div className="flex flex-col items-center px-2 pb-1 pt-3 text-center">
        <div className="flex h-28 w-28 items-center justify-center rounded-full bg-[radial-gradient(circle,var(--color-ola-checkin-gold-soft)_45%,transparent_70%)]">
          {revealed && best != null ? (
            <DailyCheckinRewardImage reward={best} className="h-20 w-20 animate-checkin-burst" />
          ) : (
            <img src={boxImageSrc(opened.box)} alt="" className="h-20 w-20 animate-checkin-shake object-contain" />
          )}
        </div>
        <p className="mt-2 text-lg font-bold text-black/87">
          {big ? t('dailyCheckin.opened.titleBig', { slot: opened.slot }) : t('dailyCheckin.opened.title', { slot: opened.slot })}
        </p>
        {revealed && (
          <>
            <p className="mt-1 text-sm text-black/60">{t('dailyCheckin.opened.subtitle')}</p>
            <div className="mt-3 w-full animate-checkin-burst">
              <DailyCheckinRewardList items={opened.items} />
            </div>
          </>
        )}
      </div>
    </Dialog>
  );
}
