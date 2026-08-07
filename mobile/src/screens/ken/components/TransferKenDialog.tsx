import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, ScrollView, Text, TextInput, View } from 'react-native';
import { formatKen, toApiError } from '@ola/shared/lib';
import { KenService, UserService } from '@ola/shared/services';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import type { UserSearchResult } from '@ola/shared/types';
import { TransferReceiverRow } from '@components/transfer/TransferReceiverRow';
import type { TransferReceiver } from '@components/transfer/types';
import { TransferPasswordField } from '@components/transfer/TransferPasswordField';
import { TransferWarning } from '@components/transfer/TransferWarning';
import { userIdentityFromSearchResult } from '@components/user/userIdentity';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { DIVIDER, PRIMARY, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';

const kenIcon = require('@assets/icons/apps/ken.png');

const KEN_TRANSFER_MIN = 1000;
const KEN_TRANSFER_MAX = 10_000_000;

interface TransferKenDialogProps {
  visible: boolean;
  onClose: () => void;
  receiver?: TransferReceiver;
}

type Step = 'recipient' | 'input' | 'confirm';

function onlyDigits(value: string): string {
  return value.replace(/\D/g, '').slice(0, 12);
}

function toReceiver(user: UserSearchResult): TransferReceiver {
  return {
    id: user.id,
    ...userIdentityFromSearchResult(user),
  };
}

export function TransferKenDialog({ visible, onClose, receiver }: TransferKenDialogProps) {
  const { t } = useTranslation();
  const myId = useAuthStore((s) => s.user?.id ?? '');
  const balance = useAuthStore((s) => s.user?.ken ?? 0);
  const setUser = useAuthStore((s) => s.setUser);
  const push = useToastStore((s) => s.push);

  const [step, setStep] = useState<Step>(receiver != null ? 'input' : 'recipient');
  const [pickedReceiver, setPickedReceiver] =
    useState<TransferReceiver | null>(null);
  const [query, setQuery] = useState('');
  const [results, setResults] = useState<UserSearchResult[]>([]);
  const [searching, setSearching] = useState(false);
  const [amountDigits, setAmountDigits] = useState('');
  const [password, setPassword] = useState('');
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    const value = query.trim();
    const timer = setTimeout(() => {
      if (value === '') {
        setResults([]);
        setSearching(false);
        return;
      }
      setSearching(true);
      UserService.search(value, 30)
        .then((res) => setResults(res.users))
        .catch(() => setResults([]))
        .finally(() => setSearching(false));
    }, 300);
    return () => clearTimeout(timer);
  }, [query]);

  const activeReceiver = receiver ?? pickedReceiver;
  const amount = amountDigits === '' ? 0 : Number(amountDigits);
  const displayAmount = amountDigits === '' ? '' : formatKen(amount);

  function pickReceiver(user: UserSearchResult) {
    setPickedReceiver(toReceiver(user));
    setQuery('');
    setResults([]);
    setStep('input');
  }

  function changeReceiver() {
    setPickedReceiver(null);
    setAmountDigits('');
    setStep('recipient');
  }

  function goToConfirm() {
    if (activeReceiver == null) return;
    if (amount <= 0) {
      push('error', t('chat.transferKenErrEmpty'));
      return;
    }
    if (activeReceiver.id === myId) {
      push('error', t('chat.transferKenErrSelf'));
      return;
    }
    if (amount < KEN_TRANSFER_MIN) {
      push('error', t('chat.transferKenErrMin', { min: formatKen(KEN_TRANSFER_MIN) }));
      return;
    }
    if (amount > KEN_TRANSFER_MAX) {
      push('error', t('chat.transferKenErrMax', { max: formatKen(KEN_TRANSFER_MAX) }));
      return;
    }
    if (amount > balance) {
      push('error', t('chat.transferKenErrNotEnough'));
      return;
    }
    setStep('confirm');
  }

  async function submitTransfer() {
    if (activeReceiver == null) return;
    if (password.trim() === '') {
      push('error', t('chat.transferKenErrPasswordEmpty'));
      return;
    }
    setSubmitting(true);
    try {
      const result = await KenService.transfer({ toUserId: activeReceiver.id, amount, password });
      const current = useAuthStore.getState().user;
      if (current != null) setUser({ ...current, ken: result.kenBalance });
      push('success', t('chat.transferKenSuccess', { name: activeReceiver.name }));
      onClose();
    } catch (error) {
      const apiError = toApiError(error);
      if (apiError.status === 0) {
        push('error', t('chat.transferKenError'));
      } else if (apiError.status === 401) {
        push('error', t('chat.transferKenErrPassword'));
      } else if (apiError.status === 403) {
        push('error', t('chat.transferKenErrBlocked'));
      } else {
        push('error', apiError.message);
      }
    } finally {
      setSubmitting(false);
    }
  }

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
        <View className="px-1 py-1">
          <Text className="text-base" style={{ color: TEXT_PRIMARY }}>{t('chat.transferKenReceiver')}</Text>
          <TextInput
            autoFocus
            value={query}
            onChangeText={setQuery}
            placeholder={t('chat.transferKenReceiverHint')}
            placeholderTextColor="rgba(0,0,0,0.38)"
            autoCapitalize="none"
            className="mt-1 w-full rounded px-3 py-2 text-base"
            style={{ borderWidth: 1, borderColor: DIVIDER, color: TEXT_PRIMARY }}
          />
          {query.trim() !== '' && (
            <View className="mt-2 rounded" style={{ borderWidth: 1, borderColor: DIVIDER, maxHeight: 224 }}>
              {searching ? (
                <Text className="py-3 text-center text-sm" style={{ color: TEXT_SECONDARY }}>
                  {t('common.loading')}
                </Text>
              ) : results.length === 0 ? (
                <Text className="py-3 text-center text-sm" style={{ color: TEXT_SECONDARY }}>
                  {t('chat.composeSearchEmpty')}
                </Text>
              ) : (
                <ScrollView keyboardShouldPersistTaps="handled" className="px-2">
                  {results.map((item, index) => (
                    <View
                      key={item.id}
                      style={index > 0 ? { borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.08)' } : null}
                    >
                      <TransferReceiverRow
                        receiver={toReceiver(item)}
                        onPress={() => pickReceiver(item)}
                      />
                    </View>
                  ))}
                </ScrollView>
              )}
            </View>
          )}
        </View>
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
                <Text className="text-sm font-medium" style={{ color: PRIMARY }}>
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
            onChangeText={(text) => setAmountDigits(onlyDigits(text))}
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
