import { useEffect, useState } from 'react';
import i18n from 'i18next';
import { toast } from '../../lib/toast';
import { transferErrorText } from '../../lib/transfer';
import { isVipIconTransferable } from '../../lib/giftCode';
import { VipService } from '../../services/vip.service';
import type { VipIconInstance } from '../../types/api/vip.type';
import type { TransferPickStep, TransferTarget } from '../../types/client/transfer.type';

const TRADING_VIP_STORE_LIMIT = 100;

interface UseTradingVipOptions {
  receiver: TransferTarget;
  enabled: boolean;
  onDone: () => void;
}

export function useTradingVip({ receiver, enabled, onDone }: UseTradingVipOptions) {
  const [step, setStep] = useState<TransferPickStep>('select');
  const [loading, setLoading] = useState(true);
  const [vips, setVips] = useState<VipIconInstance[]>([]);
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [password, setPassword] = useState('');
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    if (!enabled) return;
    let active = true;
    setLoading(true);
    VipService.store({ limit: TRADING_VIP_STORE_LIMIT })
      .then((res) => {
        if (!active) return;
        setVips(
          res.items.filter(
            (item) => !item.isUsing && !item.isLocked && isVipIconTransferable(item)
          )
        );
      })
      .catch(() => undefined)
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, [enabled]);

  const selected = vips.find((item) => item.instanceId === selectedId) ?? null;

  function pickVip(instanceId: string) {
    setSelectedId(instanceId);
    setStep('confirm');
  }

  async function submitTransfer() {
    if (selected == null) {
      toast.error(i18n.t('chat.tradingVipErrSelect'));
      return;
    }
    if (password.trim() === '') {
      toast.error(i18n.t('chat.tradingVipErrPassword'));
      return;
    }
    if (receiver.id === '') {
      toast.error(i18n.t('chat.actionError'));
      return;
    }
    setSubmitting(true);
    try {
      await VipService.transferIcon(selected.instanceId, { toUserId: receiver.id, password });
      toast.success(i18n.t('chat.tradingVipSuccess', { name: receiver.name }));
      onDone();
    } catch (error) {
      toast.error(
        transferErrorText(i18n.t, error, {
          network: 'chat.tradingVipError',
          unauthorized: 'chat.tradingVipErrWrongPassword',
          blocked: 'chat.tradingVipErrBlocked',
          forbidden: 'chat.tradingVipErrNotAllowed',
        })
      );
    } finally {
      setSubmitting(false);
    }
  }

  return {
    step,
    setStep,
    loading,
    vips,
    selected,
    pickVip,
    password,
    setPassword,
    submitting,
    submitTransfer,
  };
}
