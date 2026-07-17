import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, ScrollView, Text, TextInput, View } from 'react-native';
import Clipboard from '@react-native-clipboard/clipboard';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { buildVietQrImageUrl, fillMemoTemplate, formatKen, formatVnd } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { useTopupConfigStore } from '@ola/shared/stores/topupConfigStore';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { ScreenHeader } from '@components/ui/ScreenHeader';

const MIN_AMOUNT = 10_000;
const STEP_AMOUNT = 1_000;
const PRESET_AMOUNTS = [10_000, 20_000, 50_000, 100_000, 200_000, 500_000];
const QR_SIZE = 224;
const MUTED = 'rgba(0,0,0,0.54)';
const BODY = 'rgba(0,0,0,0.87)';
const DIVIDER = 'rgba(0,0,0,0.12)';

function CopyRow({ label, value }: { label: string; value: string }) {
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);

  function copyValue() {
    Clipboard.setString(value);
    push('info', t('ken.buy.copied'));
  }

  return (
    <View
      className="flex-row items-center py-2"
      style={{ borderBottomWidth: 1, borderBottomColor: 'rgba(0,0,0,0.08)' }}
    >
      <View className="min-w-0 flex-1">
        <Text className="text-xs" style={{ color: MUTED }}>{label}</Text>
        <Text className="text-sm font-medium" style={{ color: BODY }} numberOfLines={1}>
          {value}
        </Text>
      </View>
      <Pressable
        onPress={copyValue}
        className="ml-2 shrink-0 rounded px-2 py-1 active:bg-black/5"
        style={{ borderWidth: 1, borderColor: DIVIDER }}
      >
        <Text className="text-xs" style={{ color: '#7cb342' }}>{t('common.copy')}</Text>
      </Pressable>
    </View>
  );
}

type Props = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.BuyKen>;

export function BuyKenScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const user = useAuthStore((s) => s.user);
  const push = useToastStore((s) => s.push);

  const config = useTopupConfigStore((s) => s.config);
  const loadConfig = useTopupConfigStore((s) => s.load);
  const [selectedPreset, setSelectedPreset] = useState<number | null>(null);
  const [customText, setCustomText] = useState<string | null>(null);

  useEffect(() => {
    void loadConfig();
  }, [loadConfig]);

  const minAmount = config?.minAmount ?? MIN_AMOUNT;
  const stepAmount = config?.stepAmount ?? STEP_AMOUNT;
  const presetAmounts = config?.presetAmounts ?? PRESET_AMOUNTS;
  const kenPerVnd = config?.kenPerVnd ?? 1;
  const bank = config?.bank;

  const amount =
    customText == null
      ? (selectedPreset ?? presetAmounts[0] ?? minAmount)
      : customText === ''
        ? 0
        : Number(customText);
  const isValid = amount >= minAmount && amount % stepAmount === 0;
  const kenAmount = amount * kenPerVnd;
  const balance = user?.ken ?? 0;

  const memo = useMemo(
    () => fillMemoTemplate(bank?.memoTemplate || '@{username}', user?.username ?? ''),
    [bank?.memoTemplate, user?.username],
  );

  const qrImageUrl = useMemo(() => {
    if (!bank?.bankBin || !bank.accountNumber || !isValid) return null;
    return buildVietQrImageUrl({
      bankBin: bank.bankBin,
      accountNumber: bank.accountNumber,
      amount,
      memo,
      accountName: bank.accountName,
    });
  }, [bank, isValid, amount, memo]);

  function selectPreset(value: number) {
    setSelectedPreset(value);
    setCustomText(null);
  }

  function changeCustom(raw: string) {
    setCustomText(raw.replace(/\D/g, ''));
  }

  return (
    <View className="flex-1" style={{ backgroundColor: '#ececec' }}>
      <ScreenHeader title={t('ken.buy.title')} onBack={() => navigation.goBack()} />

      <ScrollView className="flex-1" contentContainerClassName="pb-6" keyboardShouldPersistTaps="handled">
        <View
          className="m-2 flex-row items-center rounded-sm bg-white px-3 py-2.5"
          style={{ borderWidth: 1, borderColor: DIVIDER }}
        >
          <Text className="text-sm" style={{ color: MUTED }}>{t('ken.buy.balance')}</Text>
          <Text className="ml-2 flex-1 text-lg font-bold" style={{ color: '#7cb342' }}>
            {formatKen(balance)} KEN
          </Text>
        </View>

        {config == null ? (
          <View className="mx-2 rounded-sm bg-white p-4" style={{ borderWidth: 1, borderColor: DIVIDER }}>
            <Text className="text-center text-sm" style={{ color: MUTED }}>
              {t('common.loading')}
            </Text>
          </View>
        ) : !config.enabled ? (
          <View className="mx-2 rounded-sm bg-white p-4" style={{ borderWidth: 1, borderColor: DIVIDER }}>
            <Text className="text-center text-sm" style={{ color: MUTED }}>
              {t('ken.buy.disabled')}
            </Text>
          </View>
        ) : (
          <>
            <View className="mx-2 rounded-sm bg-white p-3" style={{ borderWidth: 1, borderColor: DIVIDER }}>
              <Text className="text-xs" style={{ color: MUTED }}>{t('ken.buy.chooseAmount')}</Text>
              <View className="mt-2 flex-row flex-wrap" style={{ marginHorizontal: -4 }}>
                {presetAmounts.map((value) => {
                  const selected = amount === value && customText == null;
                  return (
                    <View key={value} style={{ width: '33.33%', padding: 4 }}>
                      <Pressable
                        onPress={() => selectPreset(value)}
                        className="items-center rounded px-2 py-2"
                        style={{
                          borderWidth: 1,
                          borderColor: selected ? '#7cb342' : DIVIDER,
                          backgroundColor: selected ? 'rgba(124,179,66,0.1)' : '#ffffff',
                        }}
                      >
                        <Text
                          className="text-sm font-medium"
                          style={{ color: selected ? '#7cb342' : BODY }}
                        >
                          {formatVnd(value)}đ
                        </Text>
                      </Pressable>
                    </View>
                  );
                })}
              </View>

              <Text className="mt-3 text-xs" style={{ color: MUTED }}>{t('ken.buy.customLabel')}</Text>
              <TextInput
                keyboardType="number-pad"
                value={customText ?? ''}
                onChangeText={changeCustom}
                placeholder={t('ken.buy.customHint', {
                  min: formatVnd(minAmount),
                  step: formatVnd(stepAmount),
                })}
                placeholderTextColor="rgba(0,0,0,0.38)"
                className="mt-1 w-full rounded px-3 py-2 text-base"
                style={{ borderWidth: 1, borderColor: DIVIDER, color: BODY, backgroundColor: '#fff' }}
              />

              <View className="mt-3 flex-row items-center">
                <Text className="text-sm" style={{ color: MUTED }}>{t('ken.buy.receive')}</Text>
                <Text className="ml-2 flex-1 text-lg font-bold" style={{ color: '#ff4081' }}>
                  {formatKen(isValid ? kenAmount : 0)} KEN
                </Text>
              </View>
              {!isValid && (
                <Text className="mt-1 text-xs" style={{ color: '#e34545' }}>
                  {t('ken.buy.invalid', {
                    min: formatVnd(minAmount),
                    step: formatVnd(stepAmount),
                  })}
                </Text>
              )}
            </View>

            {isValid && (
              <View
                className="mx-2 mt-2 rounded-sm bg-white p-3"
                style={{ borderWidth: 1, borderColor: DIVIDER }}
              >
                {bank == null ? (
                  <Text className="py-4 text-center text-sm" style={{ color: MUTED }}>
                    {t('ken.buy.notConfigured')}
                  </Text>
                ) : (
                  <>
                    <Text className="text-center text-sm font-medium" style={{ color: BODY }}>
                      {t('ken.buy.qrTitle')}
                    </Text>
                    {qrImageUrl != null && (
                      <View className="mt-3 items-center">
                        <View
                          className="rounded p-2"
                          style={{ borderWidth: 1, borderColor: DIVIDER, backgroundColor: '#ffffff' }}
                        >
                          <Image
                            source={{ uri: qrImageUrl }}
                            style={{ width: QR_SIZE, height: QR_SIZE }}
                            resizeMode="contain"
                          />
                        </View>
                      </View>
                    )}
                    <View className="mt-3">
                      {bank.bankName !== '' && (
                        <View
                          className="py-2"
                          style={{ borderBottomWidth: 1, borderBottomColor: 'rgba(0,0,0,0.08)' }}
                        >
                          <Text className="text-xs" style={{ color: MUTED }}>
                            {t('ken.buy.bankLabel')}
                          </Text>
                          <Text className="text-sm font-medium" style={{ color: BODY }}>
                            {bank.bankName}
                          </Text>
                        </View>
                      )}
                      <CopyRow label={t('ken.buy.accountNumberLabel')} value={bank.accountNumber} />
                      {bank.accountName !== '' && (
                        <View
                          className="py-2"
                          style={{ borderBottomWidth: 1, borderBottomColor: 'rgba(0,0,0,0.08)' }}
                        >
                          <Text className="text-xs" style={{ color: MUTED }}>
                            {t('ken.buy.accountNameLabel')}
                          </Text>
                          <Text className="text-sm font-medium" style={{ color: BODY }}>
                            {bank.accountName}
                          </Text>
                        </View>
                      )}
                      {memo !== '' && <CopyRow label={t('ken.buy.memoLabel')} value={memo} />}
                    </View>
                    <View className="mt-3 items-center">
                      <Text className="text-xs" style={{ color: MUTED }}>{t('ken.buy.amountLabel')}</Text>
                      <Text className="text-lg font-bold" style={{ color: BODY }}>
                        {formatVnd(amount)}đ
                      </Text>
                    </View>
                    <Text className="mt-2 text-center text-xs" style={{ color: MUTED }}>
                      {t('ken.buy.qrHint', { ken: formatKen(kenAmount) })}
                    </Text>
                    <Pressable
                      onPress={() => push('info', t('ken.buy.paidPending'))}
                      className="mt-3 w-full items-center rounded-sm border border-ola-primary-dark py-2.5 active:opacity-90"
                      style={{ backgroundColor: '#9ccc65' }}
                    >
                      <Text className="text-sm font-medium text-white">{t('ken.buy.paid')}</Text>
                    </Pressable>
                    <Text className="mt-2 text-center text-[11px]" style={{ color: 'rgba(0,0,0,0.38)' }}>
                      {t('ken.buy.memoHint')}
                    </Text>
                  </>
                )}
              </View>
            )}
          </>
        )}
      </ScrollView>
    </View>
  );
}
