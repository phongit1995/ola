import { useEffect, useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, ScrollView, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { formatKen } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { selectTopupEnabled, useTopupConfigStore } from '@ola/shared/stores/topupConfigStore';
import type { RootStackParamList } from '../../navigation/types';
import { ROOT_ROUTES } from '../../navigation/routes';
import { KenCoin } from './KenCoin';
import { KenHistorySection } from './KenHistorySection';
import { TransferKenDialog } from './TransferKenDialog';

const KEN_LOW_THRESHOLD = 10_000;
const MUTED = 'rgba(0,0,0,0.54)';
const BODY = 'rgba(0,0,0,0.87)';
const DIVIDER = 'rgba(0,0,0,0.12)';

interface RowActionProps {
  icon: ReactNode;
  label: string;
  onPress: () => void;
}

function RowAction({ icon, label, onPress }: RowActionProps) {
  return (
    <Pressable
      onPress={onPress}
      className="h-9 w-full flex-row items-center px-2 active:bg-black/5"
    >
      <View className="mr-2.5 items-center justify-center" style={{ width: 18, height: 18 }}>
        {icon}
      </View>
      <Text className="text-sm" style={{ color: BODY }}>{label}</Text>
    </Pressable>
  );
}

type Props = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.KenStore>;

export function KenStoreScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const user = useAuthStore((s) => s.user);
  const push = useToastStore((s) => s.push);
  const topupEnabled = useTopupConfigStore(selectTopupEnabled);
  const loadTopupConfig = useTopupConfigStore((s) => s.load);
  const [transferOpen, setTransferOpen] = useState(false);

  useEffect(() => {
    void loadTopupConfig();
  }, [loadTopupConfig]);

  function comingSoon() {
    push('info', t('ken.comingSoon'));
  }

  const ken = user?.ken ?? 0;
  const showLowKenWarning = ken > 0 && ken < KEN_LOW_THRESHOLD;
  const balanceText = `${formatKen(ken)} KEN`;

  return (
    <View className="flex-1 bg-white">
      <View className="bg-ola-primary" style={{ paddingTop: insets.top }}>
        <View className="h-12 flex-row items-center gap-2 px-2">
          <Pressable
            className="h-9 w-9 items-center justify-center rounded-full active:bg-white/15"
            onPress={() => navigation.goBack()}
          >
            <Text className="text-2xl leading-none text-white">‹</Text>
          </Pressable>
          <Text className="flex-1 text-sm font-bold text-white" numberOfLines={1}>
            {t('ken.title')}
          </Text>
        </View>
      </View>

      <ScrollView
        className="flex-1"
        style={{ backgroundColor: '#ececec' }}
        contentContainerClassName="pb-4 pt-2"
      >
        {showLowKenWarning && (
          <View
            className="mx-2 mb-2 rounded-sm bg-white px-3 py-2.5"
            style={{ borderWidth: 1, borderColor: DIVIDER }}
          >
            <Text className="text-xs" style={{ color: '#e34545' }}>{t('ken.lowWarning')}</Text>
          </View>
        )}

        <View className="mx-2 rounded-sm bg-white p-2" style={{ borderWidth: 1, borderColor: DIVIDER }}>
          <View className="flex-row items-center px-1 py-1.5">
            <Text className="text-sm" style={{ color: MUTED }}>{t('ken.balance')}</Text>
            <View className="ml-2 flex-1 flex-row items-center gap-1">
              <KenCoin />
              <Text className="text-lg font-bold" style={{ color: '#7cb342' }}>{balanceText}</Text>
            </View>
          </View>

          {topupEnabled && (
            <>
              <RowAction
                icon={<KenCoin />}
                label={t('ken.purchase')}
                onPress={() => navigation.navigate(ROOT_ROUTES.BuyKen)}
              />
              <View className="mx-2" style={{ height: 1, backgroundColor: DIVIDER }} />
            </>
          )}
          <RowAction icon={<KenCoin />} label={t('ken.transfer')} onPress={() => setTransferOpen(true)} />
        </View>

        <KenHistorySection />
      </ScrollView>

      <View
        className="bg-white p-2"
        style={{ borderTopWidth: 1, borderTopColor: DIVIDER, paddingBottom: Math.max(insets.bottom, 8) }}
      >
        <Pressable
          onPress={comingSoon}
          className="h-9 w-full items-center justify-center rounded-sm border border-ola-primary-dark active:opacity-90"
          style={{ backgroundColor: '#9ccc65' }}
        >
          <Text className="text-sm text-white">{t('ken.support')}</Text>
        </Pressable>
      </View>

      {transferOpen && <TransferKenDialog visible onClose={() => setTransferOpen(false)} />}
    </View>
  );
}
