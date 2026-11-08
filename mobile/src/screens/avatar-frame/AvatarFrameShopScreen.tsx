import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, FlatList, Pressable, Text, View } from 'react-native';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { formatKen, isVipActive } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useAvatarFrameShop } from '@ola/shared/stores/avatar-frame/useAvatarFrameShop';
import type { AvatarFrameShopItem } from '@ola/shared/types';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { useBottomBarInset } from '@hooks/useBottomBarInset';
import { useThemeColors } from '@hooks/useThemeColors';
import { DIVIDER, TEXT_SECONDARY } from '@constants';
import { FRAME_GRID_COLUMNS } from './constants';
import { AvatarFrameCard } from './components/AvatarFrameCard';
import { AvatarFrameShopDialog } from './components/AvatarFrameShopDialog';

type Props = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.AvatarFrameShop>;

export function AvatarFrameShopScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const bottomInset = useBottomBarInset();
  const ken = useAuthStore((s) => s.user?.ken ?? 0);
  const vipEndTime = useAuthStore((s) => s.user?.vipEndTime ?? null);
  const shop = useAvatarFrameShop();
  const [selected, setSelected] = useState<AvatarFrameShopItem | null>(null);
  const vipActive = isVipActive(vipEndTime);

  function openBuyVip() {
    setSelected(null);
    navigation.navigate(ROOT_ROUTES.BuyVip, { mode: 'extend' });
  }

  const listHeader = (
    <View>
      <View
        className="flex-row items-center bg-white px-4 py-3"
        style={{ borderBottomWidth: 1, borderBottomColor: DIVIDER }}
      >
        <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>
          {t('vip.buy.balance')}
        </Text>
        <Text className="ml-2 text-lg font-bold" style={{ color: colors.primary }}>
          {formatKen(ken)} KEN
        </Text>
      </View>
      {!vipActive && (
        <View className="flex-row items-center gap-2 bg-white px-4 py-2">
          <Text className="min-w-0 flex-1 text-xs" style={{ color: TEXT_SECONDARY }}>
            {t('avatarFrame.vipRequiredHint')}
          </Text>
          <Pressable onPress={openBuyVip} className="rounded bg-ola-button px-3 py-1 active:opacity-90">
            <Text className="text-xs font-medium text-white">{t('avatarFrame.buyVip')}</Text>
          </Pressable>
        </View>
      )}
    </View>
  );

  const listEmpty = (
    <View className="items-center justify-center px-4" style={{ height: 160 }}>
      {shop.loading ? (
        <ActivityIndicator color={colors.primary} />
      ) : shop.failed ? (
        <Pressable onPress={() => void shop.reload()} className="items-center active:opacity-70">
          <Text className="text-center text-sm" style={{ color: TEXT_SECONDARY }}>
            {t('common.error')}
          </Text>
        </Pressable>
      ) : (
        <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>
          {t('avatarFrame.shopEmpty')}
        </Text>
      )}
    </View>
  );

  return (
    <View className="flex-1" style={{ backgroundColor: '#ececec' }}>
      <ScreenHeader
        title={t('avatarFrame.shopTitle')}
        onBack={() => navigation.goBack()}
      />
      <FlatList
        className="flex-1"
        data={shop.items}
        numColumns={FRAME_GRID_COLUMNS}
        keyExtractor={(item) => item.id}
        renderItem={({ item }) => (
          <AvatarFrameCard
            frameId={item.frameId}
            subtitle={t('avatarFrame.price', { price: formatKen(item.kenPrice) })}
            badge={item.owned ? t('avatarFrame.owned') : undefined}
            onPress={() => setSelected(item)}
          />
        )}
        ListHeaderComponent={listHeader}
        ListEmptyComponent={listEmpty}
        columnWrapperStyle={{ paddingHorizontal: 4 }}
        contentContainerStyle={{ paddingBottom: 8 + bottomInset }}
        refreshing={false}
        onRefresh={() => void shop.reload()}
      />
      <AvatarFrameShopDialog
        item={selected != null ? (shop.items.find((it) => it.id === selected.id) ?? selected) : null}
        vipActive={vipActive}
        busy={shop.busyItemId != null}
        buy={shop.buy}
        gift={shop.gift}
        onBuyVip={openBuyVip}
        onClose={() => setSelected(null)}
      />
    </View>
  );
}
