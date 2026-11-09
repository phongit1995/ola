import { useEffect, useState } from 'react';
import type { TFunction } from 'i18next';
import { ApiError } from '../../lib/apiError';
import { toast } from '../../lib/toast';
import {
  parseVipDayTransferDays,
  vipDayTransferErrorText,
  vipDayTransferInputError,
  vipDayTransferMaxSenderDays,
  vipDayTransferReceiverDays,
} from '../../lib/vipDayTransfer';
import { VIP_DAY_TRANSFER_CONFIG_ERRORS } from '../../lib/vipPurchase.constants';
import { VipService } from '../../services/vip.service';
import { useAuthStore } from '../auth/authStore';
import { useVipDayTransferConfigStore } from './vipDayTransferConfigStore';

export type VipDayTransferForm = ReturnType<typeof useVipDayTransferForm>;

export function useVipDayTransferForm(t: TFunction) {
  const config = useVipDayTransferConfigStore((s) => s.config);
  const refreshConfig = useVipDayTransferConfigStore((s) => s.refresh);
  const vipEndTime = useAuthStore((s) => s.user?.vipEndTime);
  const refreshUser = useAuthStore((s) => s.refreshUser);

  const [daysText, setDaysText] = useState('');
  const [submitting, setSubmitting] = useState(false);

  const senderDays = parseVipDayTransferDays(daysText);
  const receiverDays = config != null ? vipDayTransferReceiverDays(config, senderDays) : 0;
  const maxSenderDays = vipDayTransferMaxSenderDays(vipEndTime);

  useEffect(() => {
    void refreshConfig();
  }, [refreshConfig]);

  function inputError(): string | null {
    if (config == null || !config.enabled) return t('vip.buy.errDayTransferDisabled');
    return vipDayTransferInputError(t, config, senderDays, vipEndTime);
  }

  async function refreshConfigAfterConfigError(error: unknown) {
    if (!(error instanceof ApiError) || !VIP_DAY_TRANSFER_CONFIG_ERRORS.includes(error.message)) return;
    await refreshConfig();
  }

  async function submit(toUsername: string, password: string): Promise<boolean> {
    if (submitting) return false;
    setSubmitting(true);
    try {
      const result = await VipService.transferDays({ toUsername, receiverDays, senderDays, password });
      await refreshUser();
      toast.success(
        t('vip.buy.transferredDays', {
          senderDays: result.senderDays,
          receiverDays: result.receiverDays,
          name: result.receiverUsername,
        }),
      );
      setDaysText('');
      return true;
    } catch (error) {
      toast.error(vipDayTransferErrorText(t, error));
      await refreshConfigAfterConfigError(error);
      return false;
    } finally {
      setSubmitting(false);
    }
  }

  return {
    config,
    daysText,
    setDaysText,
    senderDays,
    receiverDays,
    maxSenderDays,
    submitting,
    inputError,
    submit,
  };
}
