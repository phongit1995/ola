import { useEffect, useState } from 'react';
import i18n from 'i18next';
import { isItemExpired, isItemExpiringSoon, itemExpiryLabel, itemExpiryTickMs } from '../lib/itemExpiry';

export interface ItemExpiryState {
  label: string | null;
  soon: boolean;
}

export function useItemExpiry(expiresAt: string | null | undefined): ItemExpiryState {
  const [now, setNow] = useState(() => Date.now());
  const active = expiresAt != null && expiresAt !== '' && !isItemExpired(expiresAt, now);
  const tickMs = itemExpiryTickMs(expiresAt, now);

  useEffect(() => {
    if (!active) return;
    setNow(Date.now());
    const interval = setInterval(() => setNow(Date.now()), tickMs);
    return () => clearInterval(interval);
  }, [active, tickMs, expiresAt]);

  return { label: itemExpiryLabel(i18n.t, expiresAt, now), soon: isItemExpiringSoon(expiresAt, now) };
}
