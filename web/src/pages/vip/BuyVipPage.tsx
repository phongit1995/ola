import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useLocation, useNavigate } from 'react-router-dom';
import { ROUTES } from '@constants';
import { toast } from '@lib';
import {
  ScreenHeader,
  FullScreenOverlay,
  Dialog,
  ConfirmDialog,
  ListOptionDialog,
} from '@components';
import type { ListOption } from '@components';
import { useAuthStore } from '@/store/authStore';
import { VIP_CATALOG, vipById, vipIconUrl, type VipCatalogEntry } from './vipCatalog';

type BuyVipMode = 'buy' | 'give' | 'giveDays' | 'extend';

interface KenPackage {
  kind: 'ken';
  days: number;
  ken: number;
}

interface SmsPackage {
  kind: 'sms';
  days: number;
  vnd: string;
  code: string;
}

type VipPackage = KenPackage | SmsPackage;

const KEN_PACKAGES: KenPackage[] = [
  { kind: 'ken', days: 7, ken: 70 },
  { kind: 'ken', days: 30, ken: 250 },
  { kind: 'ken', days: 90, ken: 600 },
  { kind: 'ken', days: 365, ken: 2000 },
];

const SMS_PACKAGES: SmsPackage[] = [
  { kind: 'sms', days: 10, vnd: '10,000', code: '8655' },
  { kind: 'sms', days: 20, vnd: '15,000', code: '8755' },
];

const MOCK_KEN_BALANCE = 12_345;
const DEFAULT_VIP_ID = 4;
const FALLBACK_PACKAGE: KenPackage = { kind: 'ken', days: 7, ken: 70 };
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

function VipThumbnail({ id, size = 40 }: { id: number; size?: number }) {
  return (
    <img
      src={vipIconUrl(id)}
      alt=""
      width={size}
      height={size}
      className="shrink-0 object-contain"
    />
  );
}

interface VipPickerDialogProps {
  open: boolean;
  selectedId: number;
  onSelect: (entry: VipCatalogEntry) => void;
  onClose: () => void;
}

function VipPickerDialog({ open, selectedId, onSelect, onClose }: VipPickerDialogProps) {
  const { t } = useTranslation();
  return (
    <Dialog open={open} onClose={onClose} title={t('vip.buy.pickVipTitle')}>
      <div className="grid max-h-[60vh] grid-cols-3 gap-1 overflow-y-auto sm:grid-cols-4">
        {VIP_CATALOG.map((entry) => (
          <button
            key={entry.id}
            type="button"
            onClick={() => {
              onSelect(entry);
              onClose();
            }}
            className={`flex flex-col items-center gap-1 rounded p-2 active:bg-black/5 ${
              entry.id === selectedId ? 'bg-ola-primary/10 ring-1 ring-ola-primary' : ''
            }`}
          >
            <VipThumbnail id={entry.id} size={44} />
            <span className="line-clamp-2 text-center text-[11px] leading-tight text-black/70">
              {entry.name}
            </span>
          </button>
        ))}
      </div>
    </Dialog>
  );
}

export function BuyVipPage() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const location = useLocation();
  const user = useAuthStore((s) => s.user);

  const initialMode = (location.state as { mode?: BuyVipMode } | null)?.mode ?? 'buy';
  const [mode, setMode] = useState<BuyVipMode>(initialMode);
  const [bySms, setBySms] = useState(false);
  const [selectedVipId, setSelectedVipId] = useState(DEFAULT_VIP_ID);
  const [packageIndex, setPackageIndex] = useState(0);
  const [receiver, setReceiver] = useState('');
  const [vipPickerOpen, setVipPickerOpen] = useState(false);
  const [packagePickerOpen, setPackagePickerOpen] = useState(false);
  const [confirmOpen, setConfirmOpen] = useState(false);

  const showReceiver = mode !== 'buy';
  const showVipSelect = mode === 'buy' || mode === 'give';
  const receiverLocked = mode === 'extend';

  const packages: VipPackage[] = bySms ? SMS_PACKAGES : KEN_PACKAGES;
  const selectedPackage: VipPackage =
    packages[Math.min(packageIndex, packages.length - 1)] ?? FALLBACK_PACKAGE;
  const selectedVip = vipById(selectedVipId);
  const kenBalance = user?.ken ?? MOCK_KEN_BALANCE;
  const receiverValue = receiverLocked ? (user?.username ?? '') : receiver;

  function packageLabel(pkg: VipPackage): string {
    if (pkg.kind === 'ken') {
      return t('vip.buy.kenPrice', { ken: pkg.ken.toLocaleString('en-US'), days: pkg.days });
    }
    return t('vip.buy.smsPrice', { vnd: pkg.vnd, days: pkg.days });
  }

  const packageOptions: ListOption[] = packages.map((pkg, index) => ({
    key: `${pkg.kind}-${index}`,
    label: packageLabel(pkg),
    onSelect: () => setPackageIndex(index),
  }));

  function changeMode(next: BuyVipMode) {
    setMode(next);
    setConfirmOpen(false);
  }

  function toggleSms(value: boolean) {
    setBySms(value);
    setPackageIndex(0);
  }

  function startPurchase() {
    if (showReceiver && !receiverLocked && receiverValue.trim().length === 0) {
      toast.info(t('vip.buy.needReceiver'));
      return;
    }
    if (showVipSelect && selectedVip == null) {
      toast.info(t('vip.buy.needVip'));
      return;
    }
    setConfirmOpen(true);
  }

  function confirmPurchase() {
    setConfirmOpen(false);
    toast.info(t('vip.comingSoon'));
  }

  function confirmMessage(): string {
    const pkg = packageLabel(selectedPackage);
    const days = selectedPackage.days;
    const ken = selectedPackage.kind === 'ken' ? selectedPackage.ken.toLocaleString('en-US') : '—';
    switch (mode) {
      case 'buy':
        return t('vip.buy.confirmBuy', { name: selectedVip?.name ?? '', pkg });
      case 'give':
        return t('vip.buy.confirmGive', { name: selectedVip?.name ?? '', pkg, receiver: receiverValue });
      case 'giveDays':
        return t('vip.buy.confirmGiveDays', { days, ken, receiver: receiverValue });
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
              {kenBalance.toLocaleString('en-US')} KEN
            </span>
          </div>
        </div>

        {showReceiver && (
          <div className="mt-2 bg-white px-4 py-3">
            <span className="text-xs text-black/54">{t('vip.buy.receiverLabel')}</span>
            <input
              type="text"
              value={receiverValue}
              disabled={receiverLocked}
              onChange={(event) => setReceiver(event.target.value)}
              placeholder={t('vip.buy.receiverHint')}
              className="mt-1 w-full rounded border border-black/12 bg-white px-3 py-2 text-sm text-black/87 outline-none placeholder:text-black/38 focus:border-ola-primary disabled:bg-black/5 disabled:text-black/54"
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
              <VipThumbnail id={selectedVipId} />
              <span className="h-9 w-px bg-black/12" />
              <span className="flex-1 truncate text-sm text-black/87">{selectedVip?.name}</span>
              <ChevronIcon />
            </button>
          </div>
        )}

        <div className="mt-2 bg-white px-4 py-3">
          <span className="text-xs text-black/54">{t('vip.buy.choosePackage')}</span>
          <button
            type="button"
            onClick={() => setPackagePickerOpen(true)}
            className="mt-1 flex w-full items-center rounded border border-black/12 px-3 py-2 text-left active:bg-black/5"
          >
            <span className="flex-1 text-sm text-black/87">{packageLabel(selectedPackage)}</span>
            <ChevronIcon />
          </button>
        </div>

        <label className="mt-2 flex items-center gap-2 bg-white px-4 py-3 text-sm text-black/87">
          <input
            type="checkbox"
            checked={bySms}
            onChange={(event) => toggleSms(event.target.checked)}
            className="h-4 w-4 accent-ola-primary"
          />
          {t('vip.buy.bySms')}
        </label>

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
        selectedId={selectedVipId}
        onSelect={(entry) => setSelectedVipId(entry.id)}
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
