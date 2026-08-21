import type { TFunction } from 'i18next';
import { ApiError } from './apiError';

export const FORGOT_RESEND_COOLDOWN_SECONDS = 60;
export const FORGOT_CODE_LENGTH = 6;
export const FORGOT_CODE_PATTERN = /^\d{6}$/;

export function resolveForgotSendError(error: unknown, t: TFunction): string {
  if (error instanceof ApiError) {
    if (error.status === 0) return t('auth.errNetwork');
    if (error.status === 429 || /wait|limit/i.test(error.message)) {
      return t('forgot.errRateLimited');
    }
  }
  return t('forgot.errGeneric');
}

export function resolveForgotConfirmError(error: unknown, t: TFunction): string {
  if (error instanceof ApiError) {
    if (error.status === 0) return t('auth.errNetwork');
    if (error.status === 429) return t('forgot.errRateLimited');
    if (/attempts/i.test(error.message)) return t('forgot.errTooManyAttempts');
    if (/expired|not found/i.test(error.message)) return t('forgot.errCodeExpired');
    if (/invalid/i.test(error.message)) return t('forgot.errInvalidCode');
  }
  return t('forgot.errGeneric');
}
