export const VIP_HISTORY_TABS = ['purchases', 'transfers'] as const;

export type VipHistoryTab = (typeof VIP_HISTORY_TABS)[number];

const VIP_HISTORY_SOURCE_KEYS = [
  'package',
  'purchase',
  'icon',
  'gift',
  'email_verify',
  'egg',
  'wheel',
  'admin',
  'gift_code',
  'day_transfer_out',
  'day_transfer_in',
] as const;

type VipHistorySourceKey = (typeof VIP_HISTORY_SOURCE_KEYS)[number];

export function vipHistorySourceKey(source: string): VipHistorySourceKey | 'other' {
  return (VIP_HISTORY_SOURCE_KEYS as readonly string[]).includes(source)
    ? (source as VipHistorySourceKey)
    : 'other';
}

export function vipHistoryIconTypeId(packageName: string): number | null {
  const match = /^VIP #(\d+)$/.exec(packageName);
  return match ? Number(match[1]) : null;
}
