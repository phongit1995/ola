import { useTranslation } from 'react-i18next';
import { Text, View } from 'react-native';
import { TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';

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
    <View className="gap-1">
      <Text className="text-base" style={{ color: TEXT_PRIMARY }}>
        {t('vip.buy.transferDaysLost')}{' '}
        <Text className="font-bold text-ola-debit">
          {t('vip.buy.transferDaysAmount', { days: senderDays })}
        </Text>
      </Text>
      <Text className="text-base" style={{ color: TEXT_PRIMARY }}>
        <Text className="font-semibold text-ola-receiver">@{receiver}</Text>{' '}
        {t('vip.buy.transferDaysGain')}{' '}
        <Text className="font-bold text-ola-credit">
          {t('vip.buy.transferDaysAmount', { days: receiverDays })}
        </Text>
      </Text>
      {note != null && (
        <Text className="mt-1 text-sm" style={{ color: TEXT_SECONDARY }}>
          {note}
        </Text>
      )}
    </View>
  );
}
