import { useTranslation } from 'react-i18next';

interface VipDayTransferSummaryProps {
  senderDays: number;
  receiverDays: number;
  receiver: string;
  note?: string;
}

export function VipDayTransferSummary({
  senderDays,
  receiverDays,
  receiver,
  note,
}: VipDayTransferSummaryProps) {
  const { t } = useTranslation();

  return (
    <span className="block text-base text-black/87">
      <span className="block">
        {t('vip.buy.transferDaysLost')}{' '}
        <span className="font-bold text-ola-debit">
          {t('vip.buy.transferDaysAmount', { days: senderDays })}
        </span>
      </span>
      <span className="mt-1 block">
        <span className="font-semibold text-ola-receiver">@{receiver}</span>{' '}
        {t('vip.buy.transferDaysGain')}{' '}
        <span className="font-bold text-ola-credit">
          {t('vip.buy.transferDaysAmount', { days: receiverDays })}
        </span>
      </span>
      {note != null && (
        <span className="mt-2 block text-sm text-black/54">{note}</span>
      )}
    </span>
  );
}
