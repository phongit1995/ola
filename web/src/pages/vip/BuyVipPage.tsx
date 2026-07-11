import { useEffect, useMemo, useState } from 'react';
import { useDebouncedCallback } from 'use-debounce';
import { useTranslation } from 'react-i18next';
import { toast, ApiError, formatKen, colorForName, vipById, vipName } from '@lib';
import {
  ScreenHeader,
  FullScreenOverlay,
  Dialog,
  ConfirmDialog,
  ListOptionDialog,
  UserRow,
  VipIcon,
} from '@components';
import type { ListOption } from '@components';
import { VipService, UserService } from '@services';
import type { VipIconCatalogItem, VipPackageItem, UserSearchResult } from '@app-types';
import { useAuthStore } from '@/store/authStore';

type BuyVipMode = 'buy' | 'give' | 'giveDays' | 'extend';

const MOCK_KEN_BALANCE = 12_345;
const DEFAULT_VIP_ID = 4;
const MODE_ORDER: BuyVipMode[] = ['buy', 'give', 'giveDays', 'extend'];

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

const MODE_TAB = {
  buy: 'vip.buy.modeBuy',
  give: 'vip.buy.modeGive',
  giveDays: 'vip.buy.modeGiveDays',
  extend: 'vip.buy.modeExtend',
} as const;

function ChevronIcon() {
  return (
    <svg viewBox="0 0 24 24" className="h-5 w-5 text-black/40" fill="currentColor" aria-hidden="true">
      <path d="M7 10l5 5 5-5z" />
    </svg>
  );
}

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

function VipPickerDialog({ open, selectedKey, items, onSelect, onClose }: VipPickerDialogProps) {
  const { t } = useTranslation();
  return (
    <Dialog open={open} onClose={onClose} title={t('vip.buy.pickVipTitle')}>
      {items.length === 0 ? (
        <div className="py-8 text-center text-sm text-black/54">{t('vip.buy.shopEmpty')}</div>
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
                item.key === selectedKey ? 'bg-ola-primary/10 ring-1 ring-ola-primary' : ''
              }`}
            >
              <VipIcon typeId={item.typeId} size={44} />
              <span className="line-clamp-2 text-center text-[11px] leading-tight text-black/70">
                {item.name}
              </span>
              {item.price != null && (
                <span className="text-[11px] font-medium text-ola-primary">
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

export function BuyVipPage({ mode: initialMode = 'buy', onClose }: { mode?: BuyVipMode; onClose: () => void }) {
  const { t } = useTranslation();
  const user = useAuthStore((s) => s.user);
  const setUser = useAuthStore((s) => s.setUser);
  const refreshUser = useAuthStore((s) => s.refreshUser);

  const [mode, setMode] = useState<BuyVipMode>(initialMode);
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

  const runReceiverSearch = useDebouncedCallback((value: string) => {
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

  function handleReceiverQueryChange(value: string) {
    setReceiverQuery(value);
    runReceiverSearch(value.trim());
  }

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
  const selectedKey = selectedShopId;
  const selectedVip = vipById(displayVipId);

  const selectedPackage = packages.find((p) => p.id === selectedPackageId) ?? null;
  const kenBalance = user?.ken ?? MOCK_KEN_BALANCE;

  function handlePickVip(item: PickerItem) {
    setSelectedVipId(item.typeId);
    setSelectedShopId(item.key);
  }

  function pickReceiver(user: UserSearchResult) {
    runReceiverSearch.cancel();
    setReceiverUser(user);
    setReceiver(user.username);
    setReceiverQuery('');
    setReceiverResults([]);
  }

  function clearReceiver() {
    runReceiverSearch.cancel();
    setReceiverUser(null);
    setReceiver('');
    setReceiverQuery('');
    setReceiverResults([]);
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
      if (key) return t(key);
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
    setGiftPassword('');
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
        toast.info(buyErrorText(error));
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
        toast.info(buyErrorText(error));
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
      setPurchasing(true);
      try {
        const result = await VipService.giftIcon(selectedShopId, receiver.trim());
        if (user) setUser({ ...user, ken: result.kenBalance });
        await refreshUser();
        setConfirmOpen(false);
        toast.success(
          t('vip.buy.giftedVip', { name: selectedVip?.name ?? '', receiver: result.receiverUsername }),
        );
        onClose();
      } catch (error) {
        toast.info(buyErrorText(error));
      } finally {
        setPurchasing(false);
      }
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
        const result = await VipService.giftPackage(selectedPackageId, receiver.trim(), giftPassword);
        if (user) setUser({ ...user, ken: result.kenBalance });
        await refreshUser();
        setConfirmOpen(false);
        toast.success(t('vip.buy.gifted', { days: result.days, name: result.receiverUsername }));
        onClose();
      } catch (error) {
        toast.info(buyErrorText(error));
      } finally {
        setPurchasing(false);
      }
      return;
    }
    setConfirmOpen(false);
    toast.info(t('vip.comingSoon'));
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
    <FullScreenOverlay>
      <ScreenHeader title={t(MODE_TITLE[mode])} onBack={onClose} />

      <div className="flex-1 overflow-y-auto bg-[#ececec] pb-6">
        <div className="flex gap-1 bg-white px-2 py-2">
          {MODE_ORDER.map((item) => (
            <button
              key={item}
              type="button"
              onClick={() => changeMode(item)}
              className={`flex-1 rounded-full px-2 py-1.5 text-xs font-medium transition-colors ${
                mode === item ? 'bg-ola-primary text-white' : 'bg-black/5 text-black/60'
              }`}
            >
              {t(MODE_TAB[item])}
            </button>
          ))}
        </div>

        <div className="mt-2 bg-white px-4 py-3">
          <div className="flex items-center">
            <span className="text-sm text-black/54">{t('vip.buy.balance')}</span>
            <span className="ml-2 text-lg font-bold text-ola-primary">
              {formatKen(kenBalance)} KEN
            </span>
          </div>
        </div>

        {showReceiver && (
          <div className="mt-2 bg-white px-4 py-3">
            <span className="text-xs text-black/54">{t('vip.buy.receiverLabel')}</span>
            {receiverUser != null ? (
              <div className="mt-1 flex items-center rounded border border-black/12 pr-1 pl-2">
                <div className="min-w-0 flex-1">
                  <UserRow
                    name={receiverUser.fullName || receiverUser.username}
                    username={receiverUser.username}
                    avatar={receiverUser.avatar}
                    color={colorForName(receiverUser.username)}
                    online={receiverUser.isOnline}
                  />
                </div>
                <button
                  type="button"
                  onClick={clearReceiver}
                  aria-label={t('common.cancel')}
                  className="ml-1 shrink-0 rounded-full p-1.5 text-black/40 active:bg-black/5"
                >
                  <svg viewBox="0 0 24 24" className="h-5 w-5" fill="currentColor" aria-hidden="true">
                    <path d="M18.3 5.71 12 12l6.3 6.29-1.41 1.42L10.59 13.4 4.29 19.7 2.88 18.3 9.17 12 2.88 5.71 4.29 4.29l6.3 6.3 6.3-6.3z" />
                  </svg>
                </button>
              </div>
            ) : (
              <>
                <input
                  type="text"
                  value={receiverQuery}
                  onChange={(event) => handleReceiverQueryChange(event.target.value)}
                  placeholder={t('vip.buy.receiverHint')}
                  className="mt-1 w-full rounded border border-black/12 bg-white px-3 py-2 text-sm text-black/87 outline-none placeholder:text-black/38 focus:border-ola-primary"
                />
                {receiverQuery.trim() !== '' && (
                  <div className="mt-2 max-h-56 overflow-y-auto rounded border border-black/12">
                    {receiverSearching ? (
                      <p className="py-3 text-center text-sm text-black/54">{t('common.loading')}</p>
                    ) : receiverResults.length === 0 ? (
                      <p className="py-3 text-center text-sm text-black/54">
                        {t('chat.composeSearchEmpty')}
                      </p>
                    ) : (
                      <ul className="divide-y divide-black/8 px-2">
                        {receiverResults.map((item) => (
                          <li key={item.id}>
                            <UserRow
                              name={item.fullName || item.username}
                              username={item.username}
                              avatar={item.avatar}
                              color={colorForName(item.username)}
                              online={item.isOnline}
                              onClick={() => pickReceiver(item)}
                            />
                          </li>
                        ))}
                      </ul>
                    )}
                  </div>
                )}
              </>
            )}
          </div>
        )}

        {showVipSelect && (
          <div className="mt-2 bg-white px-4 py-3">
            <span className="text-xs text-black/54">{t('vip.buy.selectVip')}</span>
            <button
              type="button"
              onClick={() => setVipPickerOpen(true)}
              className="mt-1 flex w-full items-center gap-2 rounded border border-black/12 px-2 py-1.5 text-left active:bg-black/5"
            >
              <VipIcon typeId={displayVipId} size={40} />
              <span className="h-9 w-px bg-black/12" />
              <span className="flex-1 truncate text-sm text-black/87">{selectedVip?.name}</span>
              {selectedShopItem != null && (
                <span className="text-sm font-medium text-ola-primary">
                  {formatKen(selectedShopItem.kenPrice)} KEN
                </span>
              )}
              <ChevronIcon />
            </button>
          </div>
        )}

        {showPackage && (
          <div className="mt-2 bg-white px-4 py-3">
            <span className="text-xs text-black/54">{t('vip.buy.choosePackage')}</span>
            <button
              type="button"
              onClick={() => setPackagePickerOpen(true)}
              className="mt-1 flex w-full items-center rounded border border-black/12 px-3 py-2 text-left active:bg-black/5"
            >
              <span className="flex-1 text-sm text-black/87">
                {selectedPackage ? packageLabel(selectedPackage) : t('vip.buy.packagesEmpty')}
              </span>
              <ChevronIcon />
            </button>
          </div>
        )}

        <div className="px-4">
          <button
            type="button"
            onClick={startPurchase}
            className="mt-4 w-full rounded border border-ola-primary-dark bg-ola-button py-2.5 text-sm font-medium text-white active:opacity-90"
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
          isGiftDays ? (
            <span className="block">
              {confirmMessage()}
              <input
                type="password"
                autoFocus
                value={giftPassword}
                onChange={(event) => setGiftPassword(event.target.value)}
                placeholder={t('vip.buy.passwordPlaceholder')}
                className="mt-3 w-full rounded border border-black/12 px-3 py-2 text-base text-black/87 outline-none focus:border-ola-primary"
              />
            </span>
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
