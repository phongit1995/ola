import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ConfirmDialog, Dialog, DialogButton } from '@components';
import { avatarFrameErrorKey, formatKen, toast } from '@lib';
import type { AvatarFrameShopItem } from '@app-types';
import type { AvatarFrameShopState } from '@ola/shared/stores/avatar-frame/useAvatarFrameShop';
import { FRAME_INPUT_CLASS, FRAME_PREVIEW_AVATAR_SIZE } from '../constants';
import { avatarFrameLabel } from '@ola/shared/lib/avatarFrame';
import { OwnFramedAvatar } from './OwnFramedAvatar';

type DialogStep = 'detail' | 'gift';

interface AvatarFrameShopItemDialogProps {
  item: AvatarFrameShopItem;
  busy: boolean;
  buy: AvatarFrameShopState['buy'];
  gift: AvatarFrameShopState['gift'];
  onClose: () => void;
}

export function AvatarFrameShopItemDialog({
  item,
  busy,
  buy,
  gift,
  onClose,
}: AvatarFrameShopItemDialogProps) {
  const { t } = useTranslation();
  const [step, setStep] = useState<DialogStep>('detail');
  const [confirmOpen, setConfirmOpen] = useState(false);
  const [receiver, setReceiver] = useState('');
  const [password, setPassword] = useState('');
  const price = formatKen(item.kenPrice);
  const canSubmitGift =
    receiver.trim() !== '' && password.trim() !== '' && !busy;

  async function confirmBuy() {
    setConfirmOpen(false);
    try {
      await buy(item);
      toast.success(t('avatarFrame.toastBought'));
      onClose();
    } catch (error) {
      toast.error(t(avatarFrameErrorKey(error)));
    }
  }

  async function submitGift() {
    if (!canSubmitGift) return;
    try {
      const result = await gift(item, receiver, password);
      toast.success(
        t('avatarFrame.toastGifted', { name: result.receiverUsername })
      );
      onClose();
    } catch (error) {
      toast.error(t(avatarFrameErrorKey(error)));
    }
  }

  const footer =
    step === 'detail' ? (
      <>
        <DialogButton
          variant="green"
          disabled={item.owned || busy}
          onClick={() => setConfirmOpen(true)}
        >
          {item.owned ? t('avatarFrame.owned') : t('avatarFrame.actionBuy')}
        </DialogButton>
        <DialogButton disabled={busy} onClick={() => setStep('gift')}>
          {t('avatarFrame.actionGift')}
        </DialogButton>
      </>
    ) : (
      <>
        <DialogButton disabled={busy} onClick={() => setStep('detail')}>
          {t('avatarFrame.cancel')}
        </DialogButton>
        <DialogButton
          variant="green"
          disabled={!canSubmitGift}
          onClick={() => void submitGift()}
        >
          {t('avatarFrame.actionGift')}
        </DialogButton>
      </>
    );

  return (
    <>
      <Dialog
        open
        onClose={onClose}
        showClose
        title={
          step === 'gift'
            ? t('avatarFrame.giftTitle')
            : avatarFrameLabel(item.frameId)
        }
        footer={footer}
      >
        <div className="flex flex-col items-center gap-1 pt-3">
          <OwnFramedAvatar
            frameId={item.frameId}
            size={FRAME_PREVIEW_AVATAR_SIZE}
          />
          <span className="mt-3 text-base font-medium text-black/87">
            {avatarFrameLabel(item.frameId)}
          </span>
          <span className="text-sm font-bold text-ola-primary-ink">
            {t('avatarFrame.price', { price })}
          </span>
        </div>
        {step === 'gift' && (
          <div className="mt-3 flex flex-col gap-2 px-1">
            <label className="flex flex-col text-sm text-black/54">
              {t('avatarFrame.giftReceiver')}
              <input
                type="text"
                autoFocus
                value={receiver}
                onChange={(event) => setReceiver(event.target.value)}
                className={FRAME_INPUT_CLASS}
              />
            </label>
            <label className="flex flex-col text-sm text-black/54">
              {t('avatarFrame.password')}
              <input
                type="password"
                value={password}
                onChange={(event) => setPassword(event.target.value)}
                onKeyDown={(event) => {
                  if (event.key === 'Enter') void submitGift();
                }}
                placeholder={t('avatarFrame.passwordHint')}
                className={FRAME_INPUT_CLASS}
              />
            </label>
          </div>
        )}
      </Dialog>
      <ConfirmDialog
        open={confirmOpen}
        title={t('avatarFrame.confirmBuyTitle')}
        message={t('avatarFrame.confirmBuy', { id: item.frameId, price })}
        confirmLabel={t('avatarFrame.actionBuy')}
        cancelLabel={t('avatarFrame.cancel')}
        onConfirm={() => void confirmBuy()}
        onCancel={() => setConfirmOpen(false)}
      />
    </>
  );
}
