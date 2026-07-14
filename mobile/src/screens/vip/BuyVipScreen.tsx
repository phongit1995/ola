import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Pressable,
  ScrollView,
  Text,
  TextInput,
  View,
} from 'react-native';
import { KeyboardView } from '../../components/KeyboardView';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { VipService, UserService } from '@ola/shared/services';
import { ApiError, formatKen, vipById, vipName } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { VipIconCatalogItem, VipPackageItem, UserSearchResult } from '@ola/shared/types';
import type { RootStackParamList } from '../../navigation/types';
import { ROOT_ROUTES } from '../../navigation/routes';
import { ConfirmDialog } from '../../components/ConfirmDialog';
import { Dialog } from '../../components/Dialog';
import { Avatar } from '../../components/Avatar';
import { ListOptionDialog, type ListOption } from '../../components/ListOptionDialog';
import { VipIconImage } from './VipIconImage';
import { ScreenHeader } from '../../components/ScreenHeader';

export type BuyVipMode = 'buy' | 'give' | 'giveDays' | 'extend';

const MOCK_KEN_BALANCE = 12_345;
const DEFAULT_VIP_ID = 4;
const MODE_ORDER: BuyVipMode[] = ['buy', 'give', 'giveDays', 'extend'];
const DIVIDER = 'rgba(0,0,0,0.12)';
const MUTED = 'rgba(0,0,0,0.54)';
const BODY = 'rgba(0,0,0,0.87)';

const MODE_TITLE = {
  buy: 'vip.buy.titleBuy',
  give: 'vip.buy.titleGive',
  giveDays: 'vip.buy.titleGiveDays',
  extend: 'vip.buy.titleExtend',
} as const;

const MODE_ACTION = {
  buy: 'vip.buyVip',
  give: 'vip.buy.actionGive',
  giveDays: 'vip.buy.actionGive',
  extend: 'vip.extendVip',
} as const;

const MODE_TAB = {
  buy: 'vip.buy.modeBuy',
  give: 'vip.buy.modeGive',
  giveDays: 'vip.buy.modeGiveDays',
  extend: 'vip.buy.modeExtend',
} as const;

type BuyErrorKey =
  | 'vip.buy.errInsufficientKen'
  | 'vip.buy.errItemUnavailable'
  | 'vip.buy.errPackageUnavailable'
  | 'vip.buy.errReceiverNotFound'
  | 'vip.buy.errGiftSelf'
  | 'vip.buy.errBlocked'
  | 'vip.buy.errWrongPassword';

const BUY_ERROR_KEYS: Record<string, BuyErrorKey> = {
  'insufficient ken balance': 'vip.buy.errInsufficientKen',
  'vip shop item not found': 'vip.buy.errItemUnavailable',
  'vip package not found': 'vip.buy.errPackageUnavailable',
  'receiver not found': 'vip.buy.errReceiverNotFound',
  'cannot gift to yourself': 'vip.buy.errGiftSelf',
  'cannot gift to blocked user': 'vip.buy.errBlocked',
  'invalid transfer password': 'vip.buy.errWrongPassword',
};

interface PickerItem {
  key: string;
  typeId: number;
  name: string;
  price?: number;
}

interface VipPickerDialogProps {
  visible: boolean;
  selectedKey: string;
  items: PickerItem[];
  onSelect: (item: PickerItem) => void;
  onClose: () => void;
}

function VipPickerDialog({ visible, selectedKey, items, onSelect, onClose }: VipPickerDialogProps) {
  const { t } = useTranslation();
  return (
    <Dialog visible={visible} title={t('vip.buy.pickVipTitle')} onClose={onClose}>
      {items.length === 0 ? (
            <Text className="py-8 text-center text-sm" style={{ color: MUTED }}>
              {t('vip.buy.shopEmpty')}
            </Text>
          ) : (
            <ScrollView style={{ maxHeight: 420 }}>
              <View className="flex-row flex-wrap">
                {items.map((item) => {
                  const selected = item.key === selectedKey;
                  return (
                    <Pressable
                      key={item.key}
                      onPress={() => {
                        onSelect(item);
                        onClose();
                      }}
                      className="items-center gap-1 rounded p-2 active:bg-black/5"
                      style={{
                        width: '33.33%',
                        backgroundColor: selected ? 'rgba(124,179,66,0.1)' : 'transparent',
                        borderWidth: 1,
                        borderColor: selected ? '#7cb342' : 'transparent',
                      }}
                    >
                      <VipIconImage typeId={item.typeId} size={44} />
                      <Text
                        numberOfLines={2}
                        className="text-center text-[11px] leading-tight"
                        style={{ color: 'rgba(0,0,0,0.7)' }}
                      >
                        {item.name}
                      </Text>
                      {item.price != null && (
                        <Text className="text-[11px] font-medium" style={{ color: '#7cb342' }}>
                          {formatKen(item.price)} KEN
                        </Text>
                      )}
                    </Pressable>
                  );
                })}
              </View>
            </ScrollView>
      )}
    </Dialog>
  );
}

function UserResultRow({ user, onPress }: { user: UserSearchResult; onPress?: () => void }) {
  return (
    <Pressable className="flex-row items-center gap-3 py-2 active:bg-black/5" onPress={onPress}>
      <View className="relative">
        <Avatar name={user.fullName || user.username} uri={user.avatar ?? undefined} size={40} />
        {user.isOnline && (
          <View
            className="absolute bottom-0 right-0 h-3 w-3 rounded-full bg-ola-primary"
            style={{ borderWidth: 2, borderColor: '#fff' }}
          />
        )}
      </View>
      <View className="min-w-0 flex-1">
        <Text numberOfLines={1} className="text-base" style={{ color: BODY }}>
          {user.fullName || user.username}
        </Text>
        <Text numberOfLines={1} className="text-xs" style={{ color: MUTED }}>
          @{user.username}
        </Text>
      </View>
    </Pressable>
  );
}

type Props = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.BuyVip>;

export function BuyVipScreen({ navigation, route }: Props) {
  const { t } = useTranslation();
  const user = useAuthStore((s) => s.user);
  const setUser = useAuthStore((s) => s.setUser);
  const refreshUser = useAuthStore((s) => s.refreshUser);
  const push = useToastStore((s) => s.push);

  const [mode, setMode] = useState<BuyVipMode>(route.params?.mode ?? 'buy');
  const [selectedVipId, setSelectedVipId] = useState(DEFAULT_VIP_ID);
  const [selectedShopId, setSelectedShopId] = useState('');
  const [selectedPackageId, setSelectedPackageId] = useState('');
  const [receiver, setReceiver] = useState('');
  const [receiverUser, setReceiverUser] = useState<UserSearchResult | null>(null);
  const [receiverQuery, setReceiverQuery] = useState('');
  const [receiverResults, setReceiverResults] = useState<UserSearchResult[]>([]);
  const [receiverSearching, setReceiverSearching] = useState(false);
  const [vipPickerOpen, setVipPickerOpen] = useState(false);
  const [packagePickerOpen, setPackagePickerOpen] = useState(false);
  const [confirmOpen, setConfirmOpen] = useState(false);
  const [giftPassword, setGiftPassword] = useState('');
  const [catalog, setCatalog] = useState<VipIconCatalogItem[]>([]);
  const [packages, setPackages] = useState<VipPackageItem[]>([]);
  const [purchasing, setPurchasing] = useState(false);

  useEffect(() => {
    let active = true;
    VipService.iconCatalog()
      .then((res) => {
        if (!active) return;
        setCatalog(res.items);
        const first = res.items[0];
        if (first != null) {
          setSelectedShopId(first.id);
          setSelectedVipId(first.vipTypeId);
        }
      })
      .catch(() => undefined);
    return () => {
      active = false;
    };
  }, []);

  useEffect(() => {
    let active = true;
    VipService.listPackages()
      .then((res) => {
        if (!active) return;
        setPackages(res.items);
        const first = res.items[0];
        if (first != null) setSelectedPackageId(first.id);
      })
      .catch(() => undefined);
    return () => {
      active = false;
    };
  }, []);

  useEffect(() => {
    const value = receiverQuery.trim();
    const timer = setTimeout(() => {
      if (value === '') {
        setReceiverResults([]);
        setReceiverSearching(false);
        return;
      }
      setReceiverSearching(true);
      UserService.search(value, 30)
        .then((res) => setReceiverResults(res.users))
        .catch(() => setReceiverResults([]))
        .finally(() => setReceiverSearching(false));
    }, 350);
    return () => clearTimeout(timer);
  }, [receiverQuery]);

  const isBuyIcon = mode === 'buy';
  const isExtend = mode === 'extend';
  const isGiftIcon = mode === 'give';
  const isGiftDays = mode === 'giveDays';
  const showReceiver = isGiftIcon || isGiftDays;
  const showVipSelect = isBuyIcon || isGiftIcon;
  const showPackage = isExtend || isGiftDays;

  const pickerItems: PickerItem[] = useMemo(
    () =>
      catalog.map((c) => ({
        key: c.id,
        typeId: c.vipTypeId,
        name: vipName(c.vipTypeId),
        price: c.kenPrice,
      })),
    [catalog],
  );

  const selectedShopItem = catalog.find((c) => c.id === selectedShopId);
  const displayVipId = selectedShopItem?.vipTypeId ?? selectedVipId;
  const selectedVip = vipById(displayVipId);
  const selectedPackage = packages.find((p) => p.id === selectedPackageId) ?? null;
  const kenBalance = user?.ken ?? MOCK_KEN_BALANCE;

  function handlePickVip(item: PickerItem) {
    setSelectedVipId(item.typeId);
    setSelectedShopId(item.key);
  }

  function pickReceiver(picked: UserSearchResult) {
    setReceiverUser(picked);
    setReceiver(picked.username);
    setReceiverQuery('');
    setReceiverResults([]);
  }

  function clearReceiver() {
    setReceiverUser(null);
    setReceiver('');
    setReceiverQuery('');
    setReceiverResults([]);
    setGiftPassword('');
  }

  function packageLabel(pkg: VipPackageItem): string {
    return t('vip.buy.kenPrice', { ken: formatKen(pkg.kenPrice), days: pkg.days });
  }

  const packageOptions: ListOption[] = packages.map((pkg) => ({
    key: pkg.id,
    label: packageLabel(pkg),
    onSelect: () => setSelectedPackageId(pkg.id),
  }));

  function buyErrorText(error: unknown): string {
    if (error instanceof ApiError) {
      const key = BUY_ERROR_KEYS[error.message];
      if (key != null) return t(key);
    }
    return t('vip.buy.failed');
  }

  function changeMode(next: BuyVipMode) {
    setMode(next);
    setConfirmOpen(false);
    clearReceiver();
  }

  function startPurchase() {
    if (showReceiver && receiver.trim().length === 0) {
      push('info', t('vip.buy.needReceiver'));
      return;
    }
    if (showVipSelect && selectedShopId === '') {
      push('info', t('vip.buy.needVip'));
      return;
    }
    if (showPackage && selectedPackageId === '') {
      push('info', t('vip.buy.needPackage'));
      return;
    }
    if (showReceiver && giftPassword.trim() === '') {
      push('info', t('vip.buy.needPassword'));
      return;
    }
    setConfirmOpen(true);
  }

  async function runPurchase<T extends { kenBalance: number }>(
    action: () => Promise<T>,
    successText: (result: T) => string,
  ) {
    setPurchasing(true);
    try {
      const result = await action();
      if (user != null) setUser({ ...user, ken: result.kenBalance });
      await refreshUser();
      setConfirmOpen(false);
      push('success', successText(result));
      navigation.goBack();
    } catch (error) {
      push('info', buyErrorText(error));
    } finally {
      setPurchasing(false);
    }
  }

  async function confirmPurchase() {
    if (purchasing) return;
    if (isBuyIcon) {
      if (selectedShopId === '') {
        setConfirmOpen(false);
        push('info', t('vip.buy.needVip'));
        return;
      }
      await runPurchase(
        () => VipService.buyIcon(selectedShopId),
        () => t('vip.buy.bought', { name: selectedVip?.name ?? '' }),
      );
      return;
    }
    if (isExtend) {
      if (selectedPackageId === '') {
        setConfirmOpen(false);
        push('info', t('vip.buy.needPackage'));
        return;
      }
      await runPurchase(
        () => VipService.buyPackage(selectedPackageId),
        (result) => t('vip.buy.extended', { days: result.days }),
      );
      return;
    }
    if (isGiftIcon) {
      if (selectedShopId === '') {
        setConfirmOpen(false);
        push('info', t('vip.buy.needVip'));
        return;
      }
      if (giftPassword.trim() === '') {
        push('info', t('vip.buy.needPassword'));
        return;
      }
      await runPurchase(
        () => VipService.giftIcon(selectedShopId, receiver.trim(), giftPassword),
        (result) =>
          t('vip.buy.giftedVip', { name: selectedVip?.name ?? '', receiver: result.receiverUsername }),
      );
      return;
    }
    if (isGiftDays) {
      if (selectedPackageId === '') {
        setConfirmOpen(false);
        push('info', t('vip.buy.needPackage'));
        return;
      }
      if (giftPassword.trim() === '') {
        push('info', t('vip.buy.needPassword'));
        return;
      }
      await runPurchase(
        () => VipService.giftPackage(selectedPackageId, receiver.trim(), giftPassword),
        (result) => t('vip.buy.gifted', { days: result.days, name: result.receiverUsername }),
      );
      return;
    }
    setConfirmOpen(false);
    push('info', t('vip.comingSoon'));
  }

  function confirmMessage(): string {
    const days = selectedPackage?.days ?? 0;
    const ken = formatKen(selectedPackage?.kenPrice ?? 0);
    switch (mode) {
      case 'buy':
        return t('vip.buy.confirmBuyIcon', {
          name: selectedVip?.name ?? '',
          ken: formatKen(selectedShopItem?.kenPrice ?? 0),
        });
      case 'give':
        return t('vip.buy.confirmGiveIcon', { name: selectedVip?.name ?? '', receiver });
      case 'giveDays':
        return t('vip.buy.confirmGiveDays', { days, ken, receiver });
      case 'extend':
      default:
        return t('vip.buy.confirmExtend', { days, ken });
    }
  }

  return (
    <KeyboardView
      className="flex-1"
      style={{ backgroundColor: '#ececec' }}
    >
      <ScreenHeader title={t(MODE_TITLE[mode])} onBack={() => navigation.goBack()} />

      <ScrollView className="flex-1" keyboardShouldPersistTaps="handled" contentContainerClassName="pb-6">
        <View className="flex-row gap-1 bg-white px-2 py-2">
          {MODE_ORDER.map((item) => {
            const activeTab = mode === item;
            return (
              <Pressable
                key={item}
                onPress={() => changeMode(item)}
                className="flex-1 items-center rounded-full px-2 py-1.5"
                style={{ backgroundColor: activeTab ? '#7cb342' : 'rgba(0,0,0,0.05)' }}
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
          <Text className="text-sm" style={{ color: MUTED }}>{t('vip.buy.balance')}</Text>
          <Text className="ml-2 text-lg font-bold" style={{ color: '#7cb342' }}>
            {formatKen(kenBalance)} KEN
          </Text>
        </View>

        {showReceiver && (
          <View className="mt-2 bg-white px-4 py-3">
            <Text className="text-xs" style={{ color: MUTED }}>{t('vip.buy.receiverLabel')}</Text>
            {receiverUser != null ? (
              <View
                className="mt-1 flex-row items-center rounded pl-2 pr-1"
                style={{ borderWidth: 1, borderColor: DIVIDER }}
              >
                <View className="min-w-0 flex-1">
                  <UserResultRow user={receiverUser} />
                </View>
                <Pressable
                  onPress={clearReceiver}
                  className="ml-1 h-8 w-8 items-center justify-center rounded-full active:bg-black/5"
                >
                  <Text className="text-base" style={{ color: 'rgba(0,0,0,0.4)' }}>✕</Text>
                </Pressable>
              </View>
            ) : (
              <>
                <TextInput
                  value={receiverQuery}
                  onChangeText={setReceiverQuery}
                  placeholder={t('vip.buy.receiverHint')}
                  placeholderTextColor="rgba(0,0,0,0.38)"
                  autoCapitalize="none"
                  className="mt-1 rounded bg-white px-3 py-2 text-sm"
                  style={{ borderWidth: 1, borderColor: DIVIDER, color: BODY }}
                />
                {receiverQuery.trim() !== '' && (
                  <View className="mt-2 rounded" style={{ borderWidth: 1, borderColor: DIVIDER, maxHeight: 224 }}>
                    {receiverSearching ? (
                      <Text className="py-3 text-center text-sm" style={{ color: MUTED }}>
                        {t('common.loading')}
                      </Text>
                    ) : receiverResults.length === 0 ? (
                      <Text className="py-3 text-center text-sm" style={{ color: MUTED }}>
                        {t('chat.composeSearchEmpty')}
                      </Text>
                    ) : (
                      <ScrollView keyboardShouldPersistTaps="handled" className="px-2">
                        {receiverResults.map((item, index) => (
                          <View
                            key={item.id}
                            style={index > 0 ? { borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.08)' } : null}
                          >
                            <UserResultRow user={item} onPress={() => pickReceiver(item)} />
                          </View>
                        ))}
                      </ScrollView>
                    )}
                  </View>
                )}
              </>
            )}
          </View>
        )}

        {showVipSelect && (
          <View className="mt-2 bg-white px-4 py-3">
            <Text className="text-xs" style={{ color: MUTED }}>{t('vip.buy.selectVip')}</Text>
            <Pressable
              onPress={() => setVipPickerOpen(true)}
              className="mt-1 w-full flex-row items-center gap-2 rounded px-2 py-1.5 active:bg-black/5"
              style={{ borderWidth: 1, borderColor: DIVIDER }}
            >
              <VipIconImage typeId={displayVipId} size={40} />
              <View style={{ width: 1, height: 36, backgroundColor: DIVIDER }} />
              <Text numberOfLines={1} className="flex-1 text-sm" style={{ color: BODY }}>
                {selectedVip?.name}
              </Text>
              {selectedShopItem != null && (
                <Text className="text-sm font-medium" style={{ color: '#7cb342' }}>
                  {formatKen(selectedShopItem.kenPrice)} KEN
                </Text>
              )}
              <Text className="text-base" style={{ color: 'rgba(0,0,0,0.4)' }}>▾</Text>
            </Pressable>
          </View>
        )}

        {showPackage && (
          <View className="mt-2 bg-white px-4 py-3">
            <Text className="text-xs" style={{ color: MUTED }}>{t('vip.buy.choosePackage')}</Text>
            <Pressable
              onPress={() => setPackagePickerOpen(true)}
              className="mt-1 w-full flex-row items-center rounded px-3 py-2 active:bg-black/5"
              style={{ borderWidth: 1, borderColor: DIVIDER }}
            >
              <Text className="flex-1 text-sm" style={{ color: BODY }}>
                {selectedPackage != null ? packageLabel(selectedPackage) : t('vip.buy.packagesEmpty')}
              </Text>
              <Text className="text-base" style={{ color: 'rgba(0,0,0,0.4)' }}>▾</Text>
            </Pressable>
          </View>
        )}

        {showReceiver && receiverUser != null && (
          <View className="mt-2 bg-white px-4 py-3">
            <Text className="text-xs" style={{ color: MUTED }}>{t('vip.buy.passwordLabel')}</Text>
            <TextInput
              secureTextEntry
              value={giftPassword}
              onChangeText={setGiftPassword}
              placeholder={t('vip.buy.passwordPlaceholder')}
              placeholderTextColor="rgba(0,0,0,0.38)"
              className="mt-1 w-full rounded px-3 py-2 text-sm"
              style={{ borderWidth: 1, borderColor: DIVIDER, color: BODY, backgroundColor: '#fff' }}
            />
          </View>
        )}

        <View className="px-4">
          <Pressable
            onPress={startPurchase}
            className="mt-4 w-full flex-row items-center justify-center rounded border border-ola-primary-dark bg-ola-button py-2.5 active:opacity-90"
          >
            {purchasing && <ActivityIndicator size="small" color="#fff" style={{ marginRight: 6 }} />}
            <Text className="text-sm font-medium text-white">{t(MODE_ACTION[mode])}</Text>
          </Pressable>
        </View>
      </ScrollView>

      <VipPickerDialog
        visible={vipPickerOpen}
        selectedKey={selectedShopId}
        items={pickerItems}
        onSelect={handlePickVip}
        onClose={() => setVipPickerOpen(false)}
      />

      <ListOptionDialog
        visible={packagePickerOpen}
        title={t('vip.buy.pickPackageTitle')}
        options={packageOptions}
        onClose={() => setPackagePickerOpen(false)}
      />

      <ConfirmDialog
        visible={confirmOpen}
        title={t(MODE_TITLE[mode])}
        message={confirmMessage()}
        confirmLabel={t(MODE_ACTION[mode])}
        cancelLabel={t('vip.buy.cancel')}
        onConfirm={() => void confirmPurchase()}
        onCancel={() => setConfirmOpen(false)}
      />

    </KeyboardView>
  );
}
