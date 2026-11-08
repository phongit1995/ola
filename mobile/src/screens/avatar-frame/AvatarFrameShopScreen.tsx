import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Pressable,
  RefreshControl,
  ScrollView,
  Text,
  TextInput,
  View,
} from 'react-native';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { avatarFrameErrorKey, formatKen, isVipActive } from '@ola/shared/lib';
import { avatarFrameLabel } from '@ola/shared/lib/avatarFrame';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useAvatarFrameShop } from '@ola/shared/stores/avatar-frame/useAvatarFrameShop';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import type { AvatarFrameShopItem } from '@ola/shared/types';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { KeyboardView } from '@components/KeyboardView';
import { AvatarWithFrame } from '@components/ui/AvatarWithFrame';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { useBottomBarInset } from '@hooks/useBottomBarInset';
import { useThemeColors } from '@hooks/useThemeColors';
import { DIVIDER, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { ReceiverField } from '@screens/vip/components/ReceiverField';
import { FRAME_SELECT_AVATAR_SIZE } from './constants';
import { AvatarFramePickerDialog } from './components/AvatarFramePickerDialog';
import { useReceiverSearch } from './useReceiverSearch';

type Props = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.AvatarFrameShop>;

type ShopMode = 'buy' | 'gift';

const MODE_ORDER: ShopMode[] = ['buy', 'gift'];

const MODE_TAB = {
  buy: 'avatarFrame.actionBuy',
  gift: 'avatarFrame.actionGift',
} as const;

const MODE_TITLE = {
  buy: 'avatarFrame.confirmBuyTitle',
  gift: 'avatarFrame.giftTitle',
} as const;

const SCROLL_BOTTOM_PADDING = 24;

export function AvatarFrameShopScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const bottomInset = useBottomBarInset();
  const push = useToastStore((s) => s.push);
  const ken = useAuthStore((s) => s.user?.ken ?? 0);
  const vipEndTime = useAuthStore((s) => s.user?.vipEndTime ?? null);
  const username = useAuthStore((s) => s.user?.username ?? '');
  const avatar = useAuthStore((s) => s.user?.avatar ?? undefined);
  const shop = useAvatarFrameShop();
  const search = useReceiverSearch();
  const { receiverUser } = search;
  const [mode, setMode] = useState<ShopMode>('buy');
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [pickerOpen, setPickerOpen] = useState(false);
  const [confirmOpen, setConfirmOpen] = useState(false);
  const [password, setPassword] = useState('');

  const isGift = mode === 'gift';
  const busy = shop.busyItemId != null;
  const vipActive = isVipActive(vipEndTime);
  const selected: AvatarFrameShopItem | undefined =
    shop.items.find((item) => item.id === selectedId) ??
    shop.items.find((item) => !item.owned) ??
    shop.items[0];
  const alreadyOwned = !isGift && selected?.owned === true;
  const price = formatKen(selected?.kenPrice ?? 0);
  const frameLabel = selected != null ? avatarFrameLabel(selected.frameId) : '';

  function clearReceiver() {
    search.clearReceiver();
    setPassword('');
  }

  function changeMode(next: ShopMode) {
    if (next === mode) return;
    setMode(next);
    setConfirmOpen(false);
    clearReceiver();
  }

  function startPurchase() {
    if (isGift && receiverUser == null) {
      push('info', t('vip.buy.needReceiver'));
      return;
    }
    if (isGift && password.trim() === '') {
      push('info', t('vip.buy.needPassword'));
      return;
    }
    setConfirmOpen(true);
  }

  async function confirmPurchase() {
    setConfirmOpen(false);
    if (selected == null || busy) return;
    try {
      if (isGift) {
        if (receiverUser == null) return;
        const result = await shop.gift(selected, receiverUser.username, password);
        push('success', t('avatarFrame.toastGifted', { name: result.receiverUsername }));
      } else {
        await shop.buy(selected);
        push('success', t('avatarFrame.toastBought'));
      }
      navigation.goBack();
    } catch (error) {
      push('error', t(avatarFrameErrorKey(error)));
    }
  }

  function renderStatus() {
    if (shop.loading) {
      return <ActivityIndicator className="py-10" color={colors.primary} />;
    }
    if (shop.failed) {
      return (
        <Pressable onPress={() => void shop.reload()} className="items-center py-16 active:opacity-70">
          <Text className="text-center text-sm" style={{ color: TEXT_SECONDARY }}>
            {t('common.error')}
          </Text>
        </Pressable>
      );
    }
    return (
      <Text className="py-16 text-center text-sm" style={{ color: TEXT_SECONDARY }}>
        {t('avatarFrame.shopEmpty')}
      </Text>
    );
  }

  function renderForm(item: AvatarFrameShopItem) {
    return (
      <>
        {isGift && (
          <ReceiverField
            receiverUser={receiverUser}
            receiverQuery={search.receiverQuery}
            receiverResults={search.receiverResults}
            receiverSearching={search.receiverSearching}
            onChangeQuery={search.setReceiverQuery}
            onPick={search.pickReceiver}
            onClear={clearReceiver}
          />
        )}

        <View className="mt-2 bg-white px-4 py-3">
          <Text className="text-xs" style={{ color: TEXT_SECONDARY }}>
            {t('avatarFrame.selectFrame')}
          </Text>
          <Pressable
            onPress={() => setPickerOpen(true)}
            className="mt-1 w-full flex-row items-center gap-2 rounded px-2 py-1.5 active:bg-black/5"
            style={{ borderWidth: 1, borderColor: DIVIDER }}
          >
            <AvatarWithFrame
              name={username}
              uri={avatar}
              size={FRAME_SELECT_AVATAR_SIZE}
              frameId={item.frameId}
              showLoader={false}
            />
            <View style={{ width: 1, height: 36, backgroundColor: DIVIDER }} />
            <Text numberOfLines={1} className="flex-1 text-sm" style={{ color: TEXT_PRIMARY }}>
              {frameLabel}
            </Text>
            <Text className="text-sm font-medium" style={{ color: colors.primary }}>
              {t('avatarFrame.price', { price })}
            </Text>
            <Text className="text-base" style={{ color: 'rgba(0,0,0,0.4)' }}>▾</Text>
          </Pressable>
        </View>

        {isGift && receiverUser != null && (
          <View className="mt-2 bg-white px-4 py-3">
            <Text className="text-xs" style={{ color: TEXT_SECONDARY }}>
              {t('vip.buy.passwordLabel')}
            </Text>
            <TextInput
              secureTextEntry
              value={password}
              onChangeText={setPassword}
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
            disabled={busy || alreadyOwned}
            onPress={startPurchase}
            className="mt-4 w-full flex-row items-center justify-center rounded border border-ola-primary-dark bg-ola-button py-2.5 active:opacity-90"
            style={{ opacity: busy || alreadyOwned ? 0.5 : 1 }}
          >
            {busy && (
              <ActivityIndicator size="small" color={colors.onPrimary} style={{ marginRight: 6 }} />
            )}
            <Text className="text-sm font-medium" style={{ color: colors.onPrimary }}>
              {alreadyOwned ? t('avatarFrame.owned') : t(MODE_TITLE[mode])}
            </Text>
          </Pressable>
        </View>
      </>
    );
  }

  return (
    <KeyboardView className="flex-1" style={{ backgroundColor: '#ececec' }}>
      <ScreenHeader title={t('avatarFrame.shopTitle')} onBack={() => navigation.goBack()} />

      <ScrollView
        className="flex-1"
        keyboardShouldPersistTaps="handled"
        contentContainerStyle={{ paddingBottom: SCROLL_BOTTOM_PADDING + bottomInset }}
        refreshControl={<RefreshControl refreshing={false} onRefresh={() => void shop.reload()} />}
      >
        <View className="flex-row gap-1 bg-white px-2 py-2">
          {MODE_ORDER.map((item) => {
            const activeTab = mode === item;
            return (
              <Pressable
                key={item}
                onPress={() => changeMode(item)}
                className="flex-1 items-center rounded-full px-2 py-1.5"
                style={{ backgroundColor: activeTab ? colors.primary : 'rgba(0,0,0,0.05)' }}
              >
                <Text
                  className="text-xs font-medium"
                  style={{ color: activeTab ? colors.onPrimary : 'rgba(0,0,0,0.6)' }}
                >
                  {t(MODE_TAB[item])}
                </Text>
              </Pressable>
            );
          })}
        </View>

        <View className="mt-2 flex-row items-center bg-white px-4 py-3">
          <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>{t('vip.buy.balance')}</Text>
          <Text className="ml-2 text-lg font-bold" style={{ color: colors.primary }}>
            {formatKen(ken)} KEN
          </Text>
        </View>

        {!isGift && !vipActive && (
          <View className="flex-row items-center gap-2 bg-white px-4 py-2">
            <Text className="min-w-0 flex-1 text-xs" style={{ color: TEXT_SECONDARY }}>
              {t('avatarFrame.vipRequiredHint')}
            </Text>
            <Pressable
              onPress={() => navigation.navigate(ROOT_ROUTES.BuyVip, { mode: 'extend' })}
              className="rounded bg-ola-button px-3 py-1 active:opacity-90"
            >
              <Text className="text-xs font-medium" style={{ color: colors.onPrimary }}>
                {t('avatarFrame.buyVip')}
              </Text>
            </Pressable>
          </View>
        )}

        {selected != null ? renderForm(selected) : renderStatus()}
      </ScrollView>

      <AvatarFramePickerDialog
        visible={pickerOpen}
        selectedId={selected?.id}
        items={shop.items}
        onSelect={(item) => setSelectedId(item.id)}
        onClose={() => setPickerOpen(false)}
      />

      <ConfirmDialog
        visible={confirmOpen}
        title={t(MODE_TITLE[mode])}
        message={
          isGift
            ? t('avatarFrame.confirmGift', {
                frame: frameLabel,
                name: receiverUser?.username ?? '',
                price,
              })
            : t('avatarFrame.confirmBuy', { frame: frameLabel, price })
        }
        confirmLabel={t(MODE_TAB[mode])}
        cancelLabel={t('avatarFrame.cancel')}
        onConfirm={() => void confirmPurchase()}
        onCancel={() => setConfirmOpen(false)}
      />
    </KeyboardView>
  );
}
