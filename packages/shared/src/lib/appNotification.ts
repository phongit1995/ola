import type { TFunction } from 'i18next';
import { APP_NOTIFICATION_TYPE } from '../constants/notification';
import type { AppNotification, AppNotificationTransfer } from '../types/api/notification.type';
import type { TransferNotificationContent } from '../types/client/notification.type';
import { formatKen } from './number';
import { vipName } from './vip';

function positiveNumber(value: unknown): number | undefined {
  return typeof value === 'number' && Number.isFinite(value) && value > 0 ? value : undefined;
}

export function parseAppNotificationTransfer(preview: string | undefined): AppNotificationTransfer {
  if (preview == null || preview === '') return {};
  try {
    const raw: unknown = JSON.parse(preview);
    if (typeof raw !== 'object' || raw == null) return {};
    const record = raw as Record<string, unknown>;
    return {
      amount: positiveNumber(record.amount),
      vipTypeId: positiveNumber(record.vipTypeId),
      days: positiveNumber(record.days),
    };
  } catch {
    return {};
  }
}

export function isTransferNotification(type: string): boolean {
  return type === APP_NOTIFICATION_TYPE.kenReceived || type === APP_NOTIFICATION_TYPE.vipReceived;
}

export function transferNotificationContent(
  t: TFunction,
  item: AppNotification
): TransferNotificationContent | null {
  if (!isTransferNotification(item.type)) return null;
  const transfer = parseAppNotificationTransfer(item.preview);
  if (item.type === APP_NOTIFICATION_TYPE.kenReceived) {
    return transfer.amount != null
      ? { text: t('notify.msg_ken_amount', { amount: formatKen(transfer.amount) }), badge: { kind: 'ken' } }
      : { text: t('notify.msg_ken') };
  }
  if (transfer.vipTypeId != null) {
    return {
      text: t('notify.msg_vip_icon', { name: vipName(transfer.vipTypeId) }),
      badge: { kind: 'vip', vipTypeId: transfer.vipTypeId },
    };
  }
  if (transfer.days != null) {
    return { text: t('notify.msg_vip_days', { days: transfer.days }), badge: { kind: 'vip' } };
  }
  return { text: t('notify.msg_vip') };
}
