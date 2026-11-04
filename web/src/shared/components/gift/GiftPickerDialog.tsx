import { useTranslation } from 'react-i18next';
import { useGiftPicker } from '@ola/shared/stores/gift/useGiftPicker';
import { cn, formatKen, giftDisplayName } from '@lib';
import type { GiftSource, SendGiftResult } from '@app-types';
import giftIcon from '@/assets/games/egg/ic_gift.png';
import kenIcon from '@/assets/icons/apps/ken.png';
import { Dialog, DialogButton } from '../ui/Dialog';
import { Avatar } from '../ui/Avatar';
import { Spinner } from '../ui/Spinner';

export interface GiftReceiver {
  id: string;
  name: string;
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

function GiftPickerContent({
  receiver,
  source,
  onClose,
  onSent,
}: GiftPickerDialogProps) {
  const { t, i18n } = useTranslation();
  const picker = useGiftPicker({ receiverId: receiver.id, source, onClose, onSent });
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

  const title = step === 'confirm' ? t('gift.confirmTitle') : t('gift.title');
  const icon = <img src={giftIcon} alt="" className="h-7 w-7 object-contain" />;

  if (step === 'confirm' && selected != null) {
    return (
      <Dialog
        open
        onClose={onClose}
        title={title}
        icon={icon}
        footer={
          <>
            <DialogButton onClick={picker.cancelConfirm} disabled={submitting}>
              {t('dialog.cancel')}
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
        <div className="flex flex-col items-center gap-2 px-2 py-2 text-center">
          <img src={selected.imageUrl} alt="" className="h-24 w-24 object-contain" />
          <p className="text-base text-black/87">
            {t('gift.confirmMessage', {
              quantity,
              name: selectedName,
              receiver: receiver.name,
              ken: formatKen(total),
            })}
          </p>
        </div>
      </Dialog>
    );
  }

  return (
    <Dialog
      open
      onClose={onClose}
      title={title}
      icon={icon}
      showClose
      footer={
        <DialogButton
          variant="green"
          className="flex-1"
          onClick={picker.requestSend}
          disabled={!picker.canSend}
        >
          {submitting ? t('gift.sending') : t('gift.send')}
        </DialogButton>
      }
    >
      <div className="flex flex-col gap-3 px-1 py-1">
        <div className="flex items-center gap-2">
          <Avatar name={receiver.name} src={receiver.avatar} color={receiver.color} size={32} />
          <span className="min-w-0 flex-1 truncate text-base font-medium text-black/87">
            {t('gift.toReceiver', { name: receiver.name })}
          </span>
        </div>

        {!loaded ? (
          <div className="flex justify-center py-8">
            {loadError ? (
              <span className="text-sm text-black/54">{t('gift.loadFailed')}</span>
            ) : (
              <Spinner size={24} />
            )}
          </div>
        ) : !settings.enabled ? (
          <p className="py-6 text-center text-sm text-black/54">{t('gift.disabledHint')}</p>
        ) : gifts.length === 0 ? (
          <p className="py-6 text-center text-sm text-black/54">{t('gift.empty')}</p>
        ) : (
          <ul className="grid max-h-[248px] grid-cols-4 gap-1.5 overflow-y-auto pr-0.5">
            {gifts.map((gift) => {
              const active = gift.id === selected?.id;
              return (
                <li key={gift.id}>
                  <button
                    type="button"
                    aria-pressed={active}
                    onClick={() => picker.selectGift(gift.id)}
                    className={cn(
                      'flex w-full flex-col items-center rounded-lg border px-1 pt-1.5 pb-1 transition-colors',
                      active
                        ? 'border-ola-accent bg-ola-accent/8 shadow-[0_0_0_1px_var(--color-ola-accent)]'
                        : 'border-black/8 bg-white hover:bg-black/3'
                    )}
                  >
                    <img
                      src={gift.imageUrl}
                      alt=""
                      loading="lazy"
                      className="h-12 w-12 object-contain"
                    />
                    <span className="mt-0.5 w-full truncate text-center text-xs text-black/87">
                      {giftDisplayName(gift, i18n.language)}
                    </span>
                    <span className="flex items-center gap-0.5 text-[11px] font-semibold text-ola-warning">
                      <img src={kenIcon} alt="" className="h-3 w-3 object-contain" />
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
              <span className="text-sm text-black/54">{t('gift.quantity')}</span>
              <div className="flex flex-1 flex-wrap gap-1.5">
                {settings.quantityOptions.map((option) => (
                  <button
                    key={option}
                    type="button"
                    aria-pressed={option === quantity}
                    onClick={() => picker.selectQuantity(option)}
                    className={cn(
                      'min-w-10 rounded-full border px-2.5 py-0.5 text-sm font-medium',
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
                className="w-full rounded border border-black/12 px-3 py-2 text-sm text-black/87 outline-none focus:border-ola-accent"
              />
            )}

            <div className="flex items-center justify-between rounded-lg bg-ola-surface px-3 py-2 text-sm">
              <span className="text-black/54">
                {t('gift.balance')}{' '}
                <b className="text-black/87">{t('gift.kenAmount', { ken: formatKen(balance) })}</b>
              </span>
              <span className={affordable ? 'text-black/54' : 'font-semibold text-ola-error'}>
                {affordable ? (
                  <>
                    {t('gift.total')}{' '}
                    <b className="text-ola-accent-dark">{t('gift.kenAmount', { ken: formatKen(total) })}</b>
                  </>
                ) : (
                  t('gift.notEnoughKen')
                )}
              </span>
            </div>
          </>
        )}
      </div>
    </Dialog>
  );
}
