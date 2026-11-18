import type { KeyboardEvent, MouseEvent } from 'react';
import { useTranslation } from 'react-i18next';
import { cn, formatItemExpiryTime, itemExpiryExactText, toast, type LockableItem } from '@lib';
import { ITEM_GRANT_ICONS, type ItemGrantIconKind } from '@constants';
import { useItemExpiry } from '@ola/shared/stores/useItemExpiry';

export function ItemGrantIcon({ kind, className }: { kind: ItemGrantIconKind; className?: string }) {
  return (
    <img src={ITEM_GRANT_ICONS[kind]} alt="" aria-hidden="true" className={cn('h-3.5 w-3.5 shrink-0 object-contain opacity-55', className)} />
  );
}

export function ItemLockButton({ message, className }: { message: string; className?: string }) {
  const notify = (event: MouseEvent | KeyboardEvent) => {
    event.stopPropagation();
    toast.info(message);
  };
  return (
    <span
      role="button"
      tabIndex={0}
      aria-label={message}
      title={message}
      onClick={notify}
      onKeyDown={(event) => {
        if (event.key === 'Enter' || event.key === ' ') notify(event);
      }}
      className={cn('inline-flex shrink-0 cursor-pointer items-center p-0.5', className)}
    >
      <ItemGrantIcon kind="lock" />
    </span>
  );
}

export function ItemCountdown({ expiresAt, className }: { expiresAt?: string | null; className?: string }) {
  const { t } = useTranslation();
  const { label, soon } = useItemExpiry(expiresAt);
  if (label == null) return null;
  return (
    <span
      title={itemExpiryExactText(t, expiresAt) ?? undefined}
      className={cn('shrink-0 whitespace-nowrap tabular-nums text-black/54', soon && 'font-semibold text-ola-error', className)}
    >
      {label}
    </span>
  );
}

export function ItemExpiryText({ item }: { item: LockableItem }) {
  const { t } = useTranslation();
  const { label, soon } = useItemExpiry(item.expiresAt);
  if (label == null) return null;
  return (
    <span
      title={itemExpiryExactText(t, item.expiresAt) ?? undefined}
      className={cn(
        'flex w-full items-center justify-center gap-0.5 truncate text-[10px] tabular-nums text-black/54',
        soon && 'font-semibold text-ola-error'
      )}
    >
      <ItemGrantIcon kind="clock" className="h-2.5 w-2.5" />
      {label}
    </span>
  );
}

export function ItemExpiryNotice({ expiresAt }: { expiresAt?: string | null }) {
  const { t } = useTranslation();
  const { label } = useItemExpiry(expiresAt);
  const time = formatItemExpiryTime(expiresAt);
  if (label == null || time == null) return null;
  return (
    <span className="mt-2 flex items-center gap-1.5 rounded-md bg-ola-warning-soft px-2.5 py-1.5 text-[13px] tabular-nums text-ola-warning-ink">
      <ItemGrantIcon kind="clock" />
      <span>{t('itemExpiry.notice', { time, left: label })}</span>
    </span>
  );
}
