import { useCallback, useState } from 'react';
import i18n from 'i18next';
import { GIFT_CODE_EMAIL_NOT_VERIFIED_ERROR } from '../../constants/giftCode';
import { toApiError } from '../../lib/apiError';
import { giftCodeErrorText, normalizeGiftCodeInput } from '../../lib/giftCode';
import { GiftCodeService } from '../../services/giftCode.service';
import type { RedeemGiftCodeResult } from '../../types/api/giftCode.type';
import type {
  GiftCodeFailure,
  GiftCodeRedeem,
  GiftCodeRedeemOptions,
} from '../../types/client/giftCode.type';
import { useAuthStore } from '../auth/authStore';
import { useGiftCodeConfigStore } from './giftCodeConfigStore';

export type { GiftCodeRedeem, GiftCodeRedeemOptions } from '../../types/client/giftCode.type';

export function useGiftCodeRedeem({ onRedeemed }: GiftCodeRedeemOptions = {}): GiftCodeRedeem {
  const [code, setRawCode] = useState('');
  const [submitting, setSubmitting] = useState(false);
  const [failure, setFailure] = useState<GiftCodeFailure | null>(null);
  const [result, setResult] = useState<RedeemGiftCodeResult | null>(null);
  const emailRequired = useGiftCodeConfigStore((s) => s.config?.requireEmailVerified ?? false);
  const emailUnverified = useAuthStore((s) => s.user?.emailVerified === false);
  const emailRejected = failure?.code === GIFT_CODE_EMAIL_NOT_VERIFIED_ERROR;

  const setCode = useCallback((value: string) => {
    setRawCode(normalizeGiftCodeInput(value));
    setFailure(null);
  }, []);

  const submit = useCallback(async () => {
    if (submitting) return;
    if (code === '') {
      setFailure({ text: i18n.t('giftCode.errors.empty') });
      return;
    }
    setSubmitting(true);
    setFailure(null);
    try {
      const redeemed = await GiftCodeService.redeem(code);
      setResult(redeemed);
      setRawCode('');
      void useAuthStore.getState().refreshUser();
      onRedeemed?.(redeemed);
    } catch (err) {
      setFailure({ code: toApiError(err).code, text: giftCodeErrorText(i18n.t, err) });
    } finally {
      setSubmitting(false);
    }
  }, [code, onRedeemed, submitting]);

  const reset = useCallback(() => {
    setRawCode('');
    setFailure(null);
    setResult(null);
    setSubmitting(false);
  }, []);

  return {
    code,
    setCode,
    submitting,
    error: emailRejected ? null : (failure?.text ?? null),
    needsEmailVerify: emailRejected || (emailRequired && emailUnverified),
    result,
    canSubmit: code !== '' && !submitting,
    submit,
    reset,
  };
}
