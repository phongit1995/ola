import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, ScrollView, Text, TextInput, View } from 'react-native';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { formatKen, vipPackageLabel } from '@ola/shared/lib';
import type { BuyVipMode } from '@ola/shared/types';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { KeyboardView } from '@components/KeyboardView';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { ListOptionDialog } from '@components/ui/ListOptionDialog';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { DIVIDER, PRIMARY, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { MODE_ACTION, MODE_ORDER, MODE_TAB, MODE_TITLE } from './constants';
import { useBuyVip } from './useBuyVip';
import { ReceiverField } from './components/ReceiverField';
import { VipIconImage } from './components/VipIconImage';
import { VipPickerDialog } from './components/VipPickerDialog';

export type { BuyVipMode };

type Props = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.BuyVip>;

export function BuyVipScreen({ navigation, route }: Props) {
  const { t } = useTranslation();
  const vm = useBuyVip(route.params?.mode, () => navigation.goBack());

  return (
    <KeyboardView className="flex-1" style={{ backgroundColor: '#ececec' }}>
      <ScreenHeader title={t(MODE_TITLE[vm.mode])} onBack={() => navigation.goBack()} />

      <ScrollView
        className="flex-1"
        keyboardShouldPersistTaps="handled"
        contentContainerClassName="pb-6"
      >
        <View className="flex-row gap-1 bg-white px-2 py-2">
          {MODE_ORDER.map((item) => {
            const activeTab = vm.mode === item;
            return (
              <Pressable
                key={item}
                onPress={() => vm.changeMode(item)}
                className="flex-1 items-center rounded-full px-2 py-1.5"
                style={{ backgroundColor: activeTab ? PRIMARY : 'rgba(0,0,0,0.05)' }}
              >
                <Text
                  className="text-xs font-medium"
                  style={{ color: activeTab ? '#ffffff' : 'rgba(0,0,0,0.6)' }}
                >
                  {t(MODE_TAB[item])}
                </Text>
              </Pressable>
            );
          })}
        </View>

        <View className="mt-2 flex-row items-center bg-white px-4 py-3">
          <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>{t('vip.buy.balance')}</Text>
          <Text className="ml-2 text-lg font-bold" style={{ color: PRIMARY }}>
            {formatKen(vm.kenBalance)} KEN
          </Text>
        </View>

        {vm.showReceiver && (
          <ReceiverField
            receiverUser={vm.receiverUser}
            receiverQuery={vm.receiverQuery}
            receiverResults={vm.receiverResults}
            receiverSearching={vm.receiverSearching}
            onChangeQuery={vm.setReceiverQuery}
            onPick={vm.pickReceiver}
            onClear={vm.clearReceiver}
          />
        )}

        {vm.showVipSelect && (
          <View className="mt-2 bg-white px-4 py-3">
            <Text className="text-xs" style={{ color: TEXT_SECONDARY }}>{t('vip.buy.selectVip')}</Text>
            <Pressable
              onPress={() => vm.setVipPickerOpen(true)}
              className="mt-1 w-full flex-row items-center gap-2 rounded px-2 py-1.5 active:bg-black/5"
              style={{ borderWidth: 1, borderColor: DIVIDER }}
            >
              <VipIconImage typeId={vm.displayVipId} size={40} />
              <View style={{ width: 1, height: 36, backgroundColor: DIVIDER }} />
              <Text numberOfLines={1} className="flex-1 text-sm" style={{ color: TEXT_PRIMARY }}>
                {vm.selectedVip?.name}
              </Text>
              {vm.selectedShopItem != null && (
                <Text className="text-sm font-medium" style={{ color: PRIMARY }}>
                  {formatKen(vm.selectedShopItem.kenPrice)} KEN
                </Text>
              )}
              <Text className="text-base" style={{ color: 'rgba(0,0,0,0.4)' }}>▾</Text>
            </Pressable>
          </View>
        )}

        {vm.showPackage && (
          <View className="mt-2 bg-white px-4 py-3">
            <Text className="text-xs" style={{ color: TEXT_SECONDARY }}>
              {t('vip.buy.choosePackage')}
            </Text>
            <Pressable
              onPress={() => vm.setPackagePickerOpen(true)}
              className="mt-1 w-full flex-row items-center rounded px-3 py-2 active:bg-black/5"
              style={{ borderWidth: 1, borderColor: DIVIDER }}
            >
              <Text className="flex-1 text-sm" style={{ color: TEXT_PRIMARY }}>
                {vm.selectedPackage != null
                  ? vipPackageLabel(t, vm.selectedPackage)
                  : t('vip.buy.packagesEmpty')}
              </Text>
              <Text className="text-base" style={{ color: 'rgba(0,0,0,0.4)' }}>▾</Text>
            </Pressable>
          </View>
        )}

        {vm.showReceiver && vm.receiverUser != null && (
          <View className="mt-2 bg-white px-4 py-3">
            <Text className="text-xs" style={{ color: TEXT_SECONDARY }}>
              {t('vip.buy.passwordLabel')}
            </Text>
            <TextInput
              secureTextEntry
              value={vm.giftPassword}
              onChangeText={vm.setGiftPassword}
              placeholder={t('vip.buy.passwordPlaceholder')}
              placeholderTextColor="rgba(0,0,0,0.38)"
              className="mt-1 w-full rounded px-3 py-2 text-sm"
              style={{
                borderWidth: 1,
                borderColor: DIVIDER,
                color: TEXT_PRIMARY,
                backgroundColor: '#fff',
              }}
            />
          </View>
        )}

        <View className="px-4">
          <Pressable
            onPress={vm.startPurchase}
            className="mt-4 w-full flex-row items-center justify-center rounded border border-ola-primary-dark bg-ola-button py-2.5 active:opacity-90"
          >
            {vm.purchasing && (
              <ActivityIndicator size="small" color="#fff" style={{ marginRight: 6 }} />
            )}
            <Text className="text-sm font-medium text-white">{t(MODE_ACTION[vm.mode])}</Text>
          </Pressable>
        </View>
      </ScrollView>

      <VipPickerDialog
        visible={vm.vipPickerOpen}
        selectedKey={vm.selectedShopId}
        items={vm.pickerItems}
        onSelect={vm.handlePickVip}
        onClose={() => vm.setVipPickerOpen(false)}
      />

      <ListOptionDialog
        visible={vm.packagePickerOpen}
        title={t('vip.buy.pickPackageTitle')}
        options={vm.packageOptions}
        onClose={() => vm.setPackagePickerOpen(false)}
      />

      <ConfirmDialog
        visible={vm.confirmOpen}
        title={t(MODE_TITLE[vm.mode])}
        message={vm.confirmText}
        confirmLabel={t(MODE_ACTION[vm.mode])}
        cancelLabel={t('vip.buy.cancel')}
        onConfirm={() => void vm.confirmPurchase()}
        onCancel={() => vm.setConfirmOpen(false)}
      />
    </KeyboardView>
  );
}
