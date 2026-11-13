import { useEffect, useMemo, useState } from 'react';
import i18n from 'i18next';
import { BUY_VIP_DEFAULT_TYPE_ID, BUY_VIP_MODE_ORDER } from '../../constants/vip';
import { toast } from '../../lib/toast';
import { vipById, vipName } from '../../lib/vip';
import { vipBuyErrorText, vipConfirmMessage } from '../../lib/vipPurchase';
import { VipService } from '../../services/vip.service';
import type { VipIconCatalogItem, VipPackageItem } from '../../types/api/vip.type';
import type { BuyVipMode, VipPickerItem } from '../../types/client/vipPurchase.type';
import { useAuthStore } from '../auth/authStore';
import { useReceiverSearch } from '../user/useReceiverSearch';
import { useVipDayTransferForm } from './useVipDayTransferForm';
import {
  selectVipDayTransferEnabled,
  useVipDayTransferConfigStore,
} from './vipDayTransferConfigStore';

export function useBuyVip(initialMode: BuyVipMode | undefined, onDone: () => void) {
  const t = i18n.t;
  const user = useAuthStore((s) => s.user);
  const setUser = useAuthStore((s) => s.setUser);
  const refreshUser = useAuthStore((s) => s.refreshUser);

  const [selectedMode, setMode] = useState<BuyVipMode>(initialMode ?? 'buy');
  const dayTransferEnabled = useVipDayTransferConfigStore(selectVipDayTransferEnabled);
  const dayTransfer = useVipDayTransferForm(t);
  const mode: BuyVipMode =
    selectedMode === 'transferDays' && !dayTransferEnabled ? 'buy' : selectedMode;
  const visibleModes = BUY_VIP_MODE_ORDER.filter(
    (item) => item !== 'transferDays' || dayTransferEnabled
  );
  const [selectedVipId, setSelectedVipId] = useState(BUY_VIP_DEFAULT_TYPE_ID);
  const [selectedShopId, setSelectedShopId] = useState('');
  const [selectedPackageId, setSelectedPackageId] = useState('');
  const receiverSearch = useReceiverSearch();
  const { receiverUser } = receiverSearch;
  const receiver = receiverUser?.username ?? '';
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

  const isBuyIcon = mode === 'buy';
  const isExtend = mode === 'extend';
  const isGiftIcon = mode === 'give';
  const isGiftDays = mode === 'giveDays';
  const isTransferDays = mode === 'transferDays';
  const showReceiver = isGiftIcon || isGiftDays || isTransferDays;
  const showVipSelect = isBuyIcon || isGiftIcon;
  const showPackage = isExtend || isGiftDays;

  const pickerItems: VipPickerItem[] = useMemo(
    () =>
      catalog.map((c) => ({
        key: c.id,
        typeId: c.vipTypeId,
        name: vipName(c.vipTypeId),
        price: c.kenPrice,
      })),
    [catalog]
  );

  const selectedShopItem = catalog.find((c) => c.id === selectedShopId);
  const displayVipId = selectedShopItem?.vipTypeId ?? selectedVipId;
  const selectedVip = vipById(displayVipId);
  const selectedPackage = packages.find((p) => p.id === selectedPackageId) ?? null;
  const kenBalance = user?.ken ?? 0;

  function handlePickVip(item: VipPickerItem) {
    setSelectedVipId(item.typeId);
    setSelectedShopId(item.key);
  }

  function clearReceiver() {
    receiverSearch.clearReceiver();
    setGiftPassword('');
  }

  function changeMode(next: BuyVipMode) {
    setMode(next);
    setConfirmOpen(false);
    clearReceiver();
  }

  function startPurchase() {
    if (showReceiver && receiver.trim().length === 0) {
      toast.info(t('vip.buy.needReceiver'));
      return;
    }
    if (showVipSelect && selectedShopId === '') {
      toast.info(t('vip.buy.needVip'));
      return;
    }
    if (showPackage && selectedPackageId === '') {
      toast.info(t('vip.buy.needPackage'));
      return;
    }
    if (isTransferDays) {
      const inputError = dayTransfer.inputError();
      if (inputError != null) {
        toast.info(inputError);
        return;
      }
    }
    if (showReceiver && giftPassword.trim() === '') {
      toast.info(t('vip.buy.needPassword'));
      return;
    }
    setConfirmOpen(true);
  }

  async function runPurchase<T extends { kenBalance: number }>(
    action: () => Promise<T>,
    successText: (result: T) => string
  ) {
    setPurchasing(true);
    try {
      const result = await action();
      if (user != null) setUser({ ...user, ken: result.kenBalance });
      await refreshUser();
      setConfirmOpen(false);
      toast.success(successText(result));
      onDone();
    } catch (error) {
      toast.info(vipBuyErrorText(t, error));
    } finally {
      setPurchasing(false);
    }
  }

  function requireSelection(selected: string, missingKey: 'vip.buy.needVip' | 'vip.buy.needPackage') {
    if (selected !== '') return true;
    setConfirmOpen(false);
    toast.info(t(missingKey));
    return false;
  }

  function requirePassword() {
    if (giftPassword.trim() !== '') return true;
    toast.info(t('vip.buy.needPassword'));
    return false;
  }

  async function confirmPurchase() {
    if (purchasing) return;
    if (isBuyIcon) {
      if (!requireSelection(selectedShopId, 'vip.buy.needVip')) return;
      await runPurchase(
        () => VipService.buyIcon(selectedShopId),
        () => t('vip.buy.bought', { name: selectedVip?.name ?? '' })
      );
      return;
    }
    if (isExtend) {
      if (!requireSelection(selectedPackageId, 'vip.buy.needPackage')) return;
      await runPurchase(
        () => VipService.buyPackage(selectedPackageId),
        (result) => t('vip.buy.extended', { days: result.days })
      );
      return;
    }
    if (isGiftIcon) {
      if (!requireSelection(selectedShopId, 'vip.buy.needVip') || !requirePassword()) return;
      await runPurchase(
        () => VipService.giftIcon(selectedShopId, receiver.trim(), giftPassword),
        (result) =>
          t('vip.buy.giftedVip', {
            name: selectedVip?.name ?? '',
            receiver: result.receiverUsername,
          })
      );
      return;
    }
    if (isTransferDays) {
      const done = await dayTransfer.submit(receiver.trim(), giftPassword);
      setConfirmOpen(false);
      if (done) onDone();
      return;
    }
    if (isGiftDays) {
      if (!requireSelection(selectedPackageId, 'vip.buy.needPackage') || !requirePassword()) {
        return;
      }
      await runPurchase(
        () => VipService.giftPackage(selectedPackageId, receiver.trim(), giftPassword),
        (result) => t('vip.buy.gifted', { days: result.days, name: result.receiverUsername })
      );
      return;
    }
    setConfirmOpen(false);
    toast.info(t('vip.comingSoon'));
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
    visibleModes,
    isTransferDays,
    dayTransfer,
    receiver,
    changeMode,
    kenBalance,
    showReceiver,
    showVipSelect,
    showPackage,
    receiverUser,
    receiverQuery: receiverSearch.receiverQuery,
    setReceiverQuery: receiverSearch.setReceiverQuery,
    receiverResults: receiverSearch.receiverResults,
    receiverSearching: receiverSearch.receiverSearching,
    pickReceiver: receiverSearch.pickReceiver,
    clearReceiver,
    pickerItems,
    selectedShopId,
    selectedShopItem,
    displayVipId,
    selectedVip,
    packages,
    selectedPackage,
    selectPackage: setSelectedPackageId,
    vipPickerOpen,
    setVipPickerOpen,
    packagePickerOpen,
    setPackagePickerOpen,
    confirmOpen,
    setConfirmOpen,
    giftPassword,
    setGiftPassword,
    purchasing: purchasing || dayTransfer.submitting,
    handlePickVip,
    startPurchase,
    confirmPurchase,
    confirmText,
  };
}
