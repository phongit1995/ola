import type { TFunction } from 'i18next';
import type { UsernameChangeTier } from '../types/api/settings.type';
import { ApiError } from './apiError';
import { NICKNAME_MIN, USERNAME_MAX, USERNAME_PATTERN } from './username.constants';

export function normalizeNickname(value: string): string {
  return value.trim().toLowerCase().replace(/^@/, '');
}

export function isValidNickname(nickname: string): boolean {
  return (
    nickname.length >= NICKNAME_MIN &&
    nickname.length <= USERNAME_MAX &&
    USERNAME_PATTERN.test(nickname)
  );
}

export function isNicknameChangeDisabledError(err: unknown): boolean {
  return err instanceof ApiError && /disabled/i.test(err.message);
}

export function nicknameTierLabel(
  t: TFunction,
  tier: UsernameChangeTier,
  next: UsernameChangeTier | undefined
): string {
  if (!next) return t('changeNickname.tierLabelPlus', { n: tier.minLength });
  const upper = next.minLength - 1;
  if (upper === tier.minLength) {
    return t('changeNickname.tierLabel', { n: tier.minLength });
  }
  return t('changeNickname.tierRange', { from: tier.minLength, to: upper });
}
