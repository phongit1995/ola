import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useGiftCatalogStore } from '@ola/shared/stores/gift/giftCatalogStore';
import { GiftService } from '@services';
import {
  canAffordGift,
  cn,
  formatKen,
  giftDisplayName,
  giftErrorText,
  giftTotalKen,
  randomUuid,
  toApiError,
  toast,
} from '@lib';
import type { Gift, GiftSource, SendGiftResult } from '@app-types';
import { useAuthStore } from '@/store/authStore';
import { useGiftAnimationStore } from '@/store/giftAnimationStore';
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

type Step = 'pick' | 'confirm';

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
  const gifts = useGiftCatalogStore((s) => s.items);
  const settings = useGiftCatalogStore((s) => s.settings);
  const loaded = useGiftCatalogStore((s) => s.loaded);
  const loadError = useGiftCatalogStore((s) => s.error);
  const loadCatalog = useGiftCatalogStore((s) => s.load);
  const balance = useAuthStore((s) => s.user?.ken ?? 0);
  const setUser = useAuthStore((s) => s.setUser);
  const playAnimation = useGiftAnimationStore((s) => s.play);

  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [quantity, setQuantity] = useState(1);
  const [note, setNote] = useState('');
  const [step, setStep] = useState<Step>('pick');
  const [submitting, setSubmitting] = useState(false);
  const [requestId, setRequestId] = useState(randomUuid);

  useEffect(() => {
    void loadCatalog(true);
  }, [loadCatalog]);

  const selected = useMemo<Gift | null>(
    () => gifts.find((gift) => gift.id === selectedId) ?? gifts[0] ?? null,
    [gifts, selectedId]
  );
  const total = selected != null ? giftTotalKen(selected, quantity) : 0;
  const affordable = selected != null && canAffordGift(balance, selected, quantity);
  const selectedName = selected != null ? giftDisplayName(selected, i18n.language) : '';

  function changeSelection(update: () => void) {
    update();
    setRequestId(randomUuid());
  }

  function requestSend() {
    if (selected == null || !affordable || submitting) return;
    if (total >= settings.confirmOverKen) {
      setStep('confirm');
      return;
    }
    void submit();
  }

  async function submit() {
    if (selected == null) return;
    setSubmitting(true);
    try {
      const result = await GiftService.send({
        giftId: selected.id,
        receiverId: receiver.id,
        quantity,
        note: note.trim() === '' ? undefined : note.trim(),
        source,
        clientRequestId: requestId,
      });
      const current = useAuthStore.getState().user;
      if (current != null) setUser({ ...current, ken: result.kenBalance });
      playAnimation({
        id: result.transactionId,
        imageUrl: result.gift.imageUrl,
        name: selectedName,
        quantity: result.quantity,
        charmPoints: result.charmPoints,
        caption: t('gift.sentToast', { name: selectedName, quantity: result.quantity }),
      });
      onSent?.(result);
      onClose();
    } catch (error) {
      toast.error(giftErrorText(t, toApiError(error)));
      setStep('pick');
    } finally {
      setSubmitting(false);
    }
  }

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
            <DialogButton onClick={() => setStep('pick')} disabled={submitting}>
              {t('dialog.cancel')}
            </DialogButton>
            <DialogButton
              variant="green"
              onClick={() => void submit()}
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
          onClick={requestSend}
          disabled={selected == null || !affordable || submitting || !settings.enabled}
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
                    onClick={() => changeSelection(() => setSelectedId(gift.id))}
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

        {loaded && settings.enabled && gifts.length > 0 && (
          <>
            <div className="flex items-center gap-2">
              <span className="text-sm text-black/54">{t('gift.quantity')}</span>
              <div className="flex flex-1 flex-wrap gap-1.5">
                {settings.quantityOptions.map((option) => (
                  <button
                    key={option}
                    type="button"
                    aria-pressed={option === quantity}
                    onClick={() => changeSelection(() => setQuantity(option))}
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
                onChange={(event) => changeSelection(() => setNote(event.target.value))}
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
