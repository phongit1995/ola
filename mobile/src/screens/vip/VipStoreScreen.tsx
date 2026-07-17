import { useTranslation } from 'react-i18next';
import { FlatList, Pressable, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { formatDateDMY, vipName } from '@ola/shared/lib';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { ListOptionDialog } from '@components/ui/ListOptionDialog';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { DIVIDER, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { PRIVACY_KEYS } from './constants';
import { useVipStoreScreen } from './useVipStoreScreen';
import { VipIconImage } from './components/VipIconImage';
import { VipRow } from './components/VipRow';

type Props = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.VipStore>;

export function VipStoreScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const vm = useVipStoreScreen();

  function openBuy(mode: 'buy' | 'give' | 'extend') {
    navigation.navigate(ROOT_ROUTES.BuyVip, { mode });
  }

  const listHeader = (
    <View style={{ backgroundColor: 'rgba(255,255,255,0.8)' }}>
      <Text className="px-4 pt-4 text-xs" style={{ color: TEXT_SECONDARY }}>
        {t('vip.usingIcon')}
      </Text>
      <View className="mt-1 flex-row items-center px-4" style={{ height: 72 }}>
        {vm.usingIcon != null ? (
          <VipIconImage typeId={vm.usingIcon.typeId} size={40} rounded />
        ) : (
          <View className="rounded" style={{ width: 40, height: 40, backgroundColor: DIVIDER }} />
        )}
        <View className="ml-2 justify-center">
          <Text className="text-base" style={{ color: TEXT_PRIMARY }}>
            {vm.usingIcon != null ? vipName(vm.usingIcon.typeId) : t('vip.empty')}
          </Text>
          <Text className="mt-0.5 text-xs" style={{ color: TEXT_SECONDARY }}>
            {vm.usingIcon != null
              ? vm.vipEndTime != null
                ? formatDateDMY(vm.vipEndTime)
                : t('vip.stateInUse')
              : t('vip.empty')}
          </Text>
        </View>
      </View>

      <Pressable
        onPress={() => vm.setPrivacyOpen(true)}
        className="w-full flex-row items-center px-4 active:bg-black/5"
        style={{ minHeight: 48 }}
      >
        <Text className="flex-1 text-base" style={{ color: TEXT_PRIMARY }}>
          {t('vip.whoCanSee')}
        </Text>
        <Text className="mx-2 text-xs" style={{ color: TEXT_SECONDARY }}>
          {t(`vip.${PRIVACY_KEYS[vm.privacy]}`)}
        </Text>
        <Text className="text-lg" style={{ color: 'rgba(0,0,0,0.4)' }}>›</Text>
      </Pressable>
      <View className="mx-4" style={{ height: 1, backgroundColor: DIVIDER }} />

      <Pressable
        onPress={() => openBuy('buy')}
        className="w-full justify-center px-4 active:bg-black/5"
        style={{ minHeight: 48 }}
      >
        <Text className="text-base" style={{ color: TEXT_PRIMARY }}>{t('vip.buyVip')}</Text>
      </Pressable>
      <View className="mx-4" style={{ height: 1, backgroundColor: DIVIDER }} />

      <Pressable
        onPress={() => openBuy('extend')}
        className="w-full justify-center px-4 active:bg-black/5"
        style={{ minHeight: 48 }}
      >
        <Text className="text-base" style={{ color: TEXT_PRIMARY }}>{t('vip.extendVip')}</Text>
      </Pressable>

      <View
        className="items-center justify-center"
        style={{ height: 36, backgroundColor: '#d5d5d5' }}
      >
        <Text className="text-base text-white">{t('vip.collection')}</Text>
      </View>
    </View>
  );

  const listEmpty = (
    <View className="items-center justify-center" style={{ height: 96 }}>
      <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>
        {vm.loading ? t('common.loading') : t('vip.empty')}
      </Text>
    </View>
  );

  return (
    <View className="flex-1 bg-white">
      <ScreenHeader title={t('vip.title')} onBack={() => navigation.goBack()} />

      <FlatList
        className="flex-1"
        data={vm.items}
        keyExtractor={(item) => item.instanceId}
        renderItem={({ item }) => <VipRow icon={item} onSelect={() => vm.setMenuIcon(item)} />}
        ListHeaderComponent={listHeader}
        ListEmptyComponent={listEmpty}
        ListFooterComponent={
          vm.loadingMore ? (
            <View className="items-center justify-center" style={{ height: 48 }}>
              <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>
                {t('common.loading')}
              </Text>
            </View>
          ) : null
        }
        onEndReachedThreshold={0.4}
        onEndReached={vm.loadMore}
      />

      <View
        className="flex-row items-center gap-2 bg-white px-2"
        style={{
          height: 48 + insets.bottom,
          paddingBottom: insets.bottom,
          borderTopWidth: 1,
          borderTopColor: DIVIDER,
        }}
      >
        <Text className="text-xs" style={{ color: TEXT_SECONDARY }}>{t('vip.duration')}</Text>
        <Text className="flex-1 text-xl font-bold" style={{ color: TEXT_PRIMARY }} numberOfLines={1}>
          {vm.durationText}
        </Text>
        <Pressable
          onPress={() => openBuy('extend')}
          className="rounded border border-ola-primary-dark bg-ola-button px-4 py-1.5 active:opacity-90"
        >
          <Text className="text-sm font-medium text-white">{t('vip.extendVip')}</Text>
        </Pressable>
      </View>

      <ListOptionDialog
        visible={vm.privacyOpen}
        title={t('vip.privacyTitle')}
        options={vm.changePrivacyOptions()}
        onClose={() => vm.setPrivacyOpen(false)}
      />

      <ListOptionDialog
        visible={vm.menuIcon != null}
        title={vm.menuIcon != null ? vipName(vm.menuIcon.typeId) : ''}
        options={vm.menuIcon != null ? vm.buildMenuOptions(vm.menuIcon, () => openBuy('give')) : []}
        onClose={() => vm.setMenuIcon(null)}
      />

      <ConfirmDialog
        visible={vm.useTarget != null}
        title={t('vip.confirmUseTitle')}
        message={t('vip.confirmUse', {
          name: vm.useTarget != null ? vipName(vm.useTarget.typeId) : '',
        })}
        confirmLabel={t('vip.confirm')}
        cancelLabel={t('vip.cancel')}
        onConfirm={vm.confirmUse}
        onCancel={() => vm.setUseTarget(null)}
      />

      <ConfirmDialog
        visible={vm.deleteTarget != null}
        danger
        title={t('vip.confirmDeleteTitle')}
        message={t('vip.confirmDelete', {
          name: vm.deleteTarget != null ? vipName(vm.deleteTarget.typeId) : '',
        })}
        confirmLabel={t('vip.actionDelete')}
        cancelLabel={t('vip.cancel')}
        onConfirm={vm.confirmDelete}
        onCancel={() => vm.setDeleteTarget(null)}
      />
    </View>
  );
}
