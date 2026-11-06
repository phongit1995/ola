import { useEffect, useMemo, useState } from 'react';
import i18n from 'i18next';
import { toApiError } from '../../lib/apiError';
import { canAffordGift, giftDisplayName, giftErrorText, giftTotalKen } from '../../lib/gift';
import { randomUuid } from '../../lib/randomUuid';
import { toast } from '../../lib/toast';
import { GiftService } from '../../services/gift.service';
import type { Gift } from '../../types/api/gift.type';
import type { GiftPicker, GiftPickerOptions, GiftPickerStep } from '../../types/client/gift.type';
import { useAuthStore } from '../auth/authStore';
import { useGiftAnimationStore } from './giftAnimationStore';
import { useGiftCatalogStore } from './giftCatalogStore';

export type { GiftPicker, GiftPickerOptions } from '../../types/client/gift.type';

export function useGiftPicker({ receiverId, source, onClose, onSent }: GiftPickerOptions): GiftPicker {
  const gifts = useGiftCatalogStore((s) => s.items);
  const settings = useGiftCatalogStore((s) => s.settings);
  const loaded = useGiftCatalogStore((s) => s.loaded);
  const loadError = useGiftCatalogStore((s) => s.error);
  const loadCatalog = useGiftCatalogStore((s) => s.load);
  const balance = useAuthStore((s) => s.user?.ken ?? 0);
  const playAnimation = useGiftAnimationStore((s) => s.play);

  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [quantity, setQuantity] = useState(1);
  const [note, setNote] = useState('');
  const [step, setStep] = useState<GiftPickerStep>('pick');
  const [submitting, setSubmitting] = useState(false);
  const [requestId, setRequestId] = useState(randomUuid);
  const [announce, setAnnounce] = useState(true);

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
  const canSend = selected != null && affordable && !submitting && settings.enabled;
  const canAnnounce = selected?.announceEnabled === true;

  function changeSelection(update: () => void) {
    update();
    setRequestId(randomUuid());
  }

  async function submit() {
    if (selected == null) return;
    setSubmitting(true);
    try {
      const trimmed = note.trim();
      const shouldAnnounce = canAnnounce && announce;
      const result = await GiftService.send({
        giftId: selected.id,
        receiverId,
        quantity,
        note: trimmed === '' ? undefined : trimmed,
        source,
        clientRequestId: requestId,
        announce: shouldAnnounce,
      });
      const current = useAuthStore.getState().user;
      if (current != null) useAuthStore.getState().setUser({ ...current, ken: result.kenBalance });
      playAnimation({
        id: result.transactionId,
        imageUrl: result.gift.imageUrl,
        animation: result.gift.animation,
        name: selectedName,
        quantity: result.quantity,
        charmPoints: result.senderCharmPoints ?? 0,
        caption: i18n.t('gift.sentToast', { name: selectedName, quantity: result.quantity }),
      });
      if (shouldAnnounce && result.announced !== true) toast.info(i18n.t('gift.announceSkipped'));
      onSent?.(result);
      onClose();
    } catch (error) {
      toast.error(giftErrorText(i18n.t, toApiError(error)));
      setStep('pick');
    } finally {
      setSubmitting(false);
    }
  }

  return {
    gifts,
    settings,
    loaded,
    loadError,
    ready: loaded && settings.enabled && gifts.length > 0,
    balance,
    selected,
    selectedName,
    quantity,
    note,
    total,
    affordable,
    step,
    submitting,
    canSend,
    canAnnounce,
    announce,
    setAnnounce,
    selectGift: (giftId) => changeSelection(() => setSelectedId(giftId)),
    selectQuantity: (value) => changeSelection(() => setQuantity(value)),
    changeNote: (value) => changeSelection(() => setNote(value)),
    requestSend: () => {
      if (!canSend) return;
      if (total >= settings.confirmOverKen) {
        setStep('confirm');
        return;
      }
      void submit();
    },
    confirmSend: () => {
      if (!submitting) void submit();
    },
    cancelConfirm: () => setStep('pick'),
  };
}
