import { useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, ScrollView, Text, TextInput, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { formatKen, formatVnd } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { RootStackParamList } from '../../navigation/types';
import { ROOT_ROUTES } from '../../navigation/routes';

const MIN_AMOUNT = 10_000;
const STEP_AMOUNT = 1_000;
const PRESET_AMOUNTS = [10_000, 20_000, 50_000, 100_000, 200_000, 500_000];
const QR_MODULES = 29;
const QR_QUIET = 2;
const QR_SIZE = 224;
const MUTED = 'rgba(0,0,0,0.54)';
const BODY = 'rgba(0,0,0,0.87)';
const DIVIDER = 'rgba(0,0,0,0.12)';

function isFinderBit(localRow: number, localCol: number): boolean {
  const onOuterRing = localRow === 0 || localRow === 6 || localCol === 0 || localCol === 6;
  const onInnerBlock = localRow >= 2 && localRow <= 4 && localCol >= 2 && localCol <= 4;
  return onOuterRing || onInnerBlock;
}

function finderModule(row: number, col: number, size: number): boolean | null {
  const corners = [
    { r0: 0, c0: 0 },
    { r0: 0, c0: size - 7 },
    { r0: size - 7, c0: 0 },
  ];
  for (const { r0, c0 } of corners) {
    const inFinder = row >= r0 && row < r0 + 7 && col >= c0 && col < c0 + 7;
    if (inFinder) return isFinderBit(row - r0, col - c0);
    const sr0 = r0 === 0 ? 0 : r0 - 1;
    const sc0 = c0 === 0 ? 0 : c0 - 1;
    const inSeparator = row >= sr0 && row < sr0 + 8 && col >= sc0 && col < sc0 + 8;
    if (inSeparator) return false;
  }
  return null;
}

function dataModule(row: number, col: number, seed: number): boolean {
  let hash = ((row + 1) * 73856093) ^ ((col + 1) * 19349663) ^ ((seed + 1) * 83492791);
  hash ^= hash >>> 13;
  hash = (hash * 1274126177) | 0;
  hash ^= hash >>> 16;
  return (hash & 1) === 1;
}

function FakeQrCode({ seed }: { seed: number }) {
  const cells = useMemo(() => {
    const result: { row: number; col: number }[] = [];
    for (let row = 0; row < QR_MODULES; row += 1) {
      for (let col = 0; col < QR_MODULES; col += 1) {
        const fromFinder = finderModule(row, col, QR_MODULES);
        const filled = fromFinder != null ? fromFinder : dataModule(row, col, seed);
        if (filled) result.push({ row, col });
      }
    }
    return result;
  }, [seed]);

  const total = QR_MODULES + QR_QUIET * 2;
  const cell = QR_SIZE / total;

  return (
    <View style={{ width: QR_SIZE, height: QR_SIZE, backgroundColor: '#ffffff' }}>
      {cells.map(({ row, col }) => (
        <View
          key={`${row}-${col}`}
          style={{
            position: 'absolute',
            left: (col + QR_QUIET) * cell,
            top: (row + QR_QUIET) * cell,
            width: cell + 0.5,
            height: cell + 0.5,
            backgroundColor: '#000000',
          }}
        />
      ))}
    </View>
  );
}

type Props = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.BuyKen>;

export function BuyKenScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const user = useAuthStore((s) => s.user);
  const push = useToastStore((s) => s.push);

  const [amount, setAmount] = useState(MIN_AMOUNT);
  const [customText, setCustomText] = useState('');

  const isValid = amount >= MIN_AMOUNT && amount % STEP_AMOUNT === 0;
  const kenAmount = amount;
  const balance = user?.ken ?? 0;

  function selectPreset(value: number) {
    setAmount(value);
    setCustomText('');
  }

  function changeCustom(raw: string) {
    const digits = raw.replace(/\D/g, '');
    setCustomText(digits);
    setAmount(digits === '' ? 0 : Number(digits));
  }

  return (
    <View className="flex-1" style={{ backgroundColor: '#ececec' }}>
      <View className="bg-ola-primary" style={{ paddingTop: insets.top }}>
        <View className="h-12 flex-row items-center gap-2 px-2">
          <Pressable
            className="h-9 w-9 items-center justify-center rounded-full active:bg-white/15"
            onPress={() => navigation.goBack()}
          >
            <Text className="text-2xl leading-none text-white">‹</Text>
          </Pressable>
          <Text className="flex-1 text-sm font-bold text-white" numberOfLines={1}>
            {t('ken.buy.title')}
          </Text>
        </View>
      </View>

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

        <View className="mx-2 rounded-sm bg-white p-3" style={{ borderWidth: 1, borderColor: DIVIDER }}>
          <Text className="text-xs" style={{ color: MUTED }}>{t('ken.buy.chooseAmount')}</Text>
          <View className="mt-2 flex-row flex-wrap" style={{ marginHorizontal: -4 }}>
            {PRESET_AMOUNTS.map((value) => {
              const selected = amount === value && customText === '';
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
            value={customText}
            onChangeText={changeCustom}
            placeholder={t('ken.buy.customHint')}
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
            <Text className="mt-1 text-xs" style={{ color: '#e34545' }}>{t('ken.buy.invalid')}</Text>
          )}
        </View>

        {isValid && (
          <View
            className="mx-2 mt-2 rounded-sm bg-white p-3"
            style={{ borderWidth: 1, borderColor: DIVIDER }}
          >
            <Text className="text-center text-sm font-medium" style={{ color: BODY }}>
              {t('ken.buy.qrTitle')}
            </Text>
            <View className="mt-3 items-center">
              <View className="rounded p-2" style={{ borderWidth: 1, borderColor: DIVIDER }}>
                <FakeQrCode seed={amount} />
              </View>
            </View>
            <View className="mt-3 items-center">
              <Text className="text-xs" style={{ color: MUTED }}>{t('ken.buy.amountLabel')}</Text>
              <Text className="text-lg font-bold" style={{ color: BODY }}>{formatVnd(amount)}đ</Text>
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
              {t('ken.buy.demoNote')}
            </Text>
          </View>
        )}
      </ScrollView>
    </View>
  );
}
