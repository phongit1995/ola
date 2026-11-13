import { useState } from 'react';
import i18n from 'i18next';
import { KEN_TRANSFER_MAX, KEN_TRANSFER_MIN } from '../../constants/ken';
import { formatKen } from '../../lib/number';
import { toast } from '../../lib/toast';
import { transferAmountDigits, transferErrorText } from '../../lib/transfer';
import { KenService } from '../../services/ken.service';
import type { UserSearchResult } from '../../types/api/user.type';
import type { TransferKenStep, TransferTarget } from '../../types/client/transfer.type';
import { useAuthStore } from '../auth/authStore';

interface UseTransferKenOptions<R extends TransferTarget> {
  receiver?: R;
  toReceiver: (user: UserSearchResult) => R;
  onDone: () => void;
}

function amountError(amount: number, receiverId: string, myId: string, balance: number) {
  if (amount <= 0) return i18n.t('chat.transferKenErrEmpty');
  if (receiverId === myId) return i18n.t('chat.transferKenErrSelf');
  if (amount < KEN_TRANSFER_MIN) {
    return i18n.t('chat.transferKenErrMin', { min: formatKen(KEN_TRANSFER_MIN) });
  }
  if (amount > KEN_TRANSFER_MAX) {
    return i18n.t('chat.transferKenErrMax', { max: formatKen(KEN_TRANSFER_MAX) });
  }
  if (amount > balance) return i18n.t('chat.transferKenErrNotEnough');
  return null;
}

export function useTransferKen<R extends TransferTarget>({
  receiver,
  toReceiver,
  onDone,
}: UseTransferKenOptions<R>) {
  const myId = useAuthStore((s) => s.user?.id ?? '');
  const balance = useAuthStore((s) => s.user?.ken ?? 0);
  const setUser = useAuthStore((s) => s.setUser);

  const [step, setStep] = useState<TransferKenStep>(receiver != null ? 'input' : 'recipient');
  const [pickedReceiver, setPickedReceiver] = useState<R | null>(null);
  const [amountDigits, setAmountDigits] = useState('');
  const [password, setPassword] = useState('');
  const [submitting, setSubmitting] = useState(false);

  const activeReceiver = receiver ?? pickedReceiver;
  const amount = amountDigits === '' ? 0 : Number(amountDigits);
  const displayAmount = amountDigits === '' ? '' : formatKen(amount);

  function changeAmount(value: string) {
    setAmountDigits(transferAmountDigits(value));
  }

  function pickReceiver(user: UserSearchResult) {
    setPickedReceiver(toReceiver(user));
    setStep('input');
  }

  function changeReceiver() {
    setPickedReceiver(null);
    setAmountDigits('');
    setStep('recipient');
  }

  function goToConfirm() {
    if (activeReceiver == null) return;
    const error = amountError(amount, activeReceiver.id, myId, balance);
    if (error != null) {
      toast.error(error);
      return;
    }
    setStep('confirm');
  }

  async function submitTransfer() {
    if (activeReceiver == null) return;
    if (password.trim() === '') {
      toast.error(i18n.t('chat.transferKenErrPasswordEmpty'));
      return;
    }
    setSubmitting(true);
    try {
      const result = await KenService.transfer({ toUserId: activeReceiver.id, amount, password });
      const current = useAuthStore.getState().user;
      if (current != null) setUser({ ...current, ken: result.kenBalance });
      toast.success(i18n.t('chat.transferKenSuccess', { name: activeReceiver.name }));
      onDone();
    } catch (error) {
      toast.error(
        transferErrorText(i18n.t, error, {
          network: 'chat.transferKenError',
          unauthorized: 'chat.transferKenErrPassword',
          forbidden: 'chat.transferKenErrBlocked',
        })
      );
    } finally {
      setSubmitting(false);
    }
  }

  return {
    balance,
    step,
    setStep,
    activeReceiver,
    amount,
    displayAmount,
    changeAmount,
    password,
    setPassword,
    submitting,
    pickReceiver,
    changeReceiver,
    goToConfirm,
    submitTransfer,
  };
}
