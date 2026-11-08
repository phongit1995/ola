import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ScrollView, Text, TextInput, View } from 'react-native';
import { avatarFrameErrorKey } from '@ola/shared/lib';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { ReceiverField } from '@screens/vip/components/ReceiverField';
import { DIVIDER, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { useReceiverSearch } from '../useReceiverSearch';
import { avatarFrameLabel } from '@ola/shared/lib/avatarFrame';

interface AvatarFrameTransferDialogProps {
  frameId: string;
  busy: boolean;
  onTransfer: (frameId: string, toUserId: string, password: string) => Promise<void>;
  onClose: () => void;
}

export function AvatarFrameTransferDialog({
  frameId,
  busy,
  onTransfer,
  onClose,
}: AvatarFrameTransferDialogProps) {
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);
  const search = useReceiverSearch();
  const [password, setPassword] = useState('');

  async function submit() {
    if (search.receiverUser == null) {
      push('info', t('vip.buy.needReceiver'));
      return;
    }
    if (password === '') {
      push('info', t('vip.buy.needPassword'));
      return;
    }
    try {
      await onTransfer(frameId, search.receiverUser.id, password);
      push('success', t('avatarFrame.toastTransferred'));
      onClose();
    } catch (error) {
      push('error', t(avatarFrameErrorKey(error)));
    }
  }

  return (
    <Dialog
      visible
      onClose={onClose}
      title={t('avatarFrame.transferTitle')}
      showClose
      showToasts
      footer={
        <>
          <DialogButton disabled={busy} onPress={onClose}>
            {t('avatarFrame.cancel')}
          </DialogButton>
          <DialogButton variant="green" disabled={busy} onPress={() => void submit()}>
            {t('avatarFrame.actionTransfer')}
          </DialogButton>
        </>
      }
    >
      <ScrollView keyboardShouldPersistTaps="handled" style={{ maxHeight: 420 }}>
        <Text className="px-2 text-sm font-semibold" style={{ color: TEXT_PRIMARY }}>
          {avatarFrameLabel(frameId)}
        </Text>
        <View style={{ marginHorizontal: -8 }}>
          <ReceiverField
            receiverUser={search.receiverUser}
            receiverQuery={search.receiverQuery}
            receiverResults={search.receiverResults}
            receiverSearching={search.receiverSearching}
            onChangeQuery={search.setReceiverQuery}
            onPick={search.pickReceiver}
            onClear={search.clearReceiver}
          />
        </View>
        <View className="mt-1 gap-1 px-2">
          <Text className="text-xs" style={{ color: TEXT_SECONDARY }}>
            {t('avatarFrame.password')}
          </Text>
          <TextInput
            value={password}
            onChangeText={setPassword}
            secureTextEntry
            placeholder={t('avatarFrame.passwordHint')}
            placeholderTextColor="rgba(0,0,0,0.38)"
            className="rounded px-3 py-2 text-sm"
            style={{
              borderWidth: 1,
              borderColor: DIVIDER,
              color: TEXT_PRIMARY,
              backgroundColor: '#ffffff',
            }}
          />
        </View>
      </ScrollView>
    </Dialog>
  );
}
