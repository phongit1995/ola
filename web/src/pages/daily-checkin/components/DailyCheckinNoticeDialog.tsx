import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton } from '@components';
import { DAILY_CHECKIN_ICONS } from '@constants';
import type { DailyCheckinNotice } from '@app-types';

interface DailyCheckinNoticeDialogProps {
  notice: DailyCheckinNotice;
  onClose: () => void;
  onVerifyEmail: () => void;
}

export function DailyCheckinNoticeDialog({ notice, onClose, onVerifyEmail }: DailyCheckinNoticeDialogProps) {
  const { t } = useTranslation();
  if (notice === 'vipRequired') {
    return (
      <Dialog open onClose={onClose} footer={<DialogButton onClick={onClose}>{t('dailyCheckin.actions.close')}</DialogButton>}>
        <div className="flex flex-col items-center px-2 py-2 text-center">
          <img src={DAILY_CHECKIN_ICONS.vipBadge} alt="" className="h-14 w-14 object-contain" />
          <p className="mt-2 text-base font-bold text-black/87">{t('dailyCheckin.vipDialog.title')}</p>
          <p className="mt-1 text-sm text-black/60">{t('dailyCheckin.vipDialog.message')}</p>
        </div>
      </Dialog>
    );
  }
  return (
    <Dialog
      open
      onClose={onClose}
      title={t('dailyCheckin.emailDialog.title')}
      footer={
        <>
          <DialogButton onClick={onClose}>{t('dailyCheckin.actions.close')}</DialogButton>
          <DialogButton variant="green" onClick={onVerifyEmail}>
            {t('dailyCheckin.actions.verifyEmail')}
          </DialogButton>
        </>
      }
    >
      <div className="flex flex-col gap-1 px-1 py-1">
        <p className="text-sm text-black/87">{t('dailyCheckin.emailDialog.message')}</p>
        <p className="text-sm text-black/60">{t('dailyCheckin.today.emailGuide')}</p>
      </div>
    </Dialog>
  );
}
