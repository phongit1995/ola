import { useTranslation } from 'react-i18next';
import { Pressable, Text, TextInput, View } from 'react-native';
import { formatKen } from '@ola/shared/lib';
import type { UserSearchResult } from '@ola/shared/types';
import { TransferReceiverRow } from '@components/transfer/TransferReceiverRow';
import type { TransferReceiver } from '@components/transfer/types';
import { TransferPasswordField } from '@components/transfer/TransferPasswordField';
import { TransferWarning } from '@components/transfer/TransferWarning';
import { userIdentityFromSearchResult } from '@components/user/userIdentity';
import { UserSearchPicker } from '@components/user/UserSearchPicker';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { DIVIDER, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { useThemeColors } from '@hooks/useThemeColors';
import { useTransferKen } from '@ola/shared/stores/ken/useTransferKen';

const kenIcon = require('@assets/icons/apps/ken.png');

interface TransferKenDialogProps {
  visible: boolean;
  onClose: () => void;
  receiver?: TransferReceiver;
}

function toReceiver(user: UserSearchResult): TransferReceiver {
  return {
    id: user.id,
    ...userIdentityFromSearchResult(user),
  };
}

export function TransferKenDialog({ visible, onClose, receiver }: TransferKenDialogProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const {
    balance,
    step,
    setStep,
    activeReceiver,
    amount,
    displayAmount,
    changeAmount,
    password,
    setPassword,
    submitting,
    pickReceiver,
    changeReceiver,
    goToConfirm,
    submitTransfer,
  } = useTransferKen({ receiver, toReceiver, onDone: onClose });

  const title = step === 'confirm' ? t('chat.transferKenConfirmTitle') : t('chat.transferKenTitle');

  const footer =
    step === 'recipient' ? undefined : step === 'input' ? (
      <DialogButton variant="green" onPress={goToConfirm}>
        {t('chat.transferKenOk')}
      </DialogButton>
    ) : (
      <>
        <DialogButton onPress={() => setStep('input')} disabled={submitting}>
          {t('chat.transferKenEdit')}
        </DialogButton>
        <DialogButton variant="green" onPress={() => void submitTransfer()} disabled={submitting}>
          {t('chat.transferKenOk')}
        </DialogButton>
      </>
    );

  return (
    <Dialog visible={visible} onClose={onClose} title={title} icon={kenIcon} footer={footer}>
      {step === 'recipient' ? (
        <UserSearchPicker
          label={t('chat.transferKenReceiver')}
          placeholder={t('chat.transferKenReceiverHint')}
          onPick={pickReceiver}
        />
      ) : step === 'input' ? (
        <View className="px-1 py-1">
          <View className="flex-row items-center justify-center gap-2">
            <Text className="text-lg font-bold" style={{ color: TEXT_SECONDARY }}>
              {t('chat.transferKenBalance')}
            </Text>
            <Text className="text-lg font-bold" style={{ color: TEXT_PRIMARY }}>
              {formatKen(balance)} {t('chat.transferKenUnit')}
            </Text>
          </View>
          <View className="my-2" style={{ height: 1, backgroundColor: DIVIDER }} />
          <View className="flex-row items-center justify-between">
            <Text className="text-base" style={{ color: TEXT_PRIMARY }}>{t('chat.transferKenReceiver')}</Text>
            {receiver == null && (
              <Pressable onPress={changeReceiver} className="active:opacity-70">
                <Text className="text-sm font-medium" style={{ color: colors.primary }}>
                  {t('chat.transferKenChangeReceiver')}
                </Text>
              </Pressable>
            )}
          </View>
          {activeReceiver != null && (
            <View className="mt-1 rounded px-3" style={{ borderWidth: 1, borderColor: DIVIDER }}>
              <TransferReceiverRow receiver={activeReceiver} />
            </View>
          )}
          <Text className="mt-4 text-base" style={{ color: TEXT_PRIMARY }}>
            {t('chat.transferKenAmountLabel')}
          </Text>
          <TextInput
            autoFocus
            keyboardType="number-pad"
            value={displayAmount}
            onChangeText={changeAmount}
            placeholder={t('chat.transferKenAmountPlaceholder')}
            placeholderTextColor="rgba(0,0,0,0.38)"
            className="mt-1 w-full rounded px-3 py-2 text-base"
            style={{ borderWidth: 1, borderColor: DIVIDER, color: TEXT_PRIMARY }}
          />
        </View>
      ) : (
        <View className="px-1 py-1">
          <Text className="text-base" style={{ color: TEXT_SECONDARY }}>{t('chat.transferKenReceiver')}</Text>
          {activeReceiver != null && (
            <TransferReceiverRow receiver={activeReceiver} />
          )}
          <Text className="mt-4 text-base" style={{ color: TEXT_SECONDARY }}>
            {t('chat.transferKenConfirmAmountLabel')}
          </Text>
          <Text className="mt-2 text-lg font-bold" style={{ color: TEXT_PRIMARY }}>
            {formatKen(amount)} {t('chat.transferKenUnit')}
          </Text>
          <TransferWarning>{t('chat.transferKenWarning')}</TransferWarning>
          <TransferPasswordField
            label={t('chat.transferKenPassword')}
            placeholder={t('chat.transferKenPasswordPlaceholder')}
            value={password}
            onChangeText={setPassword}
          />
        </View>
      )}
    </Dialog>
  );
}
