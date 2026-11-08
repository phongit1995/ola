import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ConfirmDialog,
  FullScreenOverlay,
  ScreenHeader,
  Spinner,
} from '@components';
import { avatarFrameErrorKey, formatKen, isVipActive, toast } from '@lib';
import type { AvatarFrameShopItem } from '@app-types';
import { avatarFrameLabel } from '@ola/shared/lib/avatarFrame';
import { useAvatarFrameShop } from '@ola/shared/stores/avatar-frame/useAvatarFrameShop';
import { ReceiverField } from '@/pages/vip/components/ReceiverField';
import { SelectChevron } from '@/pages/vip/components/SelectChevron';
import { useReceiverSearch } from '@/pages/vip/useReceiverSearch';
import { useAuthStore } from '@/store/authStore';
import { AvatarFramePickerDialog } from './components/AvatarFramePickerDialog';
import { OwnFramedAvatar } from './components/OwnFramedAvatar';
import { VipRequiredHint } from './components/VipRequiredHint';
import { FRAME_SELECT_AVATAR_SIZE } from './constants';

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

export function AvatarFrameShopPage({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();
  const ken = useAuthStore((s) => s.user?.ken ?? 0);
  const vipEndTime = useAuthStore((s) => s.user?.vipEndTime);
  const { items, loading, failed, busyItemId, reload, buy, gift } =
    useAvatarFrameShop();
  const receiverSearch = useReceiverSearch();
  const { receiverUser } = receiverSearch;
  const [mode, setMode] = useState<ShopMode>('buy');
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [pickerOpen, setPickerOpen] = useState(false);
  const [confirmOpen, setConfirmOpen] = useState(false);
  const [password, setPassword] = useState('');

  const isGift = mode === 'gift';
  const busy = busyItemId != null;
  const vipActive = isVipActive(vipEndTime);
  const selected: AvatarFrameShopItem | undefined =
    items.find((item) => item.id === selectedId) ??
    items.find((item) => !item.owned) ??
    items[0];
  const alreadyOwned = !isGift && selected?.owned === true;
  const price = formatKen(selected?.kenPrice ?? 0);
  const frameLabel = selected != null ? avatarFrameLabel(selected.frameId) : '';

  function clearReceiver() {
    receiverSearch.clearReceiver();
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
      toast.info(t('vip.buy.needReceiver'));
      return;
    }
    if (isGift && password.trim() === '') {
      toast.info(t('vip.buy.needPassword'));
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
        const result = await gift(selected, receiverUser.username, password);
        toast.success(
          t('avatarFrame.toastGifted', { name: result.receiverUsername })
        );
      } else {
        await buy(selected);
        toast.success(t('avatarFrame.toastBought'));
      }
      onClose();
    } catch (error) {
      toast.error(t(avatarFrameErrorKey(error)));
    }
  }

  function renderForm() {
    if (selected == null) {
      if (loading) {
        return (
          <div className="flex justify-center py-10">
            <Spinner size={24} />
          </div>
        );
      }
      if (failed) {
        return (
          <button
            type="button"
            onClick={() => void reload()}
            className="w-full py-16 text-center text-sm text-black/54"
          >
            {t('common.error')}
          </button>
        );
      }
      return (
        <div className="py-16 text-center text-sm text-black/54">
          {t('avatarFrame.shopEmpty')}
        </div>
      );
    }

    return (
      <>
        {isGift && (
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

        <div className="mt-2 bg-white px-4 py-3">
          <span className="text-xs text-black/54">
            {t('avatarFrame.selectFrame')}
          </span>
          <button
            type="button"
            onClick={() => setPickerOpen(true)}
            className="mt-1 flex w-full items-center gap-2 rounded border border-black/12 px-2 py-1.5 text-left active:bg-black/5"
          >
            <OwnFramedAvatar
              frameId={selected.frameId}
              size={FRAME_SELECT_AVATAR_SIZE}
            />
            <span className="h-9 w-px bg-black/12" />
            <span className="flex-1 truncate text-sm text-black/87">
              {frameLabel}
            </span>
            <span className="text-sm font-medium text-ola-primary-ink">
              {t('avatarFrame.price', { price })}
            </span>
            <SelectChevron />
          </button>
        </div>

        {isGift && receiverUser != null && (
          <div className="mt-2 bg-white px-4 py-3">
            <span className="text-xs text-black/54">
              {t('vip.buy.passwordLabel')}
            </span>
            <input
              type="password"
              value={password}
              onChange={(event) => setPassword(event.target.value)}
              placeholder={t('vip.buy.passwordPlaceholder')}
              className="mt-1 w-full rounded border border-black/12 bg-white px-3 py-2 text-sm text-black/87 outline-none placeholder:text-black/38 focus:border-ola-primary"
            />
          </div>
        )}

        <div className="px-4">
          <button
            type="button"
            disabled={busy || alreadyOwned}
            onClick={startPurchase}
            className="mt-4 w-full rounded border border-ola-primary-dark bg-ola-button py-2.5 text-sm font-medium text-ola-on-primary active:opacity-90 disabled:opacity-50"
          >
            {alreadyOwned ? t('avatarFrame.owned') : t(MODE_TITLE[mode])}
          </button>
        </div>
      </>
    );
  }

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('avatarFrame.shopTitle')} onBack={onClose} />

      <div className="flex-1 overflow-y-auto bg-ola-surface-dim pb-6">
        <div className="flex gap-1 bg-white px-2 py-2">
          {MODE_ORDER.map((item) => (
            <button
              key={item}
              type="button"
              onClick={() => changeMode(item)}
              className={`flex-1 rounded-full px-2 py-1.5 text-xs font-medium transition-colors ${
                mode === item
                  ? 'bg-ola-primary text-ola-on-primary'
                  : 'bg-black/5 text-black/60'
              }`}
            >
              {t(MODE_TAB[item])}
            </button>
          ))}
        </div>

        <div className="mt-2 flex items-center bg-white px-4 py-3">
          <span className="text-sm text-black/54">{t('vip.buy.balance')}</span>
          <span className="ml-2 text-lg font-bold text-ola-primary-ink">
            {t('avatarFrame.price', { price: formatKen(ken) })}
          </span>
        </div>

        {!isGift && !vipActive && <VipRequiredHint />}

        {renderForm()}
      </div>

      <AvatarFramePickerDialog
        open={pickerOpen}
        selectedId={selected?.id}
        items={items}
        onSelect={(item) => setSelectedId(item.id)}
        onClose={() => setPickerOpen(false)}
      />

      <ConfirmDialog
        open={confirmOpen}
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
    </FullScreenOverlay>
  );
}
