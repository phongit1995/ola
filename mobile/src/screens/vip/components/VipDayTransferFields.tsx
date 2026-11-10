import { useTranslation } from 'react-i18next';
import { Text, TextInput, View } from 'react-native';
import type { VipDayTransferForm } from '@ola/shared/stores/vip/useVipDayTransferForm';
import { DIVIDER, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';

export function VipDayTransferFields({ form }: { form: VipDayTransferForm }) {
  const { t } = useTranslation();
  const { config } = form;
  if (config == null) return null;

  return (
    <View className="gap-1">
      <Text className="text-sm font-medium" style={{ color: TEXT_PRIMARY }}>
        {t('vip.buy.transferDaysRate', { rate: config.rate })}
      </Text>
      <Text className="mt-2 text-xs" style={{ color: TEXT_SECONDARY }}>
        {t('vip.buy.transferDaysLabel')}
      </Text>
      <TextInput
        keyboardType="number-pad"
        value={form.daysText}
        onChangeText={(text) => form.setDaysText(text.replace(/\D/g, ''))}
        placeholder={t('vip.buy.transferDaysPlaceholder', { days: config.minSenderDays })}
        placeholderTextColor="rgba(0,0,0,0.38)"
        className="w-full rounded px-3 py-2 text-sm"
        style={{ borderWidth: 1, borderColor: DIVIDER, color: TEXT_PRIMARY, backgroundColor: '#fff' }}
      />
      {form.receiverDays > 0 && (
        <Text className="mt-1 text-sm font-semibold text-ola-credit">
          {t('vip.buy.transferDaysReceive', { days: form.receiverDays })}
        </Text>
      )}
      <Text className="mt-1 text-xs" style={{ color: TEXT_SECONDARY }}>
        {t('vip.buy.transferDaysMax', { days: form.maxSenderDays })}
      </Text>
      <Text className="text-xs" style={{ color: TEXT_SECONDARY }}>
        {t('vip.buy.transferDaysMin', { days: config.minSenderDays })}
      </Text>
    </View>
  );
}
