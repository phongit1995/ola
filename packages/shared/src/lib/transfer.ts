import type { TFunction } from 'i18next';
import { HTTP_STATUS } from '../constants/http';
import { VIP_TRANSFER_BLOCKED_ERROR } from '../constants/relationship';
import type { TransferErrorKeys } from '../types/client/transfer.type';
import { toApiError } from './apiError';

const TRANSFER_AMOUNT_MAX_DIGITS = 12;

export function transferAmountDigits(value: string): string {
  return value.replace(/\D/g, '').slice(0, TRANSFER_AMOUNT_MAX_DIGITS);
}

export function transferErrorText(t: TFunction, error: unknown, keys: TransferErrorKeys): string {
  const apiError = toApiError(error);
  if (apiError.status === 0) return t(keys.network);
  if (apiError.status === HTTP_STATUS.unauthorized) return t(keys.unauthorized);
  if (keys.blocked != null && apiError.message === VIP_TRANSFER_BLOCKED_ERROR) {
    return t(keys.blocked);
  }
  if (apiError.status === HTTP_STATUS.forbidden) return t(keys.forbidden);
  return apiError.message;
}
