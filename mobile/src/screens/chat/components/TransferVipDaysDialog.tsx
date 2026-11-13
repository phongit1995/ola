import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, Text, View } from 'react-native';
import { formatKen } from '@ola/shared/lib';
import { TransferReceiverRow } from '@components/transfer/TransferReceiverRow';
import type { TransferReceiver } from '@components/transfer/types';
import { TransferPasswordField } from '@components/transfer/TransferPasswordField';
import { TransferWarning } from '@components/transfer/TransferWarning';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { ListOptionDialog } from '@components/ui/ListOptionDialog';
import { DIVIDER, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { useThemeColors } from '@hooks/useThemeColors';
import { useTransferVipDays } from '@ola/shared/stores/vip/useTransferVipDays';

const vipIcon = require('@assets/icons/apps/vip.png');

interface TransferVipDaysDialogProps {
  visible: boolean;
  onClose: () => void;
  receiver: TransferReceiver;
}

export function TransferVipDaysDialog({ visible, onClose, receiver }: TransferVipDaysDialogProps) {
  const colors = useThemeColors();
  const { t } = useTranslation();
  const {
    balance,
    step,
    setStep,
    loading,
    packages,
    selected,
    setSelectedId,
    password,
    setPassword,
    submitting,
    goToConfirm,
    submitGift,
  } = useTransferVipDays({ receiver, enabled: visible, onDone: onClose });
  const [pickerOpen, setPickerOpen] = useState(false);

  const title =
    step === 'confirm' ? t('chat.transferVipDaysConfirmTitle') : t('chat.transferVipDaysTitle');

  const footer =
    step === 'select' ? (
      <DialogButton variant="green" onPress={goToConfirm}>
        {t('chat.transferVipDaysOk')}
      </DialogButton>
    ) : (
      <>
        <DialogButton onPress={() => setStep('select')} disabled={submitting}>
          {t('chat.transferVipDaysEdit')}
        </DialogButton>
        <DialogButton variant="green" onPress={() => void submitGift()} disabled={submitting}>
          {t('chat.transferVipDaysOk')}
        </DialogButton>
      </>
    );

  return (
    <Dialog visible={visible} onClose={onClose} title={title} icon={vipIcon} footer={footer}>
      {step === 'select' ? (
        <View className="px-1 py-1">
          <View className="flex-row items-center justify-center gap-2">
            <Text className="text-lg font-bold" style={{ color: TEXT_SECONDARY }}>
              {t('chat.transferVipDaysBalance')}
            </Text>
            <Text className="text-lg font-bold" style={{ color: TEXT_PRIMARY }}>
              {formatKen(balance)} {t('chat.transferKenUnit')}
            </Text>
          </View>
          <View className="my-2" style={{ height: 1, backgroundColor: DIVIDER }} />
          <Text className="text-base" style={{ color: TEXT_PRIMARY }}>
            {t('chat.transferVipDaysReceiverLabel')}
          </Text>
          <View className="mt-1 rounded px-3" style={{ borderWidth: 1, borderColor: DIVIDER }}>
            <TransferReceiverRow receiver={receiver} />
          </View>
          <Text className="mt-4 text-base" style={{ color: TEXT_PRIMARY }}>
            {t('chat.transferVipDaysSelectLabel')}
          </Text>
          {loading ? (
            <View className="items-center py-4">
              <ActivityIndicator color={colors.primary} />
            </View>
          ) : packages.length === 0 ? (
            <Text className="py-3 text-center text-sm" style={{ color: TEXT_SECONDARY }}>
              {t('chat.transferVipDaysEmpty')}
            </Text>
          ) : (
            <Pressable
              onPress={() => setPickerOpen(true)}
              className="mt-1 flex-row items-center justify-between rounded px-3 py-2.5 active:bg-black/5"
              style={{ borderWidth: 1, borderColor: DIVIDER }}
            >
              {selected != null ? (
                <View className="min-w-0 flex-1">
                  <Text numberOfLines={1} className="text-sm font-medium" style={{ color: TEXT_PRIMARY }}>
                    {selected.name}
                  </Text>
                  <Text className="text-xs" style={{ color: TEXT_SECONDARY }}>
                    {t('chat.transferVipDaysDayUnit', { days: selected.days })} ·{' '}
                    {formatKen(selected.kenPrice)} {t('chat.transferKenUnit')}
                  </Text>
                </View>
              ) : (
                <Text className="min-w-0 flex-1 text-sm" style={{ color: TEXT_SECONDARY }}>
                  {t('chat.transferVipDaysSelectLabel')}
                </Text>
              )}
              <Text className="ml-2 text-xs" style={{ color: TEXT_SECONDARY }}>
                ▼
              </Text>
            </Pressable>
          )}
          <ListOptionDialog
            visible={pickerOpen}
            title={t('chat.transferVipDaysSelectLabel')}
            options={packages.map((item) => ({
              key: item.id,
              label: `${item.name} · ${formatKen(item.kenPrice)} ${t('chat.transferKenUnit')}`,
              onSelect: () => setSelectedId(item.id),
            }))}
            onClose={() => setPickerOpen(false)}
          />
        </View>
      ) : (
        <View className="px-1 py-1">
          <Text className="text-base" style={{ color: TEXT_SECONDARY }}>
            {t('chat.transferVipDaysReceiverLabel')}
          </Text>
          <TransferReceiverRow receiver={receiver} />
          <Text className="mt-3 text-base" style={{ color: TEXT_PRIMARY }}>
            {t('chat.transferVipDaysSummary', {
              name: selected?.name ?? '',
              days: selected?.days ?? 0,
              receiver: receiver.name,
              ken: formatKen(selected?.kenPrice ?? 0),
            })}
          </Text>
          <TransferWarning>{t('chat.transferVipDaysWarning')}</TransferWarning>
          <TransferPasswordField
            label={t('chat.transferVipDaysPasswordLabel')}
            placeholder={t('chat.transferVipDaysPasswordPlaceholder')}
            value={password}
            onChangeText={setPassword}
          />
        </View>
      )}
    </Dialog>
  );
}
