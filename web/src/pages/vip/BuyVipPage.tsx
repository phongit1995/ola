import { useTranslation } from 'react-i18next';
import { formatKen, vipPackageLabel } from '@lib';
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
import type { VipPickerItem } from '@app-types';
import { VipDayTransferFields } from './components/VipDayTransferFields';
import { VipDayTransferSummary } from './components/VipDayTransferSummary';
import { ReceiverField } from './components/ReceiverField';
import { SelectChevron } from './components/SelectChevron';
import { useBuyVip } from '@ola/shared/stores/vip/useBuyVip';
import {
  BUY_VIP_MODE_ACTION,
  BUY_VIP_MODE_TAB,
  BUY_VIP_MODE_TITLE,
} from '@constants';

interface VipPickerDialogProps {
  open: boolean;
  selectedShopId: string;
  items: VipPickerItem[];
  onSelect: (item: VipPickerItem) => void;
  onClose: () => void;
}

function VipPickerDialog({
  open,
  selectedShopId,
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
                item.key === selectedShopId
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
  const {
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
    packages,
    selectedPackage,
    selectPackage,
    vipPickerOpen,
    setVipPickerOpen,
    packagePickerOpen,
    setPackagePickerOpen,
    confirmOpen,
    setConfirmOpen,
    giftPassword,
    setGiftPassword,
    handlePickVip,
    startPurchase,
    confirmPurchase,
    confirmText,
  } = useBuyVip(initialMode, onClose);

  const packageOptions: ListOption[] = packages.map((pkg) => ({
    key: pkg.id,
    label: vipPackageLabel(t, pkg),
    onSelect: () => selectPackage(pkg.id),
  }));

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t(BUY_VIP_MODE_TITLE[mode])} onBack={onClose} />

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
              {t(BUY_VIP_MODE_TAB[item])}
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
            receiverQuery={receiverQuery}
            receiverResults={receiverResults}
            receiverSearching={receiverSearching}
            onChangeQuery={setReceiverQuery}
            onPick={pickReceiver}
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
            {t(BUY_VIP_MODE_ACTION[mode])}
          </button>
        </div>
      </div>

      <VipPickerDialog
        open={vipPickerOpen}
        selectedShopId={selectedShopId}
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
        title={t(BUY_VIP_MODE_TITLE[mode])}
        message={
          isTransferDays ? (
            <VipDayTransferSummary
              senderDays={dayTransfer.senderDays}
              receiverDays={dayTransfer.receiverDays}
              receiver={receiver}
              note={t('vip.buy.transferDaysIrreversible')}
            />
          ) : (
            confirmText
          )
        }
        confirmLabel={t(BUY_VIP_MODE_ACTION[mode])}
        cancelLabel={t('vip.buy.cancel')}
        onConfirm={confirmPurchase}
        onCancel={() => setConfirmOpen(false)}
      />
    </FullScreenOverlay>
  );
}
