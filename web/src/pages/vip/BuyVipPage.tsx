import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useLocation, useNavigate } from 'react-router-dom';
import { ROUTES } from '@constants';
import { toast, ApiError, formatKen } from '@lib';
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
import { useAuthStore } from '@/store/authStore';
import { VIP_CATALOG, vipById, vipName } from './vipCatalog';

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
  | 'vip.buy.errPackageUnavailable';

const BUY_ERROR_KEYS: Record<string, BuyErrorKey> = {
  'insufficient ken balance': 'vip.buy.errInsufficientKen',
  'vip shop item not found': 'vip.buy.errItemUnavailable',
  'vip package not found': 'vip.buy.errPackageUnavailable',
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
                <span className="text-[11px] font-medium text-ola-primary">{item.price} KEN</span>
              )}
            </button>
          ))}
        </div>
      )}
    </Dialog>
  );
}

export function BuyVipPage() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const location = useLocation();
  const user = useAuthStore((s) => s.user);
  const setUser = useAuthStore((s) => s.setUser);
  const refreshUser = useAuthStore((s) => s.refreshUser);

  const initialMode = (location.state as { mode?: BuyVipMode } | null)?.mode ?? 'buy';
  const [mode, setMode] = useState<BuyVipMode>(initialMode);
  const [selectedVipId, setSelectedVipId] = useState(DEFAULT_VIP_ID);
  const [selectedShopId, setSelectedShopId] = useState('');
  const [selectedPackageId, setSelectedPackageId] = useState('');
  const [receiver, setReceiver] = useState('');
  const [vipPickerOpen, setVipPickerOpen] = useState(false);
  const [packagePickerOpen, setPackagePickerOpen] = useState(false);
  const [confirmOpen, setConfirmOpen] = useState(false);
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

  const showReceiver = mode === 'give' || mode === 'giveDays';
  const showVipSelect = mode === 'buy' || mode === 'give';
  const showPackage = mode === 'extend' || mode === 'giveDays';
  const isBuyIcon = mode === 'buy';
  const isExtend = mode === 'extend';

  const buyItems: PickerItem[] = useMemo(
    () =>
      catalog.map((c) => ({
        key: c.id,
        typeId: c.vipTypeId,
        name: vipName(c.vipTypeId),
        price: c.kenPrice,
      })),
    [catalog],
  );

  const giveItems: PickerItem[] = useMemo(
    () => VIP_CATALOG.map((e) => ({ key: String(e.id), typeId: e.id, name: e.name })),
    [],
  );

  const pickerItems = isBuyIcon ? buyItems : giveItems;
  const selectedShopItem = catalog.find((c) => c.id === selectedShopId);
  const displayVipId = isBuyIcon ? (selectedShopItem?.vipTypeId ?? selectedVipId) : selectedVipId;
  const selectedKey = isBuyIcon ? selectedShopId : String(selectedVipId);
  const selectedVip = vipById(displayVipId);

  const selectedPackage = packages.find((p) => p.id === selectedPackageId) ?? null;
  const kenBalance = user?.ken ?? MOCK_KEN_BALANCE;

  function handlePickVip(item: PickerItem) {
    setSelectedVipId(item.typeId);
    if (isBuyIcon) setSelectedShopId(item.key);
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
  }

  function startPurchase() {
    if (showReceiver && receiver.trim().length === 0) {
      toast.info(t('vip.buy.needReceiver'));
      return;
    }
    if (isBuyIcon && !selectedShopId) {
      toast.info(t('vip.buy.needVip'));
      return;
    }
    if (showVipSelect && selectedVip == null) {
      toast.info(t('vip.buy.needVip'));
      return;
    }
    if (showPackage && !selectedPackageId) {
      toast.info(t('vip.buy.needPackage'));
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
        navigate(ROUTES.vip);
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
        navigate(ROUTES.vip);
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
      <ScreenHeader title={t(MODE_TITLE[mode])} onBack={() => navigate(ROUTES.vip)} />

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
            <input
              type="text"
              value={receiver}
              onChange={(event) => setReceiver(event.target.value)}
              placeholder={t('vip.buy.receiverHint')}
              className="mt-1 w-full rounded border border-black/12 bg-white px-3 py-2 text-sm text-black/87 outline-none placeholder:text-black/38 focus:border-ola-primary"
            />
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
              {isBuyIcon && selectedShopItem != null && (
                <span className="text-sm font-medium text-ola-primary">
                  {selectedShopItem.kenPrice} KEN
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
        message={confirmMessage()}
        confirmLabel={t(MODE_ACTION[mode])}
        cancelLabel={t('vip.buy.cancel')}
        onConfirm={confirmPurchase}
        onCancel={() => setConfirmOpen(false)}
      />
    </FullScreenOverlay>
  );
}
