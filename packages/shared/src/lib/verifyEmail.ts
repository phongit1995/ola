import type { VerifyEmailErrorKey } from '../types/client/verifyEmail.type';
import { ApiError } from './apiError';
import { EMAIL_UNAVAILABLE_STATUS } from './forgotPassword';

export function verifyEmailErrorKey(err: unknown): VerifyEmailErrorKey {
  if (!(err instanceof ApiError)) return 'verifyEmail.errGeneric';
  if (err.status === EMAIL_UNAVAILABLE_STATUS) return 'verifyEmail.errUnavailable';
  const msg = err.message.toLowerCase();
  if (msg.includes('domain')) return 'verifyEmail.errDomainNotAllowed';
  if (msg.includes('format')) return 'verifyEmail.errEmailInvalid';
  if (msg.includes('daily')) return 'verifyEmail.errDailyLimit';
  if (msg.includes('wait')) return 'verifyEmail.errCooldown';
  if (msg.includes('already exists')) return 'verifyEmail.errTaken';
  if (msg.includes('too many')) return 'verifyEmail.errTooMany';
  if (msg.includes('expired') || msg.includes('invalid verification request')) {
    return 'verifyEmail.errCodeExpired';
  }
  if (msg.includes('invalid verification code')) return 'verifyEmail.errCodeInvalid';
  return 'verifyEmail.errGeneric';
}
