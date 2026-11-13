import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  toast,
  formatKen,
  vipBuyErrorText,
  vipConfirmMessage,
  vipPackageLabel,
  vipById,
  vipName,
} from '@lib';
import type { BuyVipMode } from '@ola/shared/types';
import {
  ScreenHeader,
  FullScreenOverlay,
  Dialog,
  ConfirmDialog,
  ListOptionDialog,
  VipIcon,
} from '@components';
import type { ListOption } from '@components';
import { VipService } from '@services';
import type { VipIconCatalogItem, VipPackageItem } from '@app-types';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useVipDayTransferForm } from '@ola/shared/stores/vip/useVipDayTransferForm';
import {
  selectVipDayTransferEnabled,
  useVipDayTransferConfigStore,
} from '@ola/shared/stores/vip/vipDayTransferConfigStore';
import { VipDayTransferFields } from './components/VipDayTransferFields';
import { VipDayTransferSummary } from './components/VipDayTransferSummary';
import { ReceiverField } from './components/ReceiverField';
import { SelectChevron } from './components/SelectChevron';
import { useReceiverSearch } from '@ola/shared/stores/user/useReceiverSearch';

const DEFAULT_VIP_ID = 4;
const MODE_ORDER: BuyVipMode[] = ['buy', 'give', 'giveDays', 'transferDays', 'extend'];

const MODE_TITLE = {
  buy: 'vip.buy.titleBuy',
  give: 'vip.buy.titleGive',
  giveDays: 'vip.buy.titleGiveDays',
  transferDays: 'vip.buy.titleTransferDays',
  extend: 'vip.buy.titleExtend',
} as const;

const MODE_ACTION = {
  buy: 'vip.buyVip',
  give: 'vip.buy.actionGive',
  giveDays: 'vip.buy.actionGive',
  transferDays: 'vip.buy.actionTransferDays',
  extend: 'vip.extendVip',
} as const;

const MODE_TAB = {
  buy: 'vip.buy.modeBuy',
  give: 'vip.buy.modeGive',
  giveDays: 'vip.buy.modeGiveDays',
  transferDays: 'vip.buy.modeTransferDays',
  extend: 'vip.buy.modeExtend',
} as const;

interface PickerItem {
  key: string;
  typeId: number;
  name: string;
  price?: number;
}

interface VipPickerDialogProps {
  open: boolean;
  selectedKey: string;
  items: PickerItem[];
  onSelect: (item: PickerItem) => void;
  onClose: () => void;
}

function VipPickerDialog({
  open,
  selectedKey,
  items,
  onSelect,
  onClose,
}: VipPickerDialogProps) {
  const { t } = useTranslation();
  return (
    <Dialog open={open} onClose={onClose} title={t('vip.buy.pickVipTitle')}>
      {items.length === 0 ? (
        <div className="py-8 text-center text-sm text-black/54">
          {t('vip.buy.shopEmpty')}
        </div>
      ) : (
        <div className="grid max-h-[60vh] grid-cols-3 gap-1 overflow-y-auto sm:grid-cols-4">
          {items.map((item) => (
            <button
              key={item.key}
              type="button"
              onClick={() => {
                onSelect(item);
                onClose();
              }}
              className={`flex flex-col items-center gap-1 rounded p-2 active:bg-black/5 ${
                item.key === selectedKey
                  ? 'bg-ola-primary/10 ring-1 ring-ola-primary'
                  : ''
              }`}
            >
              <VipIcon typeId={item.typeId} size={44} />
              <span className="line-clamp-2 text-center text-[11px] leading-tight text-black/70">
                {item.name}
              </span>
              {item.price != null && (
                <span className="text-[11px] font-medium text-ola-primary-ink">
                  {formatKen(item.price)} KEN
                </span>
              )}
            </button>
          ))}
        </div>
      )}
    </Dialog>
  );
}

export function BuyVipPage({
  mode: initialMode = 'buy',
  onClose,
}: {
  mode?: BuyVipMode;
  onClose: () => void;
}) {
  const { t } = useTranslation();
  const user = useAuthStore((s) => s.user);
  const setUser = useAuthStore((s) => s.setUser);
  const refreshUser = useAuthStore((s) => s.refreshUser);

  const [selectedMode, setMode] = useState<BuyVipMode>(initialMode);
  const dayTransferEnabled = useVipDayTransferConfigStore(
    selectVipDayTransferEnabled
  );
  const dayTransfer = useVipDayTransferForm(t);
  const mode: BuyVipMode =
    selectedMode === 'transferDays' && !dayTransferEnabled
      ? 'buy'
      : selectedMode;
  const visibleModes = MODE_ORDER.filter(
    (item) => item !== 'transferDays' || dayTransferEnabled
  );
  const [selectedVipId, setSelectedVipId] = useState(DEFAULT_VIP_ID);
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
        if (first) {
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
        if (first) setSelectedPackageId(first.id);
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

  const pickerItems: PickerItem[] = useMemo(
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
  const selectedKey = selectedShopId;
  const selectedVip = vipById(displayVipId);

  const selectedPackage =
    packages.find((p) => p.id === selectedPackageId) ?? null;
  const kenBalance = user?.ken ?? 0;

  function handlePickVip(item: PickerItem) {
    setSelectedVipId(item.typeId);
    setSelectedShopId(item.key);
  }

  function clearReceiver() {
    receiverSearch.clearReceiver();
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
      toast.info(t('vip.buy.needReceiver'));
      return;
    }
    if (showVipSelect && !selectedShopId) {
      toast.info(t('vip.buy.needVip'));
      return;
    }
    if (showPackage && !selectedPackageId) {
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

  async function confirmPurchase() {
    if (purchasing) return;
    if (isBuyIcon) {
      if (!selectedShopId) {
        setConfirmOpen(false);
        toast.info(t('vip.buy.needVip'));
        return;
      }
      setPurchasing(true);
      try {
        const result = await VipService.buyIcon(selectedShopId);
        if (user) setUser({ ...user, ken: result.kenBalance });
        await refreshUser();
        setConfirmOpen(false);
        toast.success(t('vip.buy.bought', { name: selectedVip?.name ?? '' }));
        onClose();
      } catch (error) {
        toast.info(vipBuyErrorText(t, error));
      } finally {
        setPurchasing(false);
      }
      return;
    }
    if (isExtend) {
      if (!selectedPackageId) {
        setConfirmOpen(false);
        toast.info(t('vip.buy.needPackage'));
        return;
      }
      setPurchasing(true);
      try {
        const result = await VipService.buyPackage(selectedPackageId);
        if (user) setUser({ ...user, ken: result.kenBalance });
        await refreshUser();
        setConfirmOpen(false);
        toast.success(t('vip.buy.extended', { days: result.days }));
        onClose();
      } catch (error) {
        toast.info(vipBuyErrorText(t, error));
      } finally {
        setPurchasing(false);
      }
      return;
    }
    if (isGiftIcon) {
      if (!selectedShopId) {
        setConfirmOpen(false);
        toast.info(t('vip.buy.needVip'));
        return;
      }
      if (giftPassword.trim() === '') {
        toast.info(t('vip.buy.needPassword'));
        return;
      }
      setPurchasing(true);
      try {
        const result = await VipService.giftIcon(
          selectedShopId,
          receiver.trim(),
          giftPassword
        );
        if (user) setUser({ ...user, ken: result.kenBalance });
        await refreshUser();
        setConfirmOpen(false);
        toast.success(
          t('vip.buy.giftedVip', {
            name: selectedVip?.name ?? '',
            receiver: result.receiverUsername,
          })
        );
        onClose();
      } catch (error) {
        toast.info(vipBuyErrorText(t, error));
      } finally {
        setPurchasing(false);
      }
      return;
    }
    if (isTransferDays) {
      const done = await dayTransfer.submit(receiver.trim(), giftPassword);
      setConfirmOpen(false);
      if (done) onClose();
      return;
    }
    if (isGiftDays) {
      if (!selectedPackageId) {
        setConfirmOpen(false);
        toast.info(t('vip.buy.needPackage'));
        return;
      }
      if (giftPassword.trim() === '') {
        toast.info(t('vip.buy.needPassword'));
        return;
      }
      setPurchasing(true);
      try {
        const result = await VipService.giftPackage(
          selectedPackageId,
          receiver.trim(),
          giftPassword
        );
        if (user) setUser({ ...user, ken: result.kenBalance });
        await refreshUser();
        setConfirmOpen(false);
        toast.success(
          t('vip.buy.gifted', {
            days: result.days,
            name: result.receiverUsername,
          })
        );
        onClose();
      } catch (error) {
        toast.info(vipBuyErrorText(t, error));
      } finally {
        setPurchasing(false);
      }
      return;
    }
    setConfirmOpen(false);
    toast.info(t('vip.comingSoon'));
  }

  function confirmMessage(): string {
    return vipConfirmMessage(t, {
      mode,
      selectedPackage,
      vipName: selectedVip?.name ?? '',
      shopItemKenPrice: selectedShopItem?.kenPrice ?? 0,
      receiver,
    });
  }

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t(MODE_TITLE[mode])} onBack={onClose} />

      <div className="flex-1 overflow-y-auto bg-ola-surface-dim pb-6">
        <div className="flex gap-1 bg-white px-2 py-2">
          {visibleModes.map((item) => (
            <button
              key={item}
              type="button"
              onClick={() => changeMode(item)}
              className={`flex-auto rounded-full px-1 py-1.5 text-xs font-medium whitespace-nowrap transition-colors ${
                mode === item
                  ? 'bg-ola-primary text-ola-on-primary'
                  : 'bg-black/5 text-black/60'
              }`}
            >
              {t(MODE_TAB[item])}
            </button>
          ))}
        </div>

        {!isTransferDays && (
          <div className="mt-2 bg-white px-4 py-3">
            <div className="flex items-center">
              <span className="text-sm text-black/54">
                {t('vip.buy.balance')}
              </span>
              <span className="ml-2 text-lg font-bold text-ola-primary-ink">
                {formatKen(kenBalance)} KEN
              </span>
            </div>
          </div>
        )}

        {showReceiver && (
          <ReceiverField
            receiverUser={receiverUser}
            receiverQuery={receiverSearch.receiverQuery}
            receiverResults={receiverSearch.receiverResults}
            receiverSearching={receiverSearch.receiverSearching}
            onChangeQuery={receiverSearch.setReceiverQuery}
            onPick={receiverSearch.pickReceiver}
            onClear={clearReceiver}
          />
        )}

        {showVipSelect && (
          <div className="mt-2 bg-white px-4 py-3">
            <span className="text-xs text-black/54">
              {t('vip.buy.selectVip')}
            </span>
            <button
              type="button"
              onClick={() => setVipPickerOpen(true)}
              className="mt-1 flex w-full items-center gap-2 rounded border border-black/12 px-2 py-1.5 text-left active:bg-black/5"
            >
              <VipIcon typeId={displayVipId} size={40} />
              <span className="h-9 w-px bg-black/12" />
              <span className="flex-1 truncate text-sm text-black/87">
                {selectedVip?.name}
              </span>
              {selectedShopItem != null && (
                <span className="text-sm font-medium text-ola-primary-ink">
                  {formatKen(selectedShopItem.kenPrice)} KEN
                </span>
              )}
              <SelectChevron />
            </button>
          </div>
        )}

        {showPackage && (
          <div className="mt-2 bg-white px-4 py-3">
            <span className="text-xs text-black/54">
              {t('vip.buy.choosePackage')}
            </span>
            <button
              type="button"
              onClick={() => setPackagePickerOpen(true)}
              className="mt-1 flex w-full items-center rounded border border-black/12 px-3 py-2 text-left active:bg-black/5"
            >
              <span className="flex-1 text-sm text-black/87">
                {selectedPackage
                  ? vipPackageLabel(t, selectedPackage)
                  : t('vip.buy.packagesEmpty')}
              </span>
              <SelectChevron />
            </button>
          </div>
        )}

        {isTransferDays && (
          <div className="mt-2 bg-white px-4 py-3">
            <VipDayTransferFields form={dayTransfer} />
          </div>
        )}

        {showReceiver && receiverUser != null && (
          <div className="mt-2 bg-white px-4 py-3">
            <span className="text-xs text-black/54">
              {t('vip.buy.passwordLabel')}
            </span>
            <input
              type="password"
              value={giftPassword}
              onChange={(event) => setGiftPassword(event.target.value)}
              placeholder={t('vip.buy.passwordPlaceholder')}
              className="mt-1 w-full rounded border border-black/12 bg-white px-3 py-2 text-sm text-black/87 outline-none placeholder:text-black/38 focus:border-ola-primary"
            />
          </div>
        )}

        <div className="px-4">
          <button
            type="button"
            onClick={startPurchase}
            className="mt-4 w-full rounded border border-ola-primary-dark bg-ola-button py-2.5 text-sm font-medium text-ola-on-primary active:opacity-90"
          >
            {t(MODE_ACTION[mode])}
          </button>
        </div>
      </div>

      <VipPickerDialog
        open={vipPickerOpen}
        selectedKey={selectedKey}
        items={pickerItems}
        onSelect={handlePickVip}
        onClose={() => setVipPickerOpen(false)}
      />

      <ListOptionDialog
        open={packagePickerOpen}
        title={t('vip.buy.pickPackageTitle')}
        options={packageOptions}
        onClose={() => setPackagePickerOpen(false)}
      />

      <ConfirmDialog
        open={confirmOpen}
        title={t(MODE_TITLE[mode])}
        message={
          isTransferDays ? (
            <VipDayTransferSummary
              senderDays={dayTransfer.senderDays}
              receiverDays={dayTransfer.receiverDays}
              receiver={receiver}
              note={t('vip.buy.transferDaysIrreversible')}
            />
          ) : (
            confirmMessage()
          )
        }
        confirmLabel={t(MODE_ACTION[mode])}
        cancelLabel={t('vip.buy.cancel')}
        onConfirm={confirmPurchase}
        onCancel={() => setConfirmOpen(false)}
      />
    </FullScreenOverlay>
  );
}
