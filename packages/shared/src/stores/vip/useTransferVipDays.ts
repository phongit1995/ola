import { useEffect, useState } from 'react';
import i18n from 'i18next';
import { toast } from '../../lib/toast';
import { transferErrorText } from '../../lib/transfer';
import { VipService } from '../../services/vip.service';
import type { VipPackageItem } from '../../types/api/vip.type';
import type { TransferPickStep, TransferTarget } from '../../types/client/transfer.type';
import { useAuthStore } from '../auth/authStore';

interface UseTransferVipDaysOptions {
  receiver: TransferTarget;
  enabled: boolean;
  onDone: () => void;
}

export function useTransferVipDays({ receiver, enabled, onDone }: UseTransferVipDaysOptions) {
  const balance = useAuthStore((s) => s.user?.ken ?? 0);
  const setUser = useAuthStore((s) => s.setUser);

  const [step, setStep] = useState<TransferPickStep>('select');
  const [loading, setLoading] = useState(true);
  const [packages, setPackages] = useState<VipPackageItem[]>([]);
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [password, setPassword] = useState('');
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    if (!enabled) return;
    let active = true;
    setLoading(true);
    VipService.listPackages()
      .then((res) => {
        if (!active) return;
        setPackages(res.items);
        setSelectedId((current) => current ?? res.items[0]?.id ?? null);
      })
      .catch(() => undefined)
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, [enabled]);

  const selected = packages.find((item) => item.id === selectedId) ?? null;

  function goToConfirm() {
    if (selected == null) {
      toast.error(i18n.t('chat.transferVipDaysErrSelect'));
      return;
    }
    if (selected.kenPrice > balance) {
      toast.error(i18n.t('chat.transferVipDaysErrNotEnough'));
      return;
    }
    setStep('confirm');
  }

  async function submitGift() {
    if (selected == null || receiver.username == null || receiver.username === '') {
      toast.error(i18n.t('chat.actionError'));
      return;
    }
    if (password.trim() === '') {
      toast.error(i18n.t('chat.transferVipDaysErrPassword'));
      return;
    }
    setSubmitting(true);
    try {
      const result = await VipService.giftPackage(selected.id, receiver.username, password);
      const current = useAuthStore.getState().user;
      if (current != null) setUser({ ...current, ken: result.kenBalance });
      toast.success(
        i18n.t('chat.transferVipDaysSuccess', { days: result.days, name: receiver.name })
      );
      onDone();
    } catch (error) {
      toast.error(
        transferErrorText(i18n.t, error, {
          network: 'chat.transferVipDaysError',
          unauthorized: 'chat.transferVipDaysErrWrongPassword',
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
    loading,
    packages,
    selected,
    selectedId,
    setSelectedId,
    password,
    setPassword,
    submitting,
    goToConfirm,
    submitGift,
  };
}
