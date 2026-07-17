import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, Text, TextInput, View } from 'react-native';
import { formatKen, toApiError } from '@ola/shared/lib';
import { VipService } from '@ola/shared/services';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { VipPackageItem } from '@ola/shared/types';
import { Avatar } from '@components/ui/Avatar';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { ListOptionDialog } from '@components/ui/ListOptionDialog';
import { DIVIDER } from '@constants';

const vipIcon = require('@assets/icons/apps/vip.png');

const MUTED = 'rgba(0,0,0,0.54)';
const BODY = 'rgba(0,0,0,0.87)';
const PRIMARY = '#7cb342';

export interface TransferVipDaysReceiver {
  id: string;
  name: string;
  username?: string;
  avatar?: string;
}

interface TransferVipDaysDialogProps {
  visible: boolean;
  onClose: () => void;
  receiver: TransferVipDaysReceiver;
}

function ReceiverRow({ receiver }: { receiver: TransferVipDaysReceiver }) {
  return (
    <View className="flex-row items-center gap-3 py-2">
      <Avatar name={receiver.name} uri={receiver.avatar ?? undefined} size={40} />
      <View className="min-w-0 flex-1">
        <Text numberOfLines={1} className="text-base" style={{ color: BODY }}>
          {receiver.name}
        </Text>
        {receiver.username != null && (
          <Text numberOfLines={1} className="text-xs" style={{ color: MUTED }}>
            @{receiver.username}
          </Text>
        )}
      </View>
    </View>
  );
}

export function TransferVipDaysDialog({ visible, onClose, receiver }: TransferVipDaysDialogProps) {
  const { t } = useTranslation();
  const balance = useAuthStore((s) => s.user?.ken ?? 0);
  const setUser = useAuthStore((s) => s.setUser);
  const push = useToastStore((s) => s.push);

  const [step, setStep] = useState<'select' | 'confirm'>('select');
  const [loading, setLoading] = useState(true);
  const [packages, setPackages] = useState<VipPackageItem[]>([]);
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [pickerOpen, setPickerOpen] = useState(false);
  const [password, setPassword] = useState('');
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    if (!visible) return;
    let active = true;
    setLoading(true);
    VipService.listPackages()
      .then((res) => {
        if (!active) return;
        setPackages(res.items);
        setSelectedId((current) => current ?? res.items[0]?.id ?? null);
      })
      .catch(() => undefined)
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, [visible]);

  const selected = packages.find((item) => item.id === selectedId) ?? null;

  function goToConfirm() {
    if (selected == null) {
      push('error', t('chat.transferVipDaysErrSelect'));
      return;
    }
    if (selected.kenPrice > balance) {
      push('error', t('chat.transferVipDaysErrNotEnough'));
      return;
    }
    setStep('confirm');
  }

  async function submitGift() {
    if (selected == null || receiver.username == null || receiver.username === '') {
      push('error', t('chat.actionError'));
      return;
    }
    if (password.trim() === '') {
      push('error', t('chat.transferVipDaysErrPassword'));
      return;
    }
    setSubmitting(true);
    try {
      const result = await VipService.giftPackage(selected.id, receiver.username, password);
      const current = useAuthStore.getState().user;
      if (current != null) setUser({ ...current, ken: result.kenBalance });
      push('success', t('chat.transferVipDaysSuccess', { days: result.days, name: receiver.name }));
      onClose();
    } catch (error) {
      const apiError = toApiError(error);
      if (apiError.status === 0) {
        push('error', t('chat.transferVipDaysError'));
      } else if (apiError.status === 401) {
        push('error', t('chat.transferVipDaysErrWrongPassword'));
      } else if (apiError.status === 403) {
        push('error', t('chat.transferKenErrBlocked'));
      } else {
        push('error', apiError.message);
      }
    } finally {
      setSubmitting(false);
    }
  }

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
            <Text className="text-lg font-bold" style={{ color: MUTED }}>
              {t('chat.transferVipDaysBalance')}
            </Text>
            <Text className="text-lg font-bold" style={{ color: BODY }}>
              {formatKen(balance)} {t('chat.transferKenUnit')}
            </Text>
          </View>
          <View className="my-2" style={{ height: 1, backgroundColor: DIVIDER }} />
          <Text className="text-base" style={{ color: BODY }}>
            {t('chat.transferVipDaysReceiverLabel')}
          </Text>
          <View className="mt-1 rounded px-3" style={{ borderWidth: 1, borderColor: DIVIDER }}>
            <ReceiverRow receiver={receiver} />
          </View>
          <Text className="mt-4 text-base" style={{ color: BODY }}>
            {t('chat.transferVipDaysSelectLabel')}
          </Text>
          {loading ? (
            <View className="items-center py-4">
              <ActivityIndicator color={PRIMARY} />
            </View>
          ) : packages.length === 0 ? (
            <Text className="py-3 text-center text-sm" style={{ color: MUTED }}>
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
                  <Text numberOfLines={1} className="text-sm font-medium" style={{ color: BODY }}>
                    {selected.name}
                  </Text>
                  <Text className="text-xs" style={{ color: MUTED }}>
                    {t('chat.transferVipDaysDayUnit', { days: selected.days })} ·{' '}
                    {formatKen(selected.kenPrice)} {t('chat.transferKenUnit')}
                  </Text>
                </View>
              ) : (
                <Text className="min-w-0 flex-1 text-sm" style={{ color: MUTED }}>
                  {t('chat.transferVipDaysSelectLabel')}
                </Text>
              )}
              <Text className="ml-2 text-xs" style={{ color: MUTED }}>
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
          <Text className="text-base" style={{ color: MUTED }}>
            {t('chat.transferVipDaysReceiverLabel')}
          </Text>
          <ReceiverRow receiver={receiver} />
          <Text className="mt-3 text-base" style={{ color: BODY }}>
            {t('chat.transferVipDaysSummary', {
              name: selected?.name ?? '',
              days: selected?.days ?? 0,
              receiver: receiver.name,
              ken: formatKen(selected?.kenPrice ?? 0),
            })}
          </Text>
          <View
            className="mt-3 rounded-lg px-3 py-2.5"
            style={{
              borderWidth: 1,
              borderColor: 'rgba(227,69,69,0.3)',
              backgroundColor: 'rgba(227,69,69,0.05)',
            }}
          >
            <Text className="text-center text-sm font-semibold" style={{ color: 'rgba(227,69,69,0.8)' }}>
              {t('chat.transferVipDaysWarning')}
            </Text>
          </View>
          <Text className="mt-4 text-base" style={{ color: BODY }}>
            {t('chat.transferVipDaysPasswordLabel')}
          </Text>
          <TextInput
            autoFocus
            secureTextEntry
            value={password}
            onChangeText={setPassword}
            placeholder={t('chat.transferVipDaysPasswordPlaceholder')}
            placeholderTextColor="rgba(0,0,0,0.38)"
            className="mt-1 w-full rounded px-3 py-2 text-base"
            style={{ borderWidth: 1, borderColor: DIVIDER, color: BODY }}
          />
        </View>
      )}
    </Dialog>
  );
}
