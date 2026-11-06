import type { TFunction } from 'i18next';
import { APP_NOTIFICATION_TYPE } from '../constants/notification';
import type { AppNotification } from '../types/api/notification.type';
import type { TransferNotificationContent } from '../types/client/notification.type';
import { formatKen } from './number';
import { vipName } from './vip';

export function isTransferNotification(type: string): boolean {
  return type === APP_NOTIFICATION_TYPE.kenReceived || type === APP_NOTIFICATION_TYPE.vipReceived;
}

export function transferNotificationContent(
  t: TFunction,
  item: AppNotification
): TransferNotificationContent | null {
  if (!isTransferNotification(item.type)) return null;
  const transfer = item.transfer ?? {};
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
