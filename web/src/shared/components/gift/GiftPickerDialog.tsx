import { useEffect, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { useGiftPicker } from '@ola/shared/stores/gift/useGiftPicker';
import { cn, formatKen, giftDisplayName } from '@lib';
import type { GiftSource, SendGiftResult } from '@app-types';
import giftIcon from '@/assets/games/spin-wheel/gift-list/gift-box.webp';
import kenIcon from '@/assets/icons/apps/ken.png';
import { Avatar } from '../ui/Avatar';
import { Dialog, DialogButton } from '../ui/Dialog';
import { Spinner } from '../ui/Spinner';
import { UserRow } from '../ui/UserRow';

export interface GiftReceiver {
  id: string;
  name: string;
  username?: string;
  avatar?: string;
  color: string;
}

interface GiftPickerDialogProps {
  open: boolean;
  receiver: GiftReceiver;
  source: GiftSource;
  onClose: () => void;
  onSent?: (result: SendGiftResult) => void;
}

export function GiftPickerDialog(props: GiftPickerDialogProps) {
  if (!props.open) return null;
  return <GiftPickerContent {...props} />;
}

function ReceiverRow({ receiver }: { receiver: GiftReceiver }) {
  return (
    <UserRow
      name={receiver.name}
      username={receiver.username}
      avatar={receiver.avatar}
      color={receiver.color}
    />
  );
}

function GiftPickerContent({
  receiver,
  source,
  onClose,
  onSent,
}: GiftPickerDialogProps) {
  const { t, i18n } = useTranslation();
  const picker = useGiftPicker({
    receiverId: receiver.id,
    source,
    onClose,
    onSent,
  });
  const {
    gifts,
    settings,
    loaded,
    loadError,
    ready,
    balance,
    selected,
    selectedName,
    quantity,
    note,
    total,
    affordable,
    step,
    submitting,
  } = picker;

  const listRef = useRef<HTMLUListElement>(null);
  const hasGifts = loaded && gifts.length > 0;

  useEffect(() => {
    if (!hasGifts) return;
    listRef.current
      ?.querySelector('[aria-pressed="true"]')
      ?.scrollIntoView({ block: 'nearest' });
  }, [hasGifts, step]);

  const icon = <img src={giftIcon} alt="" className="h-6 w-6 object-contain" />;

  if (step === 'confirm' && selected != null) {
    const trimmedNote = note.trim();
    return (
      <Dialog
        open
        onClose={onClose}
        title={t('gift.confirmTitle')}
        icon={icon}
        footer={
          <>
            <DialogButton onClick={picker.cancelConfirm} disabled={submitting}>
              {t('gift.edit')}
            </DialogButton>
            <DialogButton
              variant="green"
              onClick={picker.confirmSend}
              disabled={submitting}
            >
              {submitting ? t('gift.sending') : t('gift.send')}
            </DialogButton>
          </>
        }
      >
        <div className="flex flex-col gap-1 px-1 py-1">
          <span className="text-base text-black/54">
            {t('gift.receiverLabel')}
          </span>
          <ReceiverRow receiver={receiver} />
          <span className="mt-4 text-base text-black/54">
            {t('gift.giftLabel')}
          </span>
          <div className="mt-1 flex items-center gap-3">
            <img
              src={selected.imageUrl}
              alt=""
              className="h-16 w-16 shrink-0 object-contain"
            />
            <div className="min-w-0 flex-1">
              <p className="truncate text-lg font-bold text-black/87">
                {selectedName}{' '}
                <span className="text-ola-accent">
                  {t('gift.quantityTimes', { count: quantity })}
                </span>
              </p>
              <p className="text-sm text-black/54">
                {t('gift.receiverCharmGain', {
                  name: receiver.name,
                  value: formatKen(selected.charmPoints * quantity),
                })}
              </p>
            </div>
          </div>
          {trimmedNote !== '' && (
            <p className="mt-2 rounded border border-black/12 px-3 py-2 text-sm italic text-black/70">
              “{trimmedNote}”
            </p>
          )}
          <span className="mt-4 text-base text-black/54">
            {t('gift.total')}
          </span>
          <p className="mt-1 text-lg font-bold text-black/87">
            {formatKen(total)} {t('chat.transferKenUnit')}
          </p>
        </div>
      </Dialog>
    );
  }

  const sendLabel = submitting
    ? t('gift.sending')
    : !affordable && selected != null
      ? t('gift.notEnoughKen')
      : t('gift.sendWithTotal', { ken: formatKen(total) });

  return (
    <Dialog
      open
      onClose={onClose}
      title={t('gift.title')}
      icon={icon}
      footer={
        <DialogButton
          variant="green"
          onClick={picker.requestSend}
          disabled={!picker.canSend}
        >
          {sendLabel}
        </DialogButton>
      }
    >
      <div className="flex flex-col gap-2.5 px-1 py-1">
        <div className="flex items-center gap-3 rounded border border-black/12 px-3 py-2">
          <Avatar
            name={receiver.name}
            src={receiver.avatar}
            color={receiver.color}
            size={36}
          />
          <div className="min-w-0 flex-1">
            <p className="truncate text-base text-black/87">{receiver.name}</p>
            {receiver.username != null && receiver.username !== '' && (
              <p className="truncate text-xs text-black/54">
                @{receiver.username}
              </p>
            )}
          </div>
          <span className="flex shrink-0 items-center gap-1 text-base font-bold text-black/87">
            <img src={kenIcon} alt="" className="h-5 w-5 object-contain" />
            {formatKen(balance)}
          </span>
        </div>

        {!loaded ? (
          <div className="flex justify-center py-6">
            {loadError ? (
              <span className="text-sm text-black/54">
                {t('gift.loadFailed')}
              </span>
            ) : (
              <Spinner size={28} />
            )}
          </div>
        ) : !settings.enabled ? (
          <p className="py-4 text-center text-sm text-black/54">
            {t('gift.disabledHint')}
          </p>
        ) : gifts.length === 0 ? (
          <p className="py-4 text-center text-sm text-black/54">
            {t('gift.empty')}
          </p>
        ) : (
          <ul
            ref={listRef}
            className="grid max-h-[228px] grid-cols-3 gap-1 overflow-y-auto rounded border border-black/12 p-1"
          >
            {gifts.map((gift) => {
              const active = gift.id === selected?.id;
              return (
                <li key={gift.id}>
                  <button
                    type="button"
                    aria-pressed={active}
                    onClick={() => picker.selectGift(gift.id)}
                    className={cn(
                      'flex w-full flex-col items-center rounded-lg border bg-white px-1 pt-1.5 pb-1 transition-colors',
                      active
                        ? 'border-ola-accent'
                        : 'border-transparent hover:bg-black/3'
                    )}
                  >
                    <img
                      src={gift.imageUrl}
                      alt=""
                      loading="lazy"
                      className="h-16 w-16 object-contain"
                    />
                    <span className="mt-0.5 w-full truncate text-center text-xs text-black/87">
                      {giftDisplayName(gift, i18n.language)}
                    </span>
                    <span className="flex items-center gap-0.5 text-[11px] font-semibold text-ola-warning">
                      <img
                        src={kenIcon}
                        alt=""
                        className="h-3 w-3 object-contain"
                      />
                      {formatKen(gift.kenPrice)}
                    </span>
                  </button>
                </li>
              );
            })}
          </ul>
        )}

        {ready && (
          <>
            <div className="flex items-center gap-2">
              <span className="shrink-0 text-sm text-black/87">
                {t('gift.quantity')}
              </span>
              <div className="flex flex-1 gap-1.5">
                {settings.quantityOptions.map((option) => (
                  <button
                    key={option}
                    type="button"
                    aria-pressed={option === quantity}
                    onClick={() => picker.selectQuantity(option)}
                    className={cn(
                      'flex-1 rounded border py-1 text-sm font-medium',
                      option === quantity
                        ? 'border-ola-accent bg-ola-accent text-white'
                        : 'border-black/12 bg-white text-black/70'
                    )}
                  >
                    {t('gift.quantityTimes', { count: option })}
                  </button>
                ))}
              </div>
            </div>

            {settings.noteMaxLength > 0 && (
              <input
                type="text"
                value={note}
                maxLength={settings.noteMaxLength}
                onChange={(event) => picker.changeNote(event.target.value)}
                placeholder={t('gift.notePlaceholder')}
                className="w-full rounded border border-black/12 px-3 py-1.5 text-sm text-black/87 outline-none focus:border-ola-primary"
              />
            )}
          </>
        )}
      </div>
    </Dialog>
  );
}
