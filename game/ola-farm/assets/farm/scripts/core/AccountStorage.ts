import { DEVICE_FARM_OWNER_KEY } from './constants/SaveKeys';
import type { StoragePort } from './types/SaveTypes';

const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

/**
 * The Ola account named by an access token (`data.id` in the JWT payload). The signature is not checked:
 * the id only chooses which local save opens, and a forged token can only reach another local save.
 */
export function accountFromToken(token: string | null | undefined): string | null {
  const payload = token?.split('.')[1];
  if (!payload) return null;
  try {
    const base64 = payload
      .replace(/-/g, '+')
      .replace(/_/g, '/')
      .padEnd(Math.ceil(payload.length / 4) * 4, '=');
    const id = JSON.parse(atob(base64))?.data?.id;
    return typeof id === 'string' && UUID.test(id) ? id.toLowerCase() : null;
  } catch {
    return null;
  }
}

/**
 * Keeps each Ola account's farm apart on a shared device by suffixing every key with `@account`.
 * The farm saved before accounts were known goes to the first account that saves; later accounts start fresh.
 * Without an account (standalone play or no token) the device-wide keys are used as before.
 */
export function accountStorage(base: StoragePort, account: string | null): StoragePort {
  if (!account) return base;
  const owner = base.getItem(DEVICE_FARM_OWNER_KEY),
    inherits = owner === null || owner === account;
  let claimed = owner !== null;
  return {
    getItem: key => base.getItem(`${key}@${account}`) ?? (inherits ? base.getItem(key) : null),
    setItem: (key, value) => {
      base.setItem(`${key}@${account}`, value);
      if (claimed) return;
      base.setItem(DEVICE_FARM_OWNER_KEY, account);
      claimed = true;
    },
  };
}
