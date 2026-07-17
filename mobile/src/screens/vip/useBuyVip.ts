import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { UserService, VipService } from '@ola/shared/services';
import {
  vipBuyErrorText,
  vipById,
  vipConfirmMessage,
  vipName,
  vipPackageLabel,
  type BuyVipMode,
} from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { VipIconCatalogItem, VipPackageItem, UserSearchResult } from '@ola/shared/types';
import type { ListOption } from '@components/ui/ListOptionDialog';
import {
  DEFAULT_VIP_ID,
  MOCK_KEN_BALANCE,
  RECEIVER_SEARCH_DEBOUNCE_MS,
  RECEIVER_SEARCH_LIMIT,
} from './constants';
import type { PickerItem } from './interface';

export function useBuyVip(initialMode: BuyVipMode | undefined, onDone: () => void) {
  const { t } = useTranslation();
  const user = useAuthStore((s) => s.user);
  const setUser = useAuthStore((s) => s.setUser);
  const refreshUser = useAuthStore((s) => s.refreshUser);
  const push = useToastStore((s) => s.push);

  const [mode, setMode] = useState<BuyVipMode>(initialMode ?? 'buy');
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
      UserService.search(value, RECEIVER_SEARCH_LIMIT)
        .then((res) => setReceiverResults(res.users))
        .catch(() => setReceiverResults([]))
        .finally(() => setReceiverSearching(false));
    }, RECEIVER_SEARCH_DEBOUNCE_MS);
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

  const packageOptions: ListOption[] = packages.map((pkg) => ({
    key: pkg.id,
    label: vipPackageLabel(t, pkg),
    onSelect: () => setSelectedPackageId(pkg.id),
  }));

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
      onDone();
    } catch (error) {
      push('info', vipBuyErrorText(t, error));
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
          t('vip.buy.giftedVip', {
            name: selectedVip?.name ?? '',
            receiver: result.receiverUsername,
          }),
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

  const confirmText = vipConfirmMessage(t, {
    mode,
    selectedPackage,
    vipName: selectedVip?.name ?? '',
    shopItemKenPrice: selectedShopItem?.kenPrice ?? 0,
    receiver,
  });

  return {
    mode,
    changeMode,
    kenBalance,
    showReceiver,
    showVipSelect,
    showPackage,
    receiverUser,
    receiverQuery,
    setReceiverQuery,
    receiverResults,
    receiverSearching,
    pickReceiver,
    clearReceiver,
    pickerItems,
    selectedShopId,
    selectedShopItem,
    displayVipId,
    selectedVip,
    selectedPackage,
    packageOptions,
    vipPickerOpen,
    setVipPickerOpen,
    packagePickerOpen,
    setPackagePickerOpen,
    confirmOpen,
    setConfirmOpen,
    giftPassword,
    setGiftPassword,
    purchasing,
    handlePickVip,
    startPurchase,
    confirmPurchase,
    confirmText,
  };
}
