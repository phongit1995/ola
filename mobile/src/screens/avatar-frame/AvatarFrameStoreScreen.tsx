import { useCallback, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, FlatList, Pressable, Text, View } from 'react-native';
import { useFocusEffect } from '@react-navigation/native';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { avatarFramePrivacyLabelKey } from '@ola/shared/lib';
import { avatarFrameLabel } from '@ola/shared/lib/avatarFrame';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { AvatarWithFrame } from '@components/ui/AvatarWithFrame';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { ListOptionDialog } from '@components/ui/ListOptionDialog';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { useBottomBarInset } from '@hooks/useBottomBarInset';
import { useThemeColors } from '@hooks/useThemeColors';
import { DIVIDER, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { FRAME_GRID_COLUMNS, FRAME_STORE_PREVIEW_SIZE } from './constants';
import { useAvatarFrameStoreScreen } from './useAvatarFrameStoreScreen';
import { AvatarFrameCard } from './components/AvatarFrameCard';
import { AvatarFrameHistoryDialog } from './components/AvatarFrameHistoryDialog';
import { AvatarFrameTransferDialog } from './components/AvatarFrameTransferDialog';

type Props = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.AvatarFrameStore>;

export function AvatarFrameStoreScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const bottomInset = useBottomBarInset();
  const username = useAuthStore((s) => s.user?.username ?? '');
  const avatar = useAuthStore((s) => s.user?.avatar ?? undefined);
  const vm = useAvatarFrameStoreScreen();
  const [historyOpen, setHistoryOpen] = useState(false);
  const { frames, store, equippedFrameId, vipActive } = vm;
  const equippedHidden = equippedFrameId != null && !vipActive;
  const { reload } = frames;
  const firstFocus = useRef(true);

  useFocusEffect(
    useCallback(() => {
      if (firstFocus.current) {
        firstFocus.current = false;
        return;
      }
      void reload();
    }, [reload]),
  );

  function openBuyVip() {
    vm.setVipPromptOpen(false);
    navigation.navigate(ROOT_ROUTES.BuyVip, { mode: 'extend' });
  }

  const equippedText =
    equippedFrameId == null
      ? t('avatarFrame.empty')
      : equippedHidden
        ? t('avatarFrame.equippedHidden')
        : t('avatarFrame.equipped');

  const listHeader = (
    <View className="bg-white">
      <View className="flex-row items-center gap-4 px-4 py-4">
        <AvatarWithFrame
          name={username}
          uri={avatar}
          size={FRAME_STORE_PREVIEW_SIZE}
          frameId={equippedHidden ? null : equippedFrameId}
        />
        <View className="min-w-0 flex-1">
          <Text numberOfLines={1} className="text-base font-semibold" style={{ color: TEXT_PRIMARY }}>
            {equippedFrameId != null ? avatarFrameLabel(equippedFrameId) : t('avatarFrame.title')}
          </Text>
          <Text className="mt-0.5 text-xs" style={{ color: TEXT_SECONDARY }}>
            {equippedText}
          </Text>
          {!vipActive && store != null && (
            <Pressable
              onPress={openBuyVip}
              className="mt-2 self-start rounded bg-ola-button px-3 py-1 active:opacity-90"
            >
              <Text className="text-xs font-medium text-white">{t('avatarFrame.buyVip')}</Text>
            </Pressable>
          )}
        </View>
      </View>
      <View className="mx-4" style={{ height: 1, backgroundColor: DIVIDER }} />
      <Pressable
        onPress={() => vm.setPrivacyOpen(true)}
        className="w-full flex-row items-center px-4 active:bg-black/5"
        style={{ minHeight: 48 }}
      >
        <Text className="flex-1 text-base" style={{ color: TEXT_PRIMARY }}>
          {t('avatarFrame.privacyTitle')}
        </Text>
        <Text className="mx-2 text-xs" style={{ color: TEXT_SECONDARY }}>
          {t(avatarFramePrivacyLabelKey(vm.privacy))}
        </Text>
        <Text className="text-lg" style={{ color: 'rgba(0,0,0,0.4)' }}>›</Text>
      </Pressable>
      <View className="mx-4" style={{ height: 1, backgroundColor: DIVIDER }} />
      <Pressable
        onPress={() => navigation.navigate(ROOT_ROUTES.AvatarFrameShop)}
        className="w-full flex-row items-center px-4 active:bg-black/5"
        style={{ minHeight: 48 }}
      >
        <Text className="flex-1 text-base" style={{ color: TEXT_PRIMARY }}>
          {t('avatarFrame.shopTitle')}
        </Text>
        <Text className="text-lg" style={{ color: 'rgba(0,0,0,0.4)' }}>›</Text>
      </Pressable>
      <View
        className="flex-row items-center px-3"
        style={{ height: 36, backgroundColor: '#d5d5d5' }}
      >
        <Text className="flex-1 text-center text-base text-white">
          {t('avatarFrame.count', { count: store?.total ?? 0 })}
        </Text>
      </View>
    </View>
  );

  const listEmpty = (
    <View className="items-center justify-center px-4" style={{ height: 120 }}>
      {frames.loading ? (
        <ActivityIndicator color={colors.primary} />
      ) : (
        <Pressable onPress={() => void frames.reload()} disabled={!frames.failed}>
          <Text className="text-center text-sm" style={{ color: TEXT_SECONDARY }}>
            {frames.failed ? t('common.error') : t('avatarFrame.empty')}
          </Text>
        </Pressable>
      )}
    </View>
  );

  return (
    <View className="flex-1" style={{ backgroundColor: '#ececec' }}>
      <ScreenHeader
        title={t('avatarFrame.storeTitle')}
        onBack={() => navigation.goBack()}
        right={
          <Pressable
            onPress={() => setHistoryOpen(true)}
            className="rounded px-2 py-1 active:opacity-80"
            style={{ backgroundColor: 'rgba(255,255,255,0.15)' }}
          >
            <Text className="text-sm font-medium" style={{ color: colors.onPrimary }}>
              {t('avatarFrame.history.title')}
            </Text>
          </Pressable>
        }
      />
      <FlatList
        className="flex-1"
        data={store?.items ?? []}
        numColumns={FRAME_GRID_COLUMNS}
        keyExtractor={(item) => item.frameId}
        renderItem={({ item }) => (
          <AvatarFrameCard
            frameId={item.frameId}
            badge={item.isEquipped ? t('avatarFrame.equipped') : undefined}
            highlighted={item.isEquipped}
            onPress={() => vm.setMenuFrame(item)}
          />
        )}
        ListHeaderComponent={listHeader}
        ListEmptyComponent={listEmpty}
        ListFooterComponent={
          frames.loadingMore ? <ActivityIndicator className="my-3" color={colors.primary} /> : undefined
        }
        columnWrapperStyle={{ paddingHorizontal: 4 }}
        contentContainerStyle={{ paddingBottom: 8 + bottomInset }}
        onEndReachedThreshold={0.4}
        onEndReached={() => {
          if (frames.hasMore) void frames.loadMore().catch(() => undefined);
        }}
      />

      <ListOptionDialog
        visible={vm.privacyOpen}
        title={t('avatarFrame.privacyTitle')}
        options={vm.privacyOptions()}
        onClose={() => vm.setPrivacyOpen(false)}
      />

      <ListOptionDialog
        visible={vm.menuFrame != null}
        title={vm.menuTitle}
        options={vm.menuFrame != null ? vm.menuOptions(vm.menuFrame) : []}
        onClose={() => vm.setMenuFrame(null)}
      />

      {vm.transferFrameId != null && (
        <AvatarFrameTransferDialog
          frameId={vm.transferFrameId}
          busy={frames.busy}
          onTransfer={frames.transfer}
          onClose={() => vm.setTransferFrameId(null)}
        />
      )}

      <ConfirmDialog
        visible={vm.vipPromptOpen}
        title={t('avatarFrame.buyVip')}
        message={t('avatarFrame.errors.vipRequired')}
        confirmLabel={t('avatarFrame.buyVip')}
        cancelLabel={t('avatarFrame.cancel')}
        onConfirm={openBuyVip}
        onCancel={() => vm.setVipPromptOpen(false)}
      />

      <AvatarFrameHistoryDialog visible={historyOpen} onClose={() => setHistoryOpen(false)} />
    </View>
  );
}
