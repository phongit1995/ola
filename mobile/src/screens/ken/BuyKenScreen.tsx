import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, ScrollView, Text, TextInput, View } from 'react-native';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { TOPUP_PAID_REDIRECT_MS } from '@ola/shared/constants';
import { formatKen, formatVnd, topupBonusPercentFor, withAlpha } from '@ola/shared/lib';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { CachedImage } from '@components/ui/CachedImage';
import { useThemeColors } from '@hooks/useThemeColors';
import { DIVIDER, ERROR, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { KEN_ACCENT, QR_SIZE } from './constants';
import { useBuyKen } from './useBuyKen';
import { BankInfoRow } from './components/BankInfoRow';
import { CopyRow } from './components/CopyRow';

type Props = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.BuyKen>;

export function BuyKenScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const push = useToastStore((s) => s.push);
  const vm = useBuyKen();
  const [paidPending, setPaidPending] = useState(false);

  useEffect(() => {
    if (!paidPending) return;
    const timer = setTimeout(() => navigation.goBack(), TOPUP_PAID_REDIRECT_MS);
    return () => clearTimeout(timer);
  }, [paidPending, navigation]);

  function confirmPaid() {
    if (paidPending) return;
    setPaidPending(true);
    push('info', t('ken.buy.paidPending'));
  }

  return (
    <View className="flex-1" style={{ backgroundColor: '#ececec' }}>
      <ScreenHeader title={t('ken.buy.title')} onBack={() => navigation.goBack()} />

      <ScrollView
        className="flex-1"
        contentContainerClassName="pb-6"
        keyboardShouldPersistTaps="handled"
      >
        <View
          className="m-2 flex-row items-center rounded-sm bg-white px-3 py-2.5"
          style={{ borderWidth: 1, borderColor: DIVIDER }}
        >
          <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>{t('ken.buy.balance')}</Text>
          <Text className="ml-2 flex-1 text-lg font-bold" style={{ color: colors.primary }}>
            {formatKen(vm.balance)} KEN
          </Text>
        </View>

        {vm.config == null ? (
          <View
            className="mx-2 rounded-sm bg-white p-4"
            style={{ borderWidth: 1, borderColor: DIVIDER }}
          >
            <Text className="text-center text-sm" style={{ color: TEXT_SECONDARY }}>
              {t('common.loading')}
            </Text>
          </View>
        ) : !vm.config.enabled ? (
          <View
            className="mx-2 rounded-sm bg-white p-4"
            style={{ borderWidth: 1, borderColor: DIVIDER }}
          >
            <Text className="text-center text-sm" style={{ color: TEXT_SECONDARY }}>
              {t('ken.buy.disabled')}
            </Text>
          </View>
        ) : (
          <>
            <View
              className="mx-2 rounded-sm bg-white p-3"
              style={{ borderWidth: 1, borderColor: DIVIDER }}
            >
              <Text className="text-xs" style={{ color: TEXT_SECONDARY }}>
                {t('ken.buy.chooseAmount')}
              </Text>
              <View className="mt-2 flex-row flex-wrap" style={{ marginHorizontal: -4 }}>
                {vm.presetAmounts.map((value) => {
                  const selected = vm.amount === value && vm.customText == null;
                  const bonusPercent = topupBonusPercentFor(value, vm.bonusTiers);
                  return (
                    <View key={value} style={{ width: '33.33%', padding: 4 }}>
                      <Pressable
                        onPress={() => vm.selectPreset(value)}
                        className="items-center rounded px-2 py-2"
                        style={{
                          borderWidth: 1,
                          borderColor: selected ? colors.primary : DIVIDER,
                          backgroundColor: selected ? withAlpha(colors.primary, 0.1) : '#ffffff',
                        }}
                      >
                        <Text
                          className="text-sm font-medium"
                          style={{ color: selected ? colors.primary : TEXT_PRIMARY }}
                        >
                          {formatVnd(value)}đ
                        </Text>
                        {bonusPercent > 0 && (
                          <View
                            style={{
                              position: 'absolute',
                              top: -7,
                              right: 4,
                              borderRadius: 999,
                              paddingHorizontal: 6,
                              backgroundColor: KEN_ACCENT,
                            }}
                          >
                            <Text style={{ color: '#ffffff', fontSize: 10, fontWeight: '600' }}>
                              {t('ken.buy.bonusBadge', { percent: bonusPercent })}
                            </Text>
                          </View>
                        )}
                      </Pressable>
                    </View>
                  );
                })}
              </View>

              <Text className="mt-3 text-xs" style={{ color: TEXT_SECONDARY }}>
                {t('ken.buy.customLabel')}
              </Text>
              <TextInput
                keyboardType="number-pad"
                value={vm.customText ?? ''}
                onChangeText={vm.changeCustom}
                placeholder={t('ken.buy.customHint', {
                  min: formatVnd(vm.minAmount),
                  step: formatVnd(vm.stepAmount),
                })}
                placeholderTextColor="rgba(0,0,0,0.38)"
                className="mt-1 w-full rounded px-3 py-2 text-base"
                style={{
                  borderWidth: 1,
                  borderColor: DIVIDER,
                  color: TEXT_PRIMARY,
                  backgroundColor: '#fff',
                }}
              />

              <View className="mt-3 flex-row items-center">
                <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>
                  {t('ken.buy.receive')}
                </Text>
                <Text className="ml-2 flex-1 text-lg font-bold" style={{ color: KEN_ACCENT }}>
                  {formatKen(vm.isValid ? vm.kenAmount : 0)} KEN
                </Text>
              </View>
              {vm.isValid && vm.quote.bonus > 0 && (
                <Text className="mt-1 text-xs" style={{ color: KEN_ACCENT }}>
                  {t('ken.buy.bonusLine', {
                    bonus: formatKen(vm.quote.bonus),
                    percent: vm.quote.bonusPercent,
                  })}
                </Text>
              )}
              {!vm.isValid && (
                <Text className="mt-1 text-xs" style={{ color: ERROR }}>
                  {t('ken.buy.invalid', {
                    min: formatVnd(vm.minAmount),
                    step: formatVnd(vm.stepAmount),
                  })}
                </Text>
              )}
            </View>

            {vm.isValid && (
              <View
                className="mx-2 mt-2 rounded-sm bg-white p-3"
                style={{ borderWidth: 1, borderColor: DIVIDER }}
              >
                {vm.bank == null ? (
                  <Text className="py-4 text-center text-sm" style={{ color: TEXT_SECONDARY }}>
                    {t('ken.buy.notConfigured')}
                  </Text>
                ) : (
                  <>
                    <Text className="text-center text-sm font-medium" style={{ color: TEXT_PRIMARY }}>
                      {t('ken.buy.qrTitle')}
                    </Text>
                    {vm.qrImageUrl != null && (
                      <View className="mt-3 items-center">
                        <View
                          className="rounded p-2"
                          style={{ borderWidth: 1, borderColor: DIVIDER, backgroundColor: '#ffffff' }}
                        >
                          <CachedImage
                            uri={vm.qrImageUrl}
                            style={{ width: QR_SIZE, height: QR_SIZE }}
                            resizeMode="contain"
                          />
                        </View>
                      </View>
                    )}
                    <View className="mt-3">
                      {vm.bank.bankName !== '' && (
                        <BankInfoRow label={t('ken.buy.bankLabel')} value={vm.bank.bankName} />
                      )}
                      <CopyRow
                        label={t('ken.buy.accountNumberLabel')}
                        value={vm.bank.accountNumber}
                      />
                      {vm.bank.accountName !== '' && (
                        <BankInfoRow
                          label={t('ken.buy.accountNameLabel')}
                          value={vm.bank.accountName}
                        />
                      )}
                      {vm.memo !== '' && <CopyRow label={t('ken.buy.memoLabel')} value={vm.memo} />}
                    </View>
                    <View className="mt-3 items-center">
                      <Text className="text-xs" style={{ color: TEXT_SECONDARY }}>
                        {t('ken.buy.amountLabel')}
                      </Text>
                      <Text className="text-lg font-bold" style={{ color: TEXT_PRIMARY }}>
                        {formatVnd(vm.amount)}đ
                      </Text>
                    </View>
                    <Text className="mt-2 text-center text-xs" style={{ color: TEXT_SECONDARY }}>
                      {t('ken.buy.qrHint', { ken: formatKen(vm.kenAmount) })}
                    </Text>
                    <Pressable
                      onPress={confirmPaid}
                      disabled={paidPending}
                      className="mt-3 w-full items-center rounded-sm border border-ola-primary-dark bg-ola-button py-2.5 active:opacity-90"
                      style={paidPending ? { opacity: 0.6 } : undefined}
                    >
                      <Text className="text-sm font-medium text-white">{t('ken.buy.paid')}</Text>
                    </Pressable>
                    <Text className="mt-2 text-center text-[11px] text-ola-ink-faint">
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
