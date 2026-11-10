import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Text, View } from 'react-native';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { useVipDayTransferForm } from '@ola/shared/stores/vip/useVipDayTransferForm';
import { TransferReceiverRow } from '@components/transfer/TransferReceiverRow';
import type { TransferReceiver } from '@components/transfer/types';
import { TransferPasswordField } from '@components/transfer/TransferPasswordField';
import { TransferWarning } from '@components/transfer/TransferWarning';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { DIVIDER, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { VipDayTransferFields } from '@screens/vip/components/VipDayTransferFields';
import { VipDayTransferSummary } from '@screens/vip/components/VipDayTransferSummary';

const vipIcon = require('@assets/icons/apps/vip.png');

interface VipDayTransferDialogProps {
  visible: boolean;
  onClose: () => void;
  receiver: TransferReceiver;
}

export function VipDayTransferDialog({ visible, onClose, receiver }: VipDayTransferDialogProps) {
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);
  const form = useVipDayTransferForm(t);
  const [step, setStep] = useState<'input' | 'confirm'>('input');
  const [password, setPassword] = useState('');

  function goToConfirm() {
    const inputError = form.inputError();
    if (inputError != null) {
      push('error', inputError);
      return;
    }
    setStep('confirm');
  }

  async function submit() {
    if (receiver.username == null || receiver.username === '') {
      push('error', t('chat.actionError'));
      return;
    }
    if (password.trim() === '') {
      push('error', t('vip.buy.needPassword'));
      return;
    }
    if (await form.submit(receiver.username, password)) onClose();
  }

  const footer =
    step === 'input' ? (
      <DialogButton variant="green" onPress={goToConfirm}>
        {t('chat.transferVipDaysOk')}
      </DialogButton>
    ) : (
      <>
        <DialogButton onPress={() => setStep('input')} disabled={form.submitting}>
          {t('chat.transferVipDaysEdit')}
        </DialogButton>
        <DialogButton variant="green" onPress={() => void submit()} disabled={form.submitting}>
          {t('vip.buy.actionTransferDays')}
        </DialogButton>
      </>
    );

  return (
    <Dialog
      visible={visible}
      onClose={onClose}
      title={t('vip.buy.titleTransferDays')}
      icon={vipIcon}
      footer={footer}
    >
      {step === 'input' ? (
        <View className="px-1 py-1">
          <Text className="text-base" style={{ color: TEXT_PRIMARY }}>
            {t('chat.transferVipDaysReceiverLabel')}
          </Text>
          <View className="mb-3 mt-1 rounded px-3" style={{ borderWidth: 1, borderColor: DIVIDER }}>
            <TransferReceiverRow receiver={receiver} />
          </View>
          <VipDayTransferFields form={form} />
        </View>
      ) : (
        <View className="px-1 py-1">
          <Text className="text-base" style={{ color: TEXT_SECONDARY }}>
            {t('chat.transferVipDaysReceiverLabel')}
          </Text>
          <TransferReceiverRow receiver={receiver} />
          <View className="mt-3">
            <VipDayTransferSummary
              senderDays={form.senderDays}
              receiverDays={form.receiverDays}
              receiver={receiver.username ?? receiver.name}
            />
          </View>
          <TransferWarning>{t('vip.buy.transferDaysWarning')}</TransferWarning>
          <TransferPasswordField
            label={t('vip.buy.passwordLabel')}
            placeholder={t('vip.buy.passwordPlaceholder')}
            value={password}
            onChangeText={setPassword}
          />
        </View>
      )}
    </Dialog>
  );
}
