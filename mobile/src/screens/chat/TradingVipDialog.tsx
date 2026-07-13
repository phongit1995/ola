import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, ScrollView, Text, TextInput, View } from 'react-native';
import { toApiError, vipName } from '@ola/shared/lib';
import { VipService } from '@ola/shared/services';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { VipIconInstance } from '@ola/shared/types';
import { Avatar } from '../../components/Avatar';
import { VipBadge } from '../../components/VipBadge';
import { Dialog, DialogButton } from '../../components/Dialog';

const MUTED = 'rgba(0,0,0,0.54)';
const BODY = 'rgba(0,0,0,0.87)';
const DIVIDER = 'rgba(0,0,0,0.12)';
const PRIMARY = '#7cb342';

export interface TradingVipReceiver {
  id: string;
  name: string;
  username?: string;
  avatar?: string;
}

interface TradingVipDialogProps {
  visible: boolean;
  onClose: () => void;
  receiver: TradingVipReceiver;
}

function ReceiverRow({ receiver }: { receiver: TradingVipReceiver }) {
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

export function TradingVipDialog({ visible, onClose, receiver }: TradingVipDialogProps) {
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);

  const [step, setStep] = useState<'select' | 'confirm'>('select');
  const [loading, setLoading] = useState(true);
  const [vips, setVips] = useState<VipIconInstance[]>([]);
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [password, setPassword] = useState('');
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    if (!visible) return;
    let active = true;
    setLoading(true);
    VipService.store({ limit: 100 })
      .then((res) => {
        if (active) setVips(res.items.filter((item) => !item.isUsing && !item.isLocked));
      })
      .catch(() => undefined)
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, [visible]);

  const selected = vips.find((item) => item.instanceId === selectedId) ?? null;

  function pickVip(instanceId: string) {
    setSelectedId(instanceId);
    setStep('confirm');
  }

  async function submitTransfer() {
    if (selected == null) {
      push('error', t('chat.tradingVipErrSelect'));
      return;
    }
    if (password.trim() === '') {
      push('error', t('chat.tradingVipErrPassword'));
      return;
    }
    if (receiver.id === '') {
      push('error', t('chat.actionError'));
      return;
    }
    setSubmitting(true);
    try {
      await VipService.transferIcon(selected.instanceId, { toUserId: receiver.id, password });
      push('success', t('chat.tradingVipSuccess', { name: receiver.name }));
      onClose();
    } catch (error) {
      const apiError = toApiError(error);
      if (apiError.status === 401) {
        push('error', t('chat.tradingVipErrWrongPassword'));
      } else if (apiError.status === 403) {
        push('error', t('chat.tradingVipErrNotAllowed'));
      } else if (apiError.status === 0) {
        push('error', t('chat.tradingVipError'));
      } else {
        push('error', apiError.message);
      }
    } finally {
      setSubmitting(false);
    }
  }

  const footer =
    step === 'confirm' ? (
      <>
        <DialogButton onPress={() => setStep('select')} disabled={submitting}>
          {t('chat.transferKenEdit')}
        </DialogButton>
        <DialogButton variant="green" onPress={() => void submitTransfer()} disabled={submitting}>
          {t('chat.tradingVipOk')}
        </DialogButton>
      </>
    ) : null;

  return (
    <Dialog visible={visible} onClose={onClose} title={t('chat.tradingVipTitle')} footer={footer}>
      {step === 'select' ? (
        <View className="px-1 py-1">
          <Text className="text-base" style={{ color: MUTED }}>
            {t('chat.tradingVipReceiverLabel')}
          </Text>
          <View className="mt-1 rounded px-3" style={{ borderWidth: 1, borderColor: DIVIDER }}>
            <ReceiverRow receiver={receiver} />
          </View>

          <Text className="mt-4 text-base" style={{ color: BODY }}>
            {t('chat.tradingVipSelectLabel')}
          </Text>
          {loading ? (
            <View className="items-center py-6">
              <ActivityIndicator color={PRIMARY} />
            </View>
          ) : vips.length === 0 ? (
            <Text className="mt-2 text-sm" style={{ color: MUTED }}>
              {t('chat.tradingVipEmpty')}
            </Text>
          ) : (
            <ScrollView
              className="mt-2"
              style={{ maxHeight: 224 }}
              keyboardShouldPersistTaps="handled"
            >
              <View className="flex-row flex-wrap">
                {vips.map((vip) => (
                  <View key={vip.instanceId} style={{ width: '25%', padding: 4 }}>
                    <Pressable
                      onPress={() => pickVip(vip.instanceId)}
                      className="items-center gap-1 rounded p-2 active:opacity-70"
                      style={{ borderWidth: 1, borderColor: DIVIDER }}
                    >
                      <VipBadge typeId={vip.typeId} size={40} />
                      <Text
                        numberOfLines={1}
                        className="w-full text-center"
                        style={{ fontSize: 10, color: MUTED }}
                      >
                        {vipName(vip.typeId)}
                      </Text>
                    </Pressable>
                  </View>
                ))}
              </View>
            </ScrollView>
          )}
        </View>
      ) : (
        <View className="px-1 py-1">
          <Text className="text-base" style={{ color: MUTED }}>
            {t('chat.tradingVipReceiverLabel')}
          </Text>
          <ReceiverRow receiver={receiver} />

          <Text className="mt-4 text-base" style={{ color: MUTED }}>
            {t('chat.tradingVipSelectLabel')}
          </Text>
          {selected != null && (
            <View className="mt-2 flex-row items-center gap-2">
              <VipBadge typeId={selected.typeId} size={40} />
              <Text className="text-sm font-semibold" style={{ color: BODY }}>
                {vipName(selected.typeId)}
              </Text>
            </View>
          )}

          <Text className="mt-4 text-base" style={{ color: BODY }}>
            {t('chat.tradingVipPasswordLabel')}
          </Text>
          <TextInput
            autoFocus
            secureTextEntry
            value={password}
            onChangeText={setPassword}
            placeholder={t('chat.tradingVipPasswordPlaceholder')}
            placeholderTextColor="rgba(0,0,0,0.38)"
            className="mt-1 w-full rounded px-3 py-2 text-base"
            style={{ borderWidth: 1, borderColor: DIVIDER, color: BODY }}
          />
        </View>
      )}
    </Dialog>
  );
}
